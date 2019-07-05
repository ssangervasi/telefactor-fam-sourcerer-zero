# frozen_string_literal: true

require 'fam/version'
require 'fam/cli/result'
require 'fam/file'

require 'fam/family'

module Fam
  # Includes the .success and .failure helpers which return Fam::CLI::Result objects
  #   that the CLI knows how to handle. All of the module methods should return
  #   either `success(message)` or `failure(message)`, but how they do that
  #   is up to the sourcerer.
  extend Fam::CLI::Result::Helpers
  # Includes the .read and .write helpers which will support read and writing
  #   JSON with symbol keys. These methods don't check the structure of the file,
  #   only that it is valid JSON.
  # All of the module methods should use `read(path: input_path)` to get the input family
  #   tree data, if any. Reading from a non-existant file produces an empty hash.
  # All of the "add" methods should use `write(path: output_path, json_hash: {...})`
  #   to save their output. This creates the file, or overwrites if it already exists.
  extend Fam::File::Helpers

  # These static methods are the only entrypoint that the CLI has to the application.
  #   So, as long as implementation uses the aruguments correctly and returns either
  #   `success` or `failure`, you can put whatever you want in the method bodies
  #   and in any files in the lib/fam/family directory.
  class << self
    # IMPLEMENT ME
    def add_person(
      input_path:,
      output_path:,
      person_name:
    )
      failure
    end

    # IMPLEMENT ME
    def add_parents(
      input_path:,
      output_path:,
      child_name:,
      parent_names:
    )
      failure
    end

    # IMPLEMENT ME
    def get_person(
      input_path:,
      person_name:
    )
      failure
    end

    # IMPLEMENT ME
    def get_parents(
      input_path:,
      child_name:
    )
      failure
    end

    # IMPLEMENT ME
    def get_grandparents(
      input_path:,
      child_name:,
      greatness:
    )
      failure
    end
  end
end
