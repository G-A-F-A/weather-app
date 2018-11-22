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
    response_s = conn.get do |req|
      req.url '/data/2.5/forecast'
      req.params[:q] = 'Shibuya,jp'
      req.params[:units] = 'metric'
      req.params[:APPID] = Rails.application.credentials.openweathermap[:api_key]
      req.params[:lang] = 'ja'
    end
    response_k = conn.get do |req|
      req.url '/data/2.5/forecast'
      req.params[:q] = 'Kawasaki,jp'
      req.params[:units] = 'metric'
      req.params[:APPID] = Rails.application.credentials.openweathermap[:api_key]
      req.params[:lang] = 'ja'
    end
    result_s = JSON.parse(response_s.body)
    result_k = JSON.parse(response_k.body)
    res_s_1 = result_s['list'][6]
    res_s_2 = result_s['list'][7]
    res_s_3 = result_s['list'][8]
    res_s_4 = result_s['list'][9]
    res_s_5 = result_s['list'][10]
    res_k_1 = result_k['list'][6]
    res_k_2 = result_k['list'][7]
    res_k_3 = result_k['list'][8]
    res_k_4 = result_k['list'][9]
    res_k_5 = result_k['list'][10]
    content_s_1 = "時間: #{res_s_1['dt_txt'].to_datetime.strftime('%H:00')}, 天気: #{res_s_1['weather'][0]['description']}, 気温: #{res_s_1['main']['temp'].to_s}℃, 湿度: #{res_s_1['main']['humidity'].to_s}％"
    content_s_2 = "時間: #{res_s_2['dt_txt'].to_datetime.strftime('%H:00')}, 天気: #{res_s_2['weather'][0]['description']}, 気温: #{res_s_2['main']['temp'].to_s}℃, 湿度: #{res_s_2['main']['humidity'].to_s}％"
    content_s_3 = "時間: #{res_s_3['dt_txt'].to_datetime.strftime('%H:00')}, 天気: #{res_s_3['weather'][0]['description']}, 気温: #{res_s_3['main']['temp'].to_s}℃, 湿度: #{res_s_3['main']['humidity'].to_s}％"
    content_s_4 = "時間: #{res_s_4['dt_txt'].to_datetime.strftime('%H:00')}, 天気: #{res_s_4['weather'][0]['description']}, 気温: #{res_s_4['main']['temp'].to_s}℃, 湿度: #{res_s_4['main']['humidity'].to_s}％"
    content_s_5 = "時間: #{res_s_5['dt_txt'].to_datetime.strftime('%H:00')}, 天気: #{res_s_5['weather'][0]['description']}, 気温: #{res_s_5['main']['temp'].to_s}℃, 湿度: #{res_s_5['main']['humidity'].to_s}％"
    content_k_1 = "時間: #{res_k_1['dt_txt'].to_datetime.strftime('%H:00')}, 天気: #{res_k_1['weather'][0]['description']}, 気温: #{res_k_1['main']['temp'].to_s}℃, 湿度: #{res_k_1['main']['humidity'].to_s}％"
    content_k_2 = "時間: #{res_k_2['dt_txt'].to_datetime.strftime('%H:00')}, 天気: #{res_k_2['weather'][0]['description']}, 気温: #{res_k_2['main']['temp'].to_s}℃, 湿度: #{res_k_2['main']['humidity'].to_s}％"
    content_k_3 = "時間: #{res_k_3['dt_txt'].to_datetime.strftime('%H:00')}, 天気: #{res_k_3['weather'][0]['description']}, 気温: #{res_k_3['main']['temp'].to_s}℃, 湿度: #{res_k_3['main']['humidity'].to_s}％"
    content_k_4 = "時間: #{res_k_4['dt_txt'].to_datetime.strftime('%H:00')}, 天気: #{res_k_4['weather'][0]['description']}, 気温: #{res_k_4['main']['temp'].to_s}℃, 湿度: #{res_k_4['main']['humidity'].to_s}％"
    content_k_5 = "時間: #{res_k_5['dt_txt'].to_datetime.strftime('%H:00')}, 天気: #{res_k_5['weather'][0]['description']}, 気温: #{res_k_5['main']['temp'].to_s}℃, 湿度: #{res_k_5['main']['humidity'].to_s}％"
    Slack.chat_postMessage(
      text: "明日の渋谷のお天気予報をお知らせします。\n#{content_s_1}\n#{content_s_2}\n#{content_s_3}\n#{content_s_4}\n#{content_s_5}",
      username: 'weatherapp',
      channel: '#general'
    )
    Slack.chat_postMessage(
      text: "明日の川崎のお天気予報をお知らせします。\n#{content_k_1}\n#{content_k_2}\n#{content_k_3}\n#{content_k_4}\n#{content_k_5}",
      username: 'weatherapp',
      channel: '#general'
    )
  end
end
