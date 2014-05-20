require 'http'
require 'nokogiri'
require "#{Rails.root}/lib/wrapper"


class SearchController < ApplicationController

  include Wrapper

  def index
    @index = Wrapper::Api.new.get_results
  end

  def show
    @id = params[:id]
  end

  private
    def get_metadata_index(data)
      xml = Nokogiri::XML(data)
      index = []
      xml.remove_namespaces!
      xml.xpath("//SummaryRecord").each { |node|
      metadata = []
      metadata << "<b>UUID:</b> #{node.xpath('identifier').inner_text}"
      metadata << "<b>Title:</b> #{node.xpath('title').inner_text}"
      metadata << "<b>Abstract:</b> #{node.xpath('abstract').inner_text}"
      subjects = []
      node.xpath('subject').each { |subject|
        subjects << subject.inner_text
      }
      metadata << "<b>Keywords:</b> #{subjects.join(', ')}"
      index << metadata
      }
      index
    end
 end
