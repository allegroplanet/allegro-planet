class Searcher
  attr_reader :query, :limit

  def initialize(query, limit: 50)
    @query = query
    @limit = limit
  end

  def results
    elasticsearch_result.records.to_a
  end

  def num_results
    elasticsearch_result.results.total
  end

  private

  def sanitized_query
    query.gsub(/[^0-9a-z ]/i, '')
  end

  def elasticsearch_result
    @elasticsearch_result ||= Game.search(sanitized_query, size: limit)
  end
end
