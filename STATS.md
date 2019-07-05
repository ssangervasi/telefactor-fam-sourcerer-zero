# Git Log

```
commit 548b6938381405c051f7e1def91c85ffe6dec233
Author: Sebastian Sangervasi <ssangervasi@squareup.com>
Date:   Fri Jul 5 12:40:17 2019 -0700

    Init with examiner zero's tests
```

# CLOC


cloc|github.com/AlDanial/cloc v 1.82  T=0.06 s (602.0 files/s, 35782.1 lines/s)
--- | ---

Language|files|blank|comment|code
:-------|-------:|-------:|-------:|-------:
Ruby|30|290|186|1578
Markdown|7|68|0|124
Bourne Again Shell|1|6|0|35
YAML|1|6|10|15
--------|--------|--------|--------|--------
SUM:|39|370|196|1752

# Spec Results
## Fam

```

An error occurred while loading ./spec/fam/family/person_spec.rb.
Failure/Error:
  RSpec.describe Fam::Family::Person do
    let(:name) { 'Bob Saget' }
  
    describe '.from_h' do
      let(:input_hash) do
        { name: name }
      end
  
      it 'should create a person from a hash' do
        expect(described_class.from_h(input_hash)).to_not be_nil

NameError:
  uninitialized constant Fam::Family::Person
  Did you mean?  Fam::VERSION
# ./spec/fam/family/person_spec.rb:5:in `<top (required)>'

An error occurred while loading ./spec/fam/family/relationship_spec.rb.
Failure/Error:
  RSpec.describe Fam::Family::Relationship do
    let(:child_name) { 'Sue Saget' }
    let(:parent_name) { 'Bob Saget' }
  
    describe '.from_h' do
      let(:input_hash) do
        {
          child_name: child_name,
          parent_name: parent_name,
        }

NameError:
  uninitialized constant Fam::Family::Relationship
# ./spec/fam/family/relationship_spec.rb:5:in `<top (required)>'

Finished in 0.0003 seconds (files took 0.87624 seconds to load)
0 examples, 0 failures, 2 errors occurred outside of examples

```

## Boilerplate

```

Fam::CLI::Add::Parents
  when the child and parent names are given
    behaves like a successful command
      exits with a zero status code (FAILED - 1)
      matches the expected output (FAILED - 2)
  when all names are missing
    behaves like a failed command
      exits with a non-zero status code (FAILED - 3)
      matches the expected error (FAILED - 4)

Fam::CLI::Add::Person
  when a name is given
    behaves like a successful command
      exits with a zero status code (FAILED - 5)
      matches the expected output (FAILED - 6)
  when no name is provided
    behaves like a failed command
      exits with a non-zero status code
      matches the expected error

Fam::CLI::Get::Parents
  when a child name is given
    behaves like a successful command
      exits with a zero status code (FAILED - 7)
      matches the expected output (FAILED - 8)
  when the child name is missing
    behaves like a failed command
      exits with a non-zero status code (FAILED - 9)
      matches the expected error (FAILED - 10)

Fam::CLI::Get::Person
  when a name is given
    behaves like a successful command
      exits with a zero status code (FAILED - 11)
      matches the expected output (FAILED - 12)
  when the name is missing
    behaves like a failed command
      exits with a non-zero status code (FAILED - 13)
      matches the expected error (FAILED - 14)

Fam::File::Reader::JSONReader
  #read
    when the file does not exist
      raises an error
    when the file exists
      should be a kind of Hash

Fam::File::Writer::JSONWriter
  #write
    should be a kind of String
    modifies the specified file

