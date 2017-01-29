module Minitest
  module Assertions
    def assert_validates_format_rules(expected_rules, klass, attribute)
      name_format_validators = klass.validators_on(attribute).select { |v| v.class == StringFormatValidator }
      existing_rules = name_format_validators.flat_map { |v| v.options[:rules] }
      assert_equal expected_rules, existing_rules
    end
  end
end
