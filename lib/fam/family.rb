# frozen_string_literal: true

require 'fam/family/person'
require 'fam/family/person_list'
require 'fam/family/relationship'
require 'fam/family/relationship_list'

module Fam
  class Family
    module Errors
      class NoSuchPerson < Exception; end
      class DuplicatePerson < Exception; end
      class ExcessParents < Exception; end
    end

    MAX_PARENTS = 2

    def self.from_h(people:, relationships:)
      people = people.map { |person| Fam::Family::Person.from_h(person) }
      relationships = relationships.map { |relationship| Fam::Family::Relationship.from_h(relationship) }
      new(people: people, relationships: relationships)
    end

    def initialize(people:, relationships:)
      @people = Fam::Family::PersonList.new(people: people)
      @relationships = Fam::Family::RelationshipList.new(relationships: relationships)
    end

    def people
      @people.to_a
    end

    def relationships
      @relationships.to_a
    end

    def to_h
      {
        people: people.map(&:to_h),
        relationships: relationships.map(&:to_h)
      }
    end

    def inspect
      "#<#{self.class} with #{people.length} members>"
    end

    def get_person(name)
      raise Errors::NoSuchPerson, name unless include?(name)

      @people.get_person_by_name(name)
    end

    def include?(name)
      return false if name.is_a? Fam::Family::Person

      @people.includes_name?(name)
    end

    def add_person(person)
      raise Errors::DuplicatePerson if include?(person.name)

      @people.insert_person(person)
    end

    def add_parent(parent:, child:)
      raise NoMethodError unless parent.is_a? Fam::Family::Person
      raise NoMethodError unless child.is_a? Fam::Family::Person

      return parent if @relationships.include?(parent: parent, child: child)

      raise Errors::ExcessParents if has_max_parents?(child)

      child = get_person(child.name)
      get_person(parent.name).tap do |parent|
        @relationships.add_relationship(child_name: child.name, parent_name: parent.name)
      end
    end

    def get_parents(person)
      raise NoMethodError unless person.is_a? Fam::Family::Person

      @relationships.get_parent_names(person.name).map(&method(:get_person))
    end

    def get_children(person)
      raise NoMethodError unless person.is_a? Fam::Family::Person

      @relationships.get_child_names(person.name).map(&method(:get_person))
    end

    def get_grandparents(person, greatness: 0)
      raise NoMethodError unless person.is_a? Fam::Family::Person

      grandparent_names = @relationships.get_grandparent_names(person.name, greatness: greatness)
      grandparent_names.map(&method(:get_person))
    end

    private

    def has_max_parents?(person)
      get_parents(person).length == MAX_PARENTS
    end
  end
end
