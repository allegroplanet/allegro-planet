require 'test_helper'

class StringFormatValidatorTest < ActiveSupport::TestCase
  class FooClass
    include ActiveModel::Validations
    attr_reader :bar
    def initialize(bar)
      @bar = bar
    end
  end

  def ascii_characters
    @ascii_characters ||= (0..255).to_a.map(&:chr)
  end

  def printable_characters
    @printable_characters ||= (32..126).to_a.map(&:chr)
  end

  def teardown
    FooClass.clear_validators!
  end

  test 'contains the expected set of validation rules' do
    expected_rules = [
      :starts_with_non_whitespace,
      :ends_with_non_whitespace,
      :only_printable_characters,
      :only_printable_characters_and_newlines,
      :email,
      :uuid,
      :username_characters,
      :at_least_one_alphanumeric_character,
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

  test ':only_printable_characters_and_newlines rule checks that the value can only contain printable characters and newlines' do
    FooClass.validates(:bar, string_format: { rules: [:only_printable_characters_and_newlines] })

    allowed_characters = printable_characters + ["\r", "\n"]

    allowed_characters.each do |char|
      foo = FooClass.new("#{char}")
      foo.validate
      refute_includes foo.errors[:bar], 'can only contain printable characters and newlines'
    end

    disallowed_characters = ascii_characters - allowed_characters
    disallowed_characters.each do |char|
      foo = FooClass.new(char)
      foo.validate
      assert_includes foo.errors[:bar], 'can only contain printable characters and newlines', foo.bar
    end
  end

  test ':email rule checks that the value is a valid email format' do
    FooClass.validates(:bar, string_format: { rules: [:email] })

    foo = FooClass.new("not-a-valid-email")
    foo.validate
    assert_includes foo.errors[:bar], 'must be a valid email'

    foo = FooClass.new("valid.email@gmail.com")
    foo.validate
    refute_includes foo.errors[:bar], 'must be a valid email'
  end

  test ':uuid rule checks that the value is a valid uuid format' do
    FooClass.validates(:bar, string_format: { rules: [:uuid] })

    foo = FooClass.new("not-a-valid-uuid")
    foo.validate
    assert_includes foo.errors[:bar], 'must be a valid uuid'

    foo = FooClass.new("624f6dd0-91f2-4026-a684-01924da4be84")
    foo.validate
    refute_includes foo.errors[:bar], 'must be a valid uuid'
  end

  test ':username_characters rule checks that the value can only contain alphanum, space, tilde, underscore, hyphen, and period characters' do
    FooClass.validates(:bar, string_format: { rules: [:username_characters] })

    allowed_characters = ('a'..'z').to_a + ('0'..'9').to_a + ('A'..'Z').to_a + [' ', '-', '~', '_', '.']

    allowed_characters.each do |char|
      foo = FooClass.new("#{char}")
      foo.validate
      refute_includes foo.errors[:bar], "can only contain alphanumeric, '-', '_', space, '.', and '~' characters"
    end

    disallowed_characters = ascii_characters - allowed_characters
    disallowed_characters.each do |char|
      foo = FooClass.new(char)
      foo.validate
      assert_includes foo.errors[:bar], "can only contain alphanumeric, '-', '_', space, '.', and '~' characters"
    end
  end

  test ':at_least_one_alphanumeric_character must contain at least one character in [0-9a-zA-Z]' do
    FooClass.validates(:bar, string_format: { rules: [:at_least_one_alphanumeric_character] })

    allowed_characters = ('a'..'z').to_a + ('0'..'9').to_a + ('A'..'Z').to_a

    foo = FooClass.new("-_~")
    foo.validate
    assert_includes foo.errors[:bar], "must contain at least one alphanumeric character"

    foo = FooClass.new("-A~")
    foo.validate
    refute_includes foo.errors[:bar], "must contain at least one alphanumeric character"
  end
end
