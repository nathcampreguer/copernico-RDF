require 'http'
require 'nokogiri'
require "#{Rails.root}/lib/wrapper"

class SearchController < ApplicationController

  include Wrapper

  def index
    @index = Kaminari.paginate_array(Wrapper::GeonetworkApi.new
                     .get_results(params[:search_field]))
                     .page(params[:page]).per(5)
  end

  def show
    @uuid = params[:uuid]
  end
end
