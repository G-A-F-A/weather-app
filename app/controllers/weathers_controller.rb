class WeathersController < ApplicationController
  before_action :set_req_url, only: %i[index search]

  def index
    if params[:lat].present?
      response = @conn.get do |req|
        req.url '/data/2.5/weather'
        req.params[:lat] = params[:lat].to_f
        req.params[:lon] = params[:lon].to_f
        req.params[:units] = 'metric'
        req.params[:APPID] = Rails.application.credentials.openweathermap[:api_key]
        req.params[:lang] = 'ja'
      end
    else
      response = @conn.get do |req|
        req.url '/data/2.5/weather'
        req.params[:q] = 'Shibuya,jp'
        req.params[:units] = 'metric'
        req.params[:APPID] = Rails.application.credentials.openweathermap[:api_key]
        req.params[:lang] = 'ja'
      end
    end
    @name = params[:lat].present? ? '現在地' : '渋谷'
    @result = JSON.parse(response.body)
    # binding.pry
    render partial: 'result' if params[:lat].present?
  end

  def search
    response = @conn.get do |req|
      req.url '/data/2.5/weather'
      req.params[:q] = "#{params[:search][:prefectures]},jp"
      req.params[:units] = 'metric'
      req.params[:APPID] = Rails.application.credentials.openweathermap[:api_key]
      req.params[:lang] = 'ja'
    end
    @result = JSON.parse(response.body)
    name = SearchForm::SEARCH_KEY.select { |k| k.second == @result['name'].downcase }
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
