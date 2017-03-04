require 'test_helper'

class StringFormatValidatorTest < ActiveSupport::TestCase
  class FooClass
    include ActiveModel::Validations
    attr_reader :bar
    def initialize(bar)
      @bar = bar
    end
  end

  def teardown
    FooClass.clear_validators!
  end

  test 'contains the expected set of validation rules' do
    expected_rules = [
      :starts_with_non_whitespace,
      :ends_with_non_whitespace,
      :only_printable_characters,
    ]
    existing_rules = StringFormatValidator::VALIDATIONS.keys
    assert_equal expected_rules, existing_rules
  end

  test ':starts_with_non_whitespace rule checks that the value does not begin with any whitespace' do
    FooClass.validates(:bar, string_format: { rules: [:starts_with_non_whitespace] })
    foo = FooClass.new(' startswithwhitespace')
    foo.validate
    assert_includes foo.errors[:bar], "can't start with whitespace"
  end

  test ':ends_with_non_whitespace rule checks that the value does not end with any whitespace' do
    FooClass.validates(:bar, string_format: { rules: [:ends_with_non_whitespace] })
    foo = FooClass.new('endswithwhitespace ')
    foo.validate
    assert_includes foo.errors[:bar], "can't end with whitespace"
  end

  test ':only_printable_characters rule checks that the value can only contain printable characters' do
    FooClass.validates(:bar, string_format: { rules: [:only_printable_characters] })
    foo = FooClass.new("\x0A")
    foo.validate
    assert_includes foo.errors[:bar], 'can only contain printable characters'
  end
end
