module Types
  class GameType < Types::BaseObject
    field :title, String, null: false
    field :description, String, null: false
    field :created_at, String, null: false
    field :updated_at, String, null: false
  end
end
