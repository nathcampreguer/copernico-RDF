require 'http'
require 'nokogiri'
require "#{Rails.root}/lib/wrapper"

class SearchController < ApplicationController

  include Wrapper

  def index
    @index = Wrapper::GeonetworkApi.new.get_results(params[:search_field])
  end

  def show
    @id = params[:id]
  end
end
