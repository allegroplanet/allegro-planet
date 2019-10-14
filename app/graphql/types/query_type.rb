module Types
  class QueryType < Types::BaseObject
    field :games, [Types::GameType], null: false

    def games
      Game.all
    end
  end
end
