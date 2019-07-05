# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Fam::Family::Person do
  let(:name) { 'Bob Saget' }

  describe '.from_h' do
    let(:input_hash) do
      { name: name }
    end

    it 'should create a person from a hash' do
      expect(described_class.from_h(input_hash)).to_not be_nil
    end

    it 'should set the name of the person' do
      expect(described_class.from_h(input_hash).name).to eq name
    end
  end

  subject { described_class.new(name: name) }

  it 'should set the name' do
    expect(subject.name).to eq name
  end

  it 'should return a hash with name' do
    expect(subject.to_h).to include(name: name)
  end

  describe 'Comparable' do
    let(:name_starting_with_a) { described_class.new(name: 'Albert') }
    let(:name_starting_with_b) { described_class.new(name: 'Betty') }
    let(:name_starting_with_c) { described_class.new(name: 'Clint') }

    it 'should be comparable by name' do
      expect(name_starting_with_a <=> name_starting_with_b).to eq(-1)
    end

    it 'should be sortable' do
      expect(
        [
          name_starting_with_c,
          name_starting_with_a,
          name_starting_with_b,
        ].sort
      ).to eq(
        [
          name_starting_with_a,
          name_starting_with_b,
          name_starting_with_c,
        ]
      )
    end
  end
end
