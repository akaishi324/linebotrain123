class LinebotrainController < ApplicationController
    require 'line/bot'
    API_KEY = "YOUR API KEY"
   BASE_URL = "http://api.openweathermap.org/data/2.5/forecast"

   require "json"
   require "open-uri"
  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
    end
     events = client.parse_events_from(body)

    events.each { |event|
    case event
    when Line::Bot::Event::Message
      case event.type

      when Line::Bot::Event::MessageType::Text
        # 文字列が入力された場合

        case event.message['text']
        when 'スタート'
           respon = open(BASE_URL + "?q=Akashi-shi,jp&APPID=#{cbba055e76890cc19833783ff9b63ba7}")
          # 「スタート」と入力されたときの処理
        response=JSON.pretty_generate(JSON.parse(respon.read))
        end
   　  end
      message = { type: 'text', text: response}
      client.reply_message(event['replyToken'], message)
    end
   }
   head :ok
  end 
end
