require 'thor'

# Modify how Thor parses array arguments to be POSIX standard per
# getopt_long(3)
# @see https://linux.die.net/man/3/getopt_long
module Fylla
  module Thor
    module Arguments
      def parse_array(name)
        return shift if peek.is_a?(Array)
        array = []
        if peek.include? ","
          array.push(*shift.split(","))
        else
          array << shift while current_is_value?
        end
        array
      end
    end
  end
end