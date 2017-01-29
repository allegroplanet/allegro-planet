class StringFormatValidator < ActiveModel::EachValidator
  VALIDATIONS = {
    starts_with_non_whitespace: { regex: /\A\S/, message: "can't start with whitespace", },
    ends_with_non_whitespace: { regex: /\S\z/, message: "can't end with whitespace", },
    has_only_printable_characters: { regex: /\A[[:print:]]*\z/, message: 'can only contain printable characters', }
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
