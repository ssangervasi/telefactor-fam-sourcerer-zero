# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Fam do
  include_context 'tempdir'

  let(:input_pathname) { tempdir_pathname.join('family-in.json') }
  let(:output_pathname) { tempdir_pathname.join('family-out.json') }

  describe '.add_person' do
    it 'should return success' do
      expect(
        described_class.add_person(
          input_path: input_pathname,
          output_path: output_pathname,
          person_name: 'Albert'
        )
      ).to be_success
    end

    it 'should return success message' do
      expect(
        described_class.add_person(
          input_path: input_pathname,
          output_path: output_pathname,
          person_name: 'Albert'
        ).output
      ).to eq 'Added person: Albert'
    end

    it 'should return Result type' do
      expect(
        described_class.add_person(
          input_path: input_pathname,
          output_path: output_pathname,
          person_name: 'Albert'
        )
      ).to be_instance_of(Fam::CLI::Result)
    end

    it 'should write result to output path' do
      described_class.add_person(
        input_path: input_pathname,
        output_path: output_pathname,
        person_name: 'Albert'
      )
      expect(File.read(output_pathname)).to eq <<~JSON.chomp
        {
          "people": [
            {
              "name": "Albert"
            }
          ],
          "relationships": [

          ]
        }
      JSON
    end

    it 'should read & write result to output path' do
      existing_family = <<~JSON.chomp
        {
          "people": [
            {
              "name": "Betty"
            }
          ],
          "relationships": [

          ]
        }
      JSON
      File.open(input_pathname, 'w') { |f| f.write(existing_family) }

      described_class.add_person(
        input_path: input_pathname,
        output_path: output_pathname,
        person_name: 'Albert'
      )
      expect(File.read(output_pathname)).to eq <<~JSON.chomp
        {
          "people": [
            {
              "name": "Betty"
            },
            {
              "name": "Albert"
            }
          ],
          "relationships": [

          ]
        }
      JSON
    end
  end

  describe '.add_parents' do
    before do
      existing_family = <<~JSON.chomp
        {
          "people": [
            {
              "name": "Albert"
            },
            {
              "name": "Beth"
            },
            {
              "name": "Bill"
            }
          ],
          "relationships": [

          ]
        }
      JSON
      File.open(input_pathname, 'w') { |f| f.write(existing_family) }
    end

    it 'should return success' do
      expect(
        described_class.add_parents(
          input_path: input_pathname,
          output_path: output_pathname,
          child_name: 'Albert',
          parent_names: %w[Beth Bill]
        )
      ).to be_success
    end

    it 'should return success message' do
      expect(
        described_class.add_parents(
          input_path: input_pathname,
          output_path: output_pathname,
          child_name: 'Albert',
          parent_names: %w[Beth Bill]
        ).output
      ).to eq('Added Beth & Bill as parents of Albert')
    end

    it 'should return Result type' do
      expect(
        described_class.add_parents(
          input_path: input_pathname,
          output_path: output_pathname,
          child_name: 'Albert',
          parent_names: %w[Beth Bill]
        )
      ).to be_instance_of(Fam::CLI::Result)
    end

    it 'should write data to the output path' do
      described_class.add_parents(
        input_path: input_pathname,
        output_path: output_pathname,
        child_name: 'Albert',
        parent_names: %w[Beth Bill]
      )
      expect(File.read(output_pathname)).to_not be_empty
    end

    context 'invalid child name' do
      it 'should return failure' do
        expect(
          described_class.add_parents(
            input_path: input_pathname,
            output_path: output_pathname,
            child_name: 'Billy',
            parent_names: %w[Beth Bill]
          )
        ).to be_failure
      end

      it 'should return failure message' do
        expect(
          described_class.add_parents(
            input_path: input_pathname,
            output_path: output_pathname,
            child_name: 'Billy',
            parent_names: %w[Beth Bill]
          ).error
        ).to eq "No such person 'Billy' in family '#{input_pathname}'!"
      end
    end

    context 'invalid parent name' do
      it 'should return failure' do
        expect(
          described_class.add_parents(
            input_path: input_pathname,
            output_path: output_pathname,
            child_name: 'Albert',
            parent_names: %w[Beth Clint]
          )
        ).to be_failure
      end

      it 'should return failure message' do
        expect(
          described_class.add_parents(
            input_path: input_pathname,
            output_path: output_pathname,
            child_name: 'Albert',
            parent_names: %w[Beth Clint]
          ).error
        ).to eq "No such person 'Clint' in family '#{input_pathname}'!"
      end
    end

    context 'too many parents' do
      before do
        existing_family = <<~JSON.chomp
          {
            "people": [
              {
                "name": "Albert"
              },
              {
                "name": "Beth"
              },
              {
                "name": "Bill"
              },
              {
                "name": "Bob"
              }
            ],
            "relationships": [
              {
                "child_name": "Albert",
                "parent_name": "Beth"
              },
              {
                "child_name": "Albert",
                "parent_name": "Bill"
              }
            ]
          }
        JSON
        File.open(input_pathname, 'w') { |f| f.write(existing_family) }
      end

      it 'should return failure' do
        expect(
          described_class.add_parents(
            input_path: input_pathname,
            output_path: output_pathname,
            child_name: 'Albert',
            parent_names: %w[Bob]
          )
        ).to be_failure
      end

      it 'should return failure message' do
        expect(
          described_class.add_parents(
            input_path: input_pathname,
            output_path: output_pathname,
            child_name: 'Albert',
            parent_names: %w[Bob]
          ).error
        ).to eq "Child 'Albert' can't have more than 2 parents!"
      end
    end
  end

  describe '.get_person' do
    before do
      existing_family = <<~JSON.chomp
        {
          "people": [
            {
              "name": "Albert"
            },
            {
              "name": "Beth"
            },
            {
              "name": "Bill"
            }
          ],
          "relationships": [

          ]
        }
      JSON
      File.open(input_pathname, 'w') { |f| f.write(existing_family) }
    end

    it 'should return success' do
      expect(
        described_class.get_person(
          input_path: input_pathname,
          person_name: 'Albert'
        )
      ).to be_success
    end

    it 'should return output' do
      expect(
        described_class.get_person(
          input_path: input_pathname,
          person_name: 'Albert'
        ).output
      ).to eq 'Albert'
    end

    it 'should return Result type' do
      expect(
        described_class.get_person(
          input_path: input_pathname,
          person_name: 'Albert'
        )
      ).to be_instance_of(Fam::CLI::Result)
    end

    context 'invalid name' do
      it 'should return failure' do
        expect(
          described_class.get_person(
            input_path: input_pathname,
            person_name: 'Billy'
          )
        ).to be_failure
      end

      it 'should return failure message' do
        expect(
          described_class.get_person(
            input_path: input_pathname,
            person_name: 'Billy'
          ).error
        ).to eq "No such person 'Billy' in family '#{input_pathname}'"
      end
    end
  end

  describe '.get_parents' do
    before do
      existing_family = <<~JSON.chomp
        {
          "people": [
            {
              "name": "Albert"
            },
            {
              "name": "Beth"
            },
            {
              "name": "Bill"
            }
          ],
          "relationships": [
            {
              "child_name": "Albert",
              "parent_name": "Beth"
            },
            {
              "child_name": "Albert",
              "parent_name": "Bill"
            }
          ]
        }
      JSON
      File.open(input_pathname, 'w') { |f| f.write(existing_family) }
    end

    it 'should return success' do
      expect(
        described_class.get_parents(
          input_path: input_pathname,
          child_name: 'Albert'
        )
      ).to be_success
    end

    it 'should return output' do
      expect(
        described_class.get_parents(
          input_path: input_pathname,
          child_name: 'Albert'
        ).output
      ).to eq "Beth\nBill"
    end

    it 'should return Result type' do
      expect(
        described_class.get_parents(
          input_path: input_pathname,
          child_name: 'Albert'
        )
      ).to be_instance_of(Fam::CLI::Result)
    end

    context 'invalid name' do
      it 'should return failure' do
        expect(
          described_class.get_parents(
            input_path: input_pathname,
            child_name: 'Billy'
          )
        ).to be_failure
      end

      it 'should return failure message' do
        expect(
          described_class.get_parents(
            input_path: input_pathname,
            child_name: 'Billy'
          ).error
        ).to eq "No child named 'Billy' in family '#{input_pathname}'!"
      end
    end
  end

  describe '.get_grandparents' do
    before do
      existing_family = <<~JSON.chomp
        {
          "people": [
            {
              "name": "Albert"
            },
            {
              "name": "Beth"
            },
            {
              "name": "Bill"
            },
            {
              "name": "Clint"
            },
            {
              "name": "Dave"
            }
          ],
          "relationships": [
            {
              "child_name": "Albert",
              "parent_name": "Beth"
            },
            {
              "child_name": "Albert",
              "parent_name": "Bill"
            },
            {
              "child_name": "Bill",
              "parent_name": "Clint"
            },
            {
              "child_name": "Clint",
              "parent_name": "Dave"
            }
          ]
        }
      JSON
      File.open(input_pathname, 'w') { |f| f.write(existing_family) }
    end

    it 'should return success' do
      expect(
        described_class.get_grandparents(
          input_path: input_pathname,
          child_name: 'Albert',
          greatness: 0
        )
      ).to be_success
    end

    it 'should return output' do
      expect(
        described_class.get_grandparents(
          input_path: input_pathname,
          child_name: 'Albert',
          greatness: 0
        ).output
      ).to eq 'Clint'
    end

    it 'should return Result type' do
      expect(
        described_class.get_grandparents(
          input_path: input_pathname,
          child_name: 'Albert',
          greatness: 0
        )
      ).to be_instance_of(Fam::CLI::Result)
    end

    context 'greatness of 1' do
      it 'should return success' do
        expect(
          described_class.get_grandparents(
            input_path: input_pathname,
            child_name: 'Albert',
            greatness: 1
          )
        ).to be_success
      end

      it 'should return output' do
        expect(
          described_class.get_grandparents(
            input_path: input_pathname,
            child_name: 'Albert',
            greatness: 1
          ).output
        ).to eq 'Dave'
      end
    end

    context 'invalid name' do
      it 'should return failure' do
        expect(
          described_class.get_grandparents(
            input_path: input_pathname,
            child_name: 'Billy',
            greatness: 0
          )
        ).to be_failure
      end

      it 'should return failure message' do
        expect(
          described_class.get_grandparents(
            input_path: input_pathname,
            child_name: 'Billy',
            greatness: 0
          ).error
        ).to eq "No child named 'Billy' in family '#{input_pathname}'!"
      end
    end
  end
end
