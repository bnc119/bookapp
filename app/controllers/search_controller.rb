class SearchController < ApplicationController
  
  def index
    
    @search_results = GoodReads.search(params[:search][:q])
  end

end
