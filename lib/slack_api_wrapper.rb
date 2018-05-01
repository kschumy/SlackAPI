require 'httparty'

class SlackApiWrapper
	URL = "https://slack.com/api/"
	TOKEN = ENV["SLACK_TOKEN"]

	def self.list_channels
		response = HTTParty.get("#{URL}channels.list?token=#{TOKEN}")
		if response["channels"] # if statement just in case something went wrong.
			return response["channels"] # response.parsed_response["channels"]
		else
			return []
		end
	end

	def self.send_message(channel, message)
		message_url = "#{URL}chat.postMessage"
		response = HTTParty.post(message_url,
			body: {
				"token" => TOKEN,
				"channel" => channel,
				"text" => message,
				"username" => "GBPackersBot",
				"icon_emoji" => ":gopackgo:",
				"as_user" => "false"
			},
			:header => { 'Content-Type' => 'application/x-www-form-urlencoded' }
		)
		return response.success?
	end
end
