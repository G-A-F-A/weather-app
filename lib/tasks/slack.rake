namespace :slack do

  desc '例の画像を通知'
  task send_image: :environment do
    Slack.chat_postMessage(
      text: "#{Time.now.strftime('%Y年%m月%d日 %H時%M分%S秒')}現在、例の画像は存在しています。\nhttps://google-vision.s3.amazonaws.com/uploads/pro/image/image/1432/___.jpg",
      username: 'weatherapp',
      channel: '#general'
    )
  end

  desc '明日の天気を通知'
  task send_weather_info: :environment do
    conn = Faraday.new(:url => 'https://api.openweathermap.org') do |builder|
      builder.request :url_encoded
      builder.response :logger
      builder.adapter :net_http
    end
    response = conn.get do |req|
      req.url '/data/2.5/forecast'
      req.params[:q] = 'Shibuya,jp'
      req.params[:units] = 'metric'
      req.params[:APPID] = Rails.application.credentials.openweathermap[:api_key]
      req.params[:lang] = 'ja'
    end
    result = JSON.parse(response.body)
    res_1 = result['list'][6]
    res_2 = result['list'][7]
    res_3 = result['list'][8]
    res_4 = result['list'][9]
    res_5 = result['list'][10]
    content_1 = "時間: #{res_1['dt_txt'].to_datetime.strftime('%H:00')}, 天気: #{res_1['weather'][0]['description']}, 気温: #{res_1['main']['temp'].to_s}℃, 湿度: #{res_1['main']['humidity'].to_s}％"
    content_2 = "時間: #{res_2['dt_txt'].to_datetime.strftime('%H:00')}, 天気: #{res_2['weather'][0]['description']}, 気温: #{res_2['main']['temp'].to_s}℃, 湿度: #{res_2['main']['humidity'].to_s}％"
    content_3 = "時間: #{res_3['dt_txt'].to_datetime.strftime('%H:00')}, 天気: #{res_3['weather'][0]['description']}, 気温: #{res_3['main']['temp'].to_s}℃, 湿度: #{res_3['main']['humidity'].to_s}％"
    content_4 = "時間: #{res_4['dt_txt'].to_datetime.strftime('%H:00')}, 天気: #{res_4['weather'][0]['description']}, 気温: #{res_4['main']['temp'].to_s}℃, 湿度: #{res_4['main']['humidity'].to_s}％"
    content_5 = "時間: #{res_5['dt_txt'].to_datetime.strftime('%H:00')}, 天気: #{res_5['weather'][0]['description']}, 気温: #{res_5['main']['temp'].to_s}℃, 湿度: #{res_5['main']['humidity'].to_s}％"
    Slack.chat_postMessage(
      text: "明日の渋谷のお天気予報をお知らせします。\n#{content_1}\n#{content_2}\n#{content_3}\n#{content_4}\n#{content_5}",
      username: 'weatherapp',
      channel: '#general'
    )
  end
end