Failures:

  1) Fam::CLI::Add::Parents when the child and parent names are given behaves like a successful command exits with a zero status code
     Failure/Error:
       expect(
         Hatchery::Names.simpsons.map do |person_name|
           exec_fam('add', 'person', person_name)
         end
       ).to(
         all(be_success),
         'Must be able to `add person` before testing `get parents`'
       )

       Must be able to `add person` before testing `get parents`
     Shared Example Group: "a successful command" called from ./spec/boilerplate/cli/add/parents_spec.rb:25
     # ./spec/boilerplate/cli/add/parents_spec.rb:14:in `block (2 levels) in <top (required)>'

  2) Fam::CLI::Add::Parents when the child and parent names are given behaves like a successful command matches the expected output
     Failure/Error:
       expect(
         Hatchery::Names.simpsons.map do |person_name|
           exec_fam('add', 'person', person_name)
         end
       ).to(
         all(be_success),
         'Must be able to `add person` before testing `get parents`'
       )

       Must be able to `add person` before testing `get parents`
     Shared Example Group: "a successful command" called from ./spec/boilerplate/cli/add/parents_spec.rb:25
     # ./spec/boilerplate/cli/add/parents_spec.rb:14:in `block (2 levels) in <top (required)>'

  3) Fam::CLI::Add::Parents when all names are missing behaves like a failed command exits with a non-zero status code
     Failure/Error:
       expect(
         Hatchery::Names.simpsons.map do |person_name|
           exec_fam('add', 'person', person_name)
         end
       ).to(
         all(be_success),
         'Must be able to `add person` before testing `get parents`'
       )

       Must be able to `add person` before testing `get parents`
     Shared Example Group: "a failed command" called from ./spec/boilerplate/cli/add/parents_spec.rb:35
     # ./spec/boilerplate/cli/add/parents_spec.rb:14:in `block (2 levels) in <top (required)>'

  4) Fam::CLI::Add::Parents when all names are missing behaves like a failed command matches the expected error
     Failure/Error:
       expect(
         Hatchery::Names.simpsons.map do |person_name|
           exec_fam('add', 'person', person_name)
         end
       ).to(
         all(be_success),
         'Must be able to `add person` before testing `get parents`'
       )

       Must be able to `add person` before testing `get parents`
     Shared Example Group: "a failed command" called from ./spec/boilerplate/cli/add/parents_spec.rb:35
     # ./spec/boilerplate/cli/add/parents_spec.rb:14:in `block (2 levels) in <top (required)>'

  5) Fam::CLI::Add::Person when a name is given behaves like a successful command exits with a zero status code
     Failure/Error: expect(subject.status).to eq(0), (subject.output + subject.error)
     Shared Example Group: "a successful command" called from ./spec/boilerplate/cli/add/person_spec.rb:13
     # ./spec/spec_helpers/cli.rb:28:in `block (3 levels) in <top (required)>'

  6) Fam::CLI::Add::Person when a name is given behaves like a successful command matches the expected output
     Failure/Error: expect(subject.output).to match expected_output
       expected "" to match "José Exemplo"
     Shared Example Group: "a successful command" called from ./spec/boilerplate/cli/add/person_spec.rb:13
     # ./spec/spec_helpers/cli.rb:32:in `block (3 levels) in <top (required)>'

  7) Fam::CLI::Get::Parents when a child name is given behaves like a successful command exits with a zero status code
     Failure/Error:
       expect(
         Hatchery::Names.simpsons.map do |person_name|
           exec_fam('add', 'person', person_name)
         end
       ).to(
         all(be_success),
         'Must be able to `add person` before testing `get parents`'
       )

       Must be able to `add person` before testing `get parents`
     Shared Example Group: "a successful command" called from ./spec/boilerplate/cli/get/parents_spec.rb:33
     # ./spec/boilerplate/cli/get/parents_spec.rb:14:in `block (2 levels) in <top (required)>'

  8) Fam::CLI::Get::Parents when a child name is given behaves like a successful command matches the expected output
     Failure/Error:
       expect(
         Hatchery::Names.simpsons.map do |person_name|
           exec_fam('add', 'person', person_name)
         end
       ).to(
         all(be_success),
         'Must be able to `add person` before testing `get parents`'
       )

       Must be able to `add person` before testing `get parents`
     Shared Example Group: "a successful command" called from ./spec/boilerplate/cli/get/parents_spec.rb:33
     # ./spec/boilerplate/cli/get/parents_spec.rb:14:in `block (2 levels) in <top (required)>'

  9) Fam::CLI::Get::Parents when the child name is missing behaves like a failed command exits with a non-zero status code
     Failure/Error:
       expect(
         Hatchery::Names.simpsons.map do |person_name|
           exec_fam('add', 'person', person_name)
         end
       ).to(
         all(be_success),
         'Must be able to `add person` before testing `get parents`'
       )

       Must be able to `add person` before testing `get parents`
     Shared Example Group: "a failed command" called from ./spec/boilerplate/cli/get/parents_spec.rb:43
     # ./spec/boilerplate/cli/get/parents_spec.rb:14:in `block (2 levels) in <top (required)>'

  10) Fam::CLI::Get::Parents when the child name is missing behaves like a failed command matches the expected error
      Failure/Error:
        expect(
          Hatchery::Names.simpsons.map do |person_name|
            exec_fam('add', 'person', person_name)
          end
        ).to(
          all(be_success),
          'Must be able to `add person` before testing `get parents`'
        )

        Must be able to `add person` before testing `get parents`
      Shared Example Group: "a failed command" called from ./spec/boilerplate/cli/get/parents_spec.rb:43
      # ./spec/boilerplate/cli/get/parents_spec.rb:14:in `block (2 levels) in <top (required)>'

  11) Fam::CLI::Get::Person when a name is given behaves like a successful command exits with a zero status code
      Failure/Error:
        expect(exec_fam('add', 'person', person_name))
          .to(
            be_success,
            'Must be able to `add person` before testing `get person`'
          )

        Must be able to `add person` before testing `get person`
      Shared Example Group: "a successful command" called from ./spec/boilerplate/cli/get/person_spec.rb:21
      # ./spec/boilerplate/cli/get/person_spec.rb:10:in `block (2 levels) in <top (required)>'

  12) Fam::CLI::Get::Person when a name is given behaves like a successful command matches the expected output
      Failure/Error:
        expect(exec_fam('add', 'person', person_name))
          .to(
            be_success,
            'Must be able to `add person` before testing `get person`'
          )

        Must be able to `add person` before testing `get person`
      Shared Example Group: "a successful command" called from ./spec/boilerplate/cli/get/person_spec.rb:21
      # ./spec/boilerplate/cli/get/person_spec.rb:10:in `block (2 levels) in <top (required)>'

  13) Fam::CLI::Get::Person when the name is missing behaves like a failed command exits with a non-zero status code
      Failure/Error:
        expect(exec_fam('add', 'person', person_name))
          .to(
            be_success,
            'Must be able to `add person` before testing `get person`'
          )

        Must be able to `add person` before testing `get person`
      Shared Example Group: "a failed command" called from ./spec/boilerplate/cli/get/person_spec.rb:31
      # ./spec/boilerplate/cli/get/person_spec.rb:10:in `block (2 levels) in <top (required)>'

  14) Fam::CLI::Get::Person when the name is missing behaves like a failed command matches the expected error
      Failure/Error:
        expect(exec_fam('add', 'person', person_name))
          .to(
            be_success,
            'Must be able to `add person` before testing `get person`'
          )

        Must be able to `add person` before testing `get person`
      Shared Example Group: "a failed command" called from ./spec/boilerplate/cli/get/person_spec.rb:31
      # ./spec/boilerplate/cli/get/person_spec.rb:10:in `block (2 levels) in <top (required)>'

