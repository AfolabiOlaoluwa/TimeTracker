# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:subject) { build(:user) }

  it 'is valid from the factory' do
    expect(subject).to be_valid
  end

  describe 'association' do
    it { is_expected.to have_many(:clock_entries) }
    it { is_expected.to have_many(:active_clock_entries).class_name('ClockEntry') }
    it { is_expected.to have_many(:inactive_clock_entries).class_name('ClockEntry') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  it 'is not valid without an email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a password' do
    subject.password = nil
    expect(subject).to_not be_valid
  end
end