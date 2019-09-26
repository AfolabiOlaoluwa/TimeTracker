# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClockEntryPresenter do
  subject { ClockEntryPresenter.new(clock_entry, clock_entry) }

  describe '#date' do
    let(:clock_entry) { double(created_at: DateTime.now) }

    it 'returns Date' do
      expect(subject.date).to eq clock_entry.created_at.strftime('%F')
    end
  end

  describe '#day_of_the_month' do
    let(:clock_entry) { double(created_at: DateTime.now) }

    it 'return Wednesday' do
      expect(subject.day_of_the_month).to eq clock_entry.created_at.strftime('%A')
    end
  end

  describe '#time_in' do
    context 'when time_in is nil' do
      let(:clock_entry) { double(time_in: nil) }

      it 'returns nil' do
        expect(subject.time_in).to eq clock_entry.time_in
      end
    end

    context 'when time_in is not ni' do
      let(:clock_entry) { double(time_in: DateTime.now) }

      it 'returns the time_in' do
        expect(subject.time_in).to eq clock_entry.time_in.strftime('%T %p')
      end
    end
  end

  describe '#time_out' do
    context 'when time_out is nil' do
      let(:clock_entry) { double(time_out: nil) }

      it 'returns nil' do
        expect(subject.time_out).to eq clock_entry.time_out
      end
    end

    context 'when time_out is not nil' do
      let(:clock_entry) { double(time_out: DateTime.now) }

      it 'returns the time_out' do
        expect(subject.time_out).to eq clock_entry.time_out.strftime('%T %p')
      end
    end
  end

  describe '#total_time_used' do
    context 'when time_out is nil' do
      let(:clock_entry) { double(time_out: nil) }

      it 'returns nil' do
        expect(subject.time_out).to eq clock_entry.time_out
      end
    end

    context 'when time_out is not nil' do
      let(:clock_entry) { double(time_in: Time.now, time_out: Time.now + 10) }
      let(:time_difference) { double(value: (clock_entry.time_out - clock_entry.time_in)) }

      it 'returns total time used for an event' do
        expect(subject.total_time_used).to eq Time.at(time_difference.value).utc.strftime('%H:%M:%S')
      end
    end
  end
end