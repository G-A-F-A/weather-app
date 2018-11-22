class ForecastsController < ApplicationController
  before_action :set_req_url, only: %i[index search]

  def index
    response = @conn.get do |req|
      req.url '/data/2.5/forecast'
      req.params[:q] = 'Shibuya,jp'
      req.params[:units] = 'metric'
      req.params[:APPID] = Rails.application.credentials.openweathermap[:api_key]
      req.params[:lang] = 'ja'
    end
    @name = '渋谷'
    @result = JSON.parse(response.body)
    render :index
  end

  def search
    response = @conn.get do |req|
      req.url '/data/2.5/forecast'
      req.params[:q] = "#{params[:search][:prefectures]},jp"
      req.params[:units] = 'metric'
      req.params[:APPID] = Rails.application.credentials.openweathermap[:api_key]
      req.params[:lang] = 'ja'
    end
    @result = JSON.parse(response.body)
    name = SearchForm::SEARCH_KEY.select { |k| k.second == @result['city']['name'].downcase }
    @name = name.shift.first
    render :index
  end

  private

  def set_req_url
    @conn = Faraday.new(:url => 'https://api.openweathermap.org') do |builder|
      builder.request :url_encoded
      builder.response :logger
      builder.adapter :net_http
    end
  end
end
