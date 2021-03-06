class SearchController < ApplicationController
  def index
    searcher = Searcher.new(query_param)
    @search_results = searcher.results
    @num_results = searcher.num_results
  end

  private

  def query_param
    permitted_params[:q]
  end

  def permitted_params
    params.permit(:q)
  end
end
