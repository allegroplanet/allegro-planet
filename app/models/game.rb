class Game < ApplicationRecord
  before_validation :generate_handle

  has_many :game_screenshots
  has_many :game_releases
  has_and_belongs_to_many :users

  validates :title,
    presence: true,
    uniqueness: true,
    allow_blank: false,
    string_format: { rules: [:starts_with_non_whitespace, :ends_with_non_whitespace, :only_printable_characters] }
  validates :description,
    presence: true,
    allow_blank: false,
    string_format: { rules: [:starts_with_non_whitespace, :ends_with_non_whitespace, :only_printable_characters_and_newlines] }
  validates :handle,
    presence: true,
    uniqueness: true

  def to_param
    handle
  end

  private

    def generate_handle
      self.handle ||= self.title.parameterize if self.title.present?
    end
end
