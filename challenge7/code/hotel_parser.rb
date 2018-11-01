require 'yaml'

# Monkey-patching the Hash class by defining method_missing enables
#   us to control what happens when we try to call undefined methods
#   on an instance of the Hash class.

# Here, if the called method corresponds to an existing key, we access
#   that key.  Otherwise, we fallback to Ruby's default behavior
#   (raises error).
class Hash
  def method_missing(method_name)
    return self[method_name.to_s] if self[method_name.to_s]
    super
  end
end

class HotelParser
  # Implement a method parse the contents of a YAML file and return
  # an object whose values are accessible using the [] operator or method calls
  #
  # Note: Use of the YAML library is fine (encouraged, even) but please don't
  #       use any third-party gems that enable the required functionality.
  def self.parse(filename)
    # using load file allows us to access the yaml_obj using [], but not .method style
    yaml_obj = YAML.load_file(filename)
    yaml_obj
  end
end
