module ElasticsearchGameConfiguration
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
  end
end
