class Game < ApplicationRecord
  before_validation :generate_handle

  validates :title,
    presence: true,
    uniqueness: true,
    allow_blank: false,
    string_format: { rules: [:starts_with_non_whitespace, :ends_with_non_whitespace, :has_only_printable_characters] }

  validates :description,
    presence: true,
    allow_blank: false,
    string_format: { rules: [:starts_with_non_whitespace, :ends_with_non_whitespace, :has_only_printable_characters] }

  validates :handle,
    presence: true,
    uniqueness: true

  has_many :game_screenshots

  has_many :game_releases

  has_and_belongs_to_many :users

  def to_param
    handle
  end

  private

    def generate_handle
      self.handle ||= self.title.parameterize if self.title.present?
    end
end
