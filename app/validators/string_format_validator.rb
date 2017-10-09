class StringFormatValidator < ActiveModel::EachValidator
  VALIDATIONS = {
    starts_with_non_whitespace: { regex: /\A\S/, message: "can't start with whitespace", },
    ends_with_non_whitespace: { regex: /\S\z/, message: "can't end with whitespace", },
    only_printable_characters: { regex: /\A[[:print:]]*\z/, message: 'can only contain printable characters', },
    only_printable_characters_and_newlines: { regex: /\A[[:print:]\r\n]*\z/, message: 'can only contain printable characters and newlines', },
    email: { regex: /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i, message: 'must be a valid email' },
    uuid: { regex: /[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/, message: 'must be a valid uuid' },
    username_characters: { regex: /\A[[:alnum:] \._\-~]*\z/, message: "can only contain alphanumeric, '-', '_', space, '.', and '~' characters" },
    at_least_one_alphanumeric_character: { regex: /[[:alnum:]]+/, message: "must contain at least one alphanumeric character" },
  }

  def validate_each(record, attribute, value)
    rules = options.fetch(:rules, [])
    validate_string_format(record, attribute, value, rules)
  end

  private

  def validate_string_format(record, attribute, value, rules)
    rules.each do |rule|
      validator = VALIDATIONS.fetch(rule)
      next if validator.nil? || (validator.fetch(:regex) =~ value)
      record.errors.add(attribute, validator.fetch(:message))
    end
  end
end
