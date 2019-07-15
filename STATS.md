# Git Log

```
commit a06ac1b43d51dcd96cd73fc49309590e2033f416
Author: Nick Induni <ninduni@squareup.com>
Date:   Thu Jul 11 21:44:03 2019 -0700

    Fix rubocop errors
```

# CLOC


cloc|github.com/AlDanial/cloc v 1.82  T=0.04 s (999.7 files/s, 61606.4 lines/s)
--- | ---

Language|files|blank|comment|code
:-------|-------:|-------:|-------:|-------:
Ruby|34|351|187|1848
Markdown|7|68|0|124
Bourne Again Shell|1|6|0|35
YAML|1|6|10|15
--------|--------|--------|--------|--------
SUM:|43|431|197|2022

# Spec Results
## Fam

```

Fam
  .add_person
    should return success
    should return success message
    should return Result type
    should write result to output path
    should read & write result to output path
  .add_parents
    should return success
    should return success message
    should return Result type
    should write data to the output path
    invalid child name
      should return failure
      should return failure message
    invalid parent name
      should return failure
      should return failure message
    too many parents
      should return failure
      should return failure message
  .get_person
    should return success
    should return output
    should return Result type
    invalid name
      should return failure
      should return failure message
  .get_parents
    should return success
    should return output
    should return Result type
    invalid name
      should return failure
      should return failure message
  .get_grandparents
    should return success
    should return output
    should return Result type
    greatness of 1
      should return success
      should return output
    invalid name
      should return failure
      should return failure message

Fam::Family::Person
  should set the name
  should return a hash with name
  .from_h
    should create a person from a hash
    should set the name of the person
  Comparable
    should be comparable by name
    should be sortable

Fam::Family::Relationship
  should set the child name
  should set the parent name
  should return a hash with child and parent names
  .from_h
    should create a relationship from a hash
    should set the name of the child
    should set the name of the parent
  Comparable
    child names are different, parent names are the same
      should be comparable by name
      should be sortable
    child names are the same, parent names are different
      should be comparable by name
      should be sortable
    child names are different, parent names are different
      should be comparable by name (with child names coming first)
      should be sortable by the child names first

Fam::Family
  should create a family
  should return an inspection with people numbers
  .from_h
    people is not an array
      should raise
    relationships is not an array
      should raise
    empty people and relationships
      should create a family
    people and relationships
      should create a family
      should have 3 people
      should have 2 relationships
  #to_h
    should return a hash with people and relationships
    should return people as a hash
    should return relationships as a hash
  #people
    should return same number of people
    should return person types
  #get_person
    should return person by name
    should return error if person does not exist in family
  #add_person
    should add a person to the family
    should raise if passing in a string
    should raise if creating a duplicate person in the family
  #include?
    should return true if passing a name of a family member
    should return false if passing a name of someone not in the family
    should always return false if passing a Person
  #add_parent
    should raise if passing in strings
    should raise if parent is not found
    should raise if child is not found
    should add a relationship
    should add a relationship with parent and child
    should return the parent
    existing relationship
      returns the parent
      does not add a new relationship
    has 2 parents already
      should raise error
  #get_parents
    should raise error when passed a string
    should return parents when there are some
    should return no parents when there are none
    should return parents of Person type
  #get_grandparents
    should raise error when passed a string
    should get grandparents with no greatness by default
    should get grandparents with 0 greatness
    should get just great-grandparents with 1 greatness
    should get just great-great-grandparents with 2 greatness

Finished in 0.09341 seconds (files took 0.60381 seconds to load)
89 examples, 0 failures

```

## Boilerplate

```

Fam::CLI::Add::Parents
  when the child and parent names are given
    behaves like a successful command
      exits with a zero status code
      matches the expected output
  when all names are missing
    behaves like a failed command
      exits with a non-zero status code
      matches the expected error

Fam::CLI::Add::Person
  when a name is given
    behaves like a successful command
      exits with a zero status code
      matches the expected output
  when no name is provided
    behaves like a failed command
      exits with a non-zero status code
      matches the expected error

Fam::CLI::Get::Parents
  when a child name is given
    behaves like a successful command
      exits with a zero status code
      matches the expected output
  when the child name is missing
    behaves like a failed command
      exits with a non-zero status code
      matches the expected error

Fam::CLI::Get::Person
  when a name is given
    behaves like a successful command
      exits with a zero status code
      matches the expected output
  when the name is missing
    behaves like a failed command
      exits with a non-zero status code
      matches the expected error

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

Finished in 14.37 seconds (files took 0.50811 seconds to load)
20 examples, 0 failures

```

