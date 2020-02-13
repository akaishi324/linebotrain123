class LinebotrainController < ApplicationController
    require 'line/bot'
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
           response = "んほぉぉぉぉぉぉ！すきすきすきすきすきすきすきすきぃぃぃぃぃ"
          # 「スタート」と入力されたときの処理
        when 'ストップ'
            
          # 「ストップ」と入力されたときの処理
        when /.*天気.*/
          # 「天気」を含む文字列が入力されたときの処理

        end
   　  end
      message = { type: 'text', text: response}
      client.reply_message(event['replyToken'], message)
    end
   }
  end 
end