Finished in 8.82 seconds (files took 0.73277 seconds to load)
20 examples, 14 failures

Failed examples:

rspec ./spec/boilerplate/cli/add/parents_spec.rb[1:1:1:1] # Fam::CLI::Add::Parents when the child and parent names are given behaves like a successful command exits with a zero status code
rspec ./spec/boilerplate/cli/add/parents_spec.rb[1:1:1:2] # Fam::CLI::Add::Parents when the child and parent names are given behaves like a successful command matches the expected output
rspec ./spec/boilerplate/cli/add/parents_spec.rb[1:2:1:1] # Fam::CLI::Add::Parents when all names are missing behaves like a failed command exits with a non-zero status code
rspec ./spec/boilerplate/cli/add/parents_spec.rb[1:2:1:2] # Fam::CLI::Add::Parents when all names are missing behaves like a failed command matches the expected error
rspec ./spec/boilerplate/cli/add/person_spec.rb[1:1:1:1] # Fam::CLI::Add::Person when a name is given behaves like a successful command exits with a zero status code
rspec ./spec/boilerplate/cli/add/person_spec.rb[1:1:1:2] # Fam::CLI::Add::Person when a name is given behaves like a successful command matches the expected output
rspec ./spec/boilerplate/cli/get/parents_spec.rb[1:1:1:1] # Fam::CLI::Get::Parents when a child name is given behaves like a successful command exits with a zero status code
rspec ./spec/boilerplate/cli/get/parents_spec.rb[1:1:1:2] # Fam::CLI::Get::Parents when a child name is given behaves like a successful command matches the expected output
rspec ./spec/boilerplate/cli/get/parents_spec.rb[1:2:1:1] # Fam::CLI::Get::Parents when the child name is missing behaves like a failed command exits with a non-zero status code
rspec ./spec/boilerplate/cli/get/parents_spec.rb[1:2:1:2] # Fam::CLI::Get::Parents when the child name is missing behaves like a failed command matches the expected error
rspec ./spec/boilerplate/cli/get/person_spec.rb[1:1:1:1] # Fam::CLI::Get::Person when a name is given behaves like a successful command exits with a zero status code
rspec ./spec/boilerplate/cli/get/person_spec.rb[1:1:1:2] # Fam::CLI::Get::Person when a name is given behaves like a successful command matches the expected output
rspec ./spec/boilerplate/cli/get/person_spec.rb[1:2:1:1] # Fam::CLI::Get::Person when the name is missing behaves like a failed command exits with a non-zero status code
rspec ./spec/boilerplate/cli/get/person_spec.rb[1:2:1:2] # Fam::CLI::Get::Person when the name is missing behaves like a failed command matches the expected error

```

