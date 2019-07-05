# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Fam::Family::Relationship do
  let(:child_name) { 'Sue Saget' }
  let(:parent_name) { 'Bob Saget' }

  describe '.from_h' do
    let(:input_hash) do
      {
        child_name: child_name,
        parent_name: parent_name,
      }
    end

    it 'should create a relationship from a hash' do
      expect(described_class.from_h(input_hash)).to_not be_nil
    end

    it 'should set the name of the child' do
      expect(described_class.from_h(input_hash).child_name).to eq child_name
    end

    it 'should set the name of the parent' do
      expect(described_class.from_h(input_hash).parent_name).to eq parent_name
    end
  end

  subject { described_class.new(child_name: child_name, parent_name: parent_name) }

  it 'should set the child name' do
    expect(subject.child_name).to eq child_name
  end

  it 'should set the parent name' do
    expect(subject.parent_name).to eq parent_name
  end

  it 'should return a hash with child and parent names' do
    expect(subject.to_h).to include(
      child_name: child_name,
      parent_name: parent_name
    )
  end

  describe 'Comparable' do
    context 'child names are different, parent names are the same' do
      let(:name_starting_with_a) { described_class.new(child_name: 'Albert', parent_name: 'Bill') }
      let(:name_starting_with_b) { described_class.new(child_name: 'Betty', parent_name: 'Bill') }
      let(:name_starting_with_c) { described_class.new(child_name: 'Clint', parent_name: 'Bill') }

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

    context 'child names are the same, parent names are different' do
      let(:name_starting_with_a) { described_class.new(child_name: 'Bill', parent_name: 'Albert') }
      let(:name_starting_with_b) { described_class.new(child_name: 'Bill', parent_name: 'Betty') }
      let(:name_starting_with_c) { described_class.new(child_name: 'Bill', parent_name: 'Clint') }

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

    context 'child names are different, parent names are different' do
      let(:name_starting_with_a) do
        described_class.new(child_name: 'Wanda', parent_name: 'Albert')
      end
      let(:name_starting_with_b) { described_class.new(child_name: 'Bill', parent_name: 'Betty') }
      let(:name_starting_with_c) { described_class.new(child_name: 'Bill', parent_name: 'Clint') }

      it 'should be comparable by name (with child names coming first)' do
        expect(name_starting_with_a <=> name_starting_with_b).to eq(1)
      end

      it 'should be sortable by the child names first' do
        expect(
          [
            name_starting_with_c,
            name_starting_with_a,
            name_starting_with_b,
          ].sort
        ).to eq(
          [
            name_starting_with_b,
            name_starting_with_c,
            name_starting_with_a,
          ]
        )
      end
    end
  end
end
