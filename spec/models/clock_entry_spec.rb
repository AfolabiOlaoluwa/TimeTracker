# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClockEntry, type: :model do
  let(:subject) { build(:clock_entry) }
  let(:user) { FactoryBot.create(:user) }

  it 'is valid from the factory' do
    expect(subject).to be_valid
  end

  describe 'association' do
    it { is_expected.to belong_to(:user).class_name('User') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:purpose) }
  end

  it 'is not valid without a user' do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a purpose' do
    subject.purpose = nil
    expect(subject).to_not be_valid
  end

  describe '#set_time_in' do
    it 'defaults to nil if time_in is not set' do
      subject.time_in = nil
      expect(subject.time_in).to eq nil
    end

    it 'sets current time to time_in field if user clock in' do
      subject.time_in = Time.now
      expect(subject.set_time_in).to be_within(1.second).of Time.now
    end
  end
end