class CompaniesController < ApplicationController
  def search
    query = params[:q]
    return render json: [] if query.blank? || query.length < 3

    results = SireneApiService.new.search_companies(query)
    render json: results
  end
end
