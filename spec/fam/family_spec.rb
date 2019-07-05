# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Fam::Family do
  describe '.from_h' do
    let(:people) { [] }
    let(:relationships) { [] }
    let(:input_hash) do
      { people: people, relationships: relationships }
    end

    context 'people is not an array' do
      let(:people) { nil }
      it 'should raise' do
        expect { described_class.from_h(input_hash) }.to raise_error(NoMethodError)
      end
    end

    context 'relationships is not an array' do
      let(:relationships) { nil }
      it 'should raise' do
        expect { described_class.from_h(input_hash) }.to raise_error(NoMethodError)
      end
    end

    context 'empty people and relationships' do
      it 'should create a family' do
        expect(described_class.from_h(input_hash)).to_not be_nil
      end
    end

    context 'people and relationships' do
      let(:person1) { Hash[name: 'Albert'] }
      let(:person2) { Hash[name: 'Betty'] }
      let(:person3) { Hash[name: 'Clint'] }
      let(:people) { [person1, person2, person3] }

      let(:relationship1) { Hash[child_name: 'Albert', parent_name: 'Betty'] }
      let(:relationship2) { Hash[child_name: 'Albert', parent_name: 'Clint'] }
      let(:relationships) { [relationship1, relationship2] }

      it 'should create a family' do
        expect(described_class.from_h(input_hash)).to_not be_nil
      end

      it 'should have 3 people' do
        expect(described_class.from_h(input_hash).to_h[:people].size).to eq 3
      end

      it 'should have 2 relationships' do
        expect(described_class.from_h(input_hash).to_h[:relationships].size).to eq 2
      end
    end
  end

  let(:person1) { Fam::Family::Person.new(name: 'Albert') }
  let(:person2) { Fam::Family::Person.new(name: 'Betty') }
  let(:person3) { Fam::Family::Person.new(name: 'Clint') }
  let(:people) { [person1, person2, person3] }

  let(:relationship1) { Fam::Family::Relationship.new(child_name: 'Albert', parent_name: 'Betty') }
  let(:relationship2) { Fam::Family::Relationship.new(child_name: 'Albert', parent_name: 'Clint') }
  let(:relationships) { [relationship1, relationship2] }

  subject(:family) { described_class.new(people: people, relationships: relationships) }

  it 'should create a family' do
    expect(family).to_not be_nil
  end

  it 'should return an inspection with people numbers' do
    expect(family.inspect).to eq '#<Fam::Family with 3 members>'
  end

  describe '#to_h' do
    it 'should return a hash with people and relationships' do
      expect(family.to_h.keys).to include(:people, :relationships)
    end

    it 'should return people as a hash' do
      expect(family.to_h[:people].first).to include(name: 'Albert')
    end

    it 'should return relationships as a hash' do
      expect(family.to_h[:relationships].first).to include(
        child_name: 'Albert',
        parent_name: 'Betty'
      )
    end
  end

  describe '#people' do
    it 'should return same number of people' do
      expect(family.people.size).to eq 3
    end

    it 'should return person types' do
      expect(family.people.first).to be_instance_of(Fam::Family::Person)
    end
  end

  describe '#get_person' do
    it 'should return person by name' do
      expect(family.get_person('Albert')).to eq person1
    end

    it 'should return error if person does not exist in family' do
      expect { family.get_person('Arya') }.to raise_error(Fam::Family::Errors::NoSuchPerson)
    end
  end

  describe '#add_person' do
    it 'should add a person to the family' do
      new_person = Fam::Family::Person.new(name: 'Sally')
      subject.add_person(new_person)
      expect(family.people.size).to eq 4
    end

    it 'should raise if passing in a string' do
      expect { family.add_person('Sally') }.to raise_error(NoMethodError)
    end

    it 'should raise if creating a duplicate person in the family' do
      new_person = Fam::Family::Person.new(name: 'Clint')
      expect { family.add_person(new_person) }.to raise_error(
        Fam::Family::Errors::DuplicatePerson
      )
    end
  end

  describe '#include?' do
    it 'should return true if passing a name of a family member' do
      expect(family.include?('Albert')).to eq true
    end

    it 'should return false if passing a name of someone not in the family' do
      expect(family.include?('Arya')).to eq false
    end

    it 'should always return false if passing a Person' do
      expect(family.include?(Fam::Family::Person.new(name: 'Clint'))).to eq false
    end
  end

  describe '#add_parent' do
    let(:danielle) { Fam::Family::Person.new(name: 'Danielle') }

    before do
      family.add_person(danielle)
    end

    it 'should raise if passing in strings' do
      expect { family.add_parent(parent: 'Bob', child: 'Alice') }.to raise_error(NoMethodError)
    end

    it 'should raise if parent is not found' do
      parent = Fam::Family::Person.new(name: 'Arya')
      child = Fam::Family::Person.new(name: 'Clint')

      expect { family.add_parent(parent: parent, child: child) }.to raise_error(
        Fam::Family::Errors::NoSuchPerson
      )
    end

    it 'should raise if child is not found' do
      parent = Fam::Family::Person.new(name: 'Clint')
      child = Fam::Family::Person.new(name: 'Arya')

      expect { family.add_parent(parent: parent, child: child) }.to raise_error(
        Fam::Family::Errors::NoSuchPerson
      )
    end

    context 'existing relationship' do
      it 'returns the parent' do
        parent = Fam::Family::Person.new(name: 'Clint')
        child = Fam::Family::Person.new(name: 'Albert')

        expect(family.add_parent(parent: parent, child: child)).to eq parent
      end

      it 'does not add a new relationship' do
        parent = Fam::Family::Person.new(name: 'Clint')
        child = Fam::Family::Person.new(name: 'Albert')

        family.add_parent(parent: parent, child: child)
        # no change in number
        expect(family.to_h[:relationships].size).to eq 2
      end
    end

    context 'has 2 parents already' do
      it 'should raise error' do
        # Reminder that in the setup Albert has 2 parents
        child = Fam::Family::Person.new(name: 'Albert')

        expect { family.add_parent(parent: danielle, child: child) }.to raise_error(
          Fam::Family::Errors::ExcessParents
        )
      end
    end

    it 'should add a relationship' do
      child = Fam::Family::Person.new(name: 'Clint')
      family.add_parent(parent: danielle, child: child)
      # +1 change (for some reason the change helper wasnt working)
      expect(family.to_h[:relationships].size).to eq 3
    end

    it 'should add a relationship with parent and child' do
      child = Fam::Family::Person.new(name: 'Clint')
      family.add_parent(parent: danielle, child: child)
      expect(family.to_h[:relationships].last.to_h).to include(
        parent_name: 'Danielle',
        child_name: 'Clint'
      )
    end

    it 'should return the parent' do
      child = Fam::Family::Person.new(name: 'Clint')
      expect(family.add_parent(parent: danielle, child: child)).to eq danielle
    end
  end

  describe '#get_parents' do
    it 'should raise error when passed a string' do
      expect { family.get_parents('Albert') }.to raise_error(NoMethodError)
    end

    it 'should return parents when there are some' do
      expect(family.get_parents(Fam::Family::Person.new(name: 'Albert')).size).to eq 2
    end

    it 'should return no parents when there are none' do
      expect(family.get_parents(Fam::Family::Person.new(name: 'Clint')).size).to eq 0
    end

    it 'should return parents of Person type' do
      expect(family.get_parents(Fam::Family::Person.new(name: 'Albert')).first).to be_instance_of(
        Fam::Family::Person
      )
    end
  end

  describe '#get_grandparents' do
    let(:danielle) { Fam::Family::Person.new(name: 'Danielle') }
    let(:clint) { Fam::Family::Person.new(name: 'Clint') }
    let(:dave) { Fam::Family::Person.new(name: 'Dawn') }
    let(:ethel) { Fam::Family::Person.new(name: 'Ethel') }
    let(:evan) { Fam::Family::Person.new(name: 'Evan') }
    let(:albert) { Fam::Family::Person.new(name: 'Albert') }

    # Setting up a simple family tree with grandparents and greatgrandparents
    before { family.add_person(danielle) }
    before { family.add_person(dave) }
    before { family.add_person(ethel) }
    before { family.add_person(evan) }
    before { family.add_parent(parent: danielle, child: clint) }
    before { family.add_parent(parent: dave, child: clint) }
    before { family.add_parent(parent: evan, child: dave) }
    before { family.add_parent(parent: ethel, child: danielle) }

    it 'should raise error when passed a string' do
      expect { family.get_grandparents('Albert') }.to raise_error(NoMethodError)
    end

    it 'should get grandparents with no greatness by default' do
      expect(family.get_grandparents(albert)).to eq([danielle, dave])
    end

    it 'should get grandparents with 0 greatness' do
      expect(family.get_grandparents(albert, greatness: 0)).to eq([danielle, dave])
    end

    it 'should get just great-grandparents with 1 greatness' do
      expect(family.get_grandparents(albert, greatness: 1)).to eq([ethel, evan])
    end

    it 'should get just great-great-grandparents with 2 greatness' do
      expect(family.get_grandparents(albert, greatness: 2)).to be_empty
    end
  end
end
