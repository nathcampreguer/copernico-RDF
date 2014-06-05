class SearchController < ApplicationController
  def index
    @index = Kaminari.paginate_array(GeonetworkApi.new
                     .get_results(params[:search_field]))
                     .page(params[:page]).per(5)
  end

  def show
    @uuid = params[:uuid]
  end
end
