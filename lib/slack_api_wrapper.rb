require 'httparty'

class SlackApiWrapper
	URL = "https://slack.com/api/"
	TOKEN = ENV["SLACK_TOKEN"]

	def self.list_channels
		response = HTTParty.get("#{URL}channels.list?token=#{TOKEN}")

		channel_list = [] # got from lib/channel

		if response["channels"] # if statement just in case something went wrong.
			response["channels"].each do |channel|
				channel_list << Channel.new(channel["name"], channel["id"])
			end
		end

		return channel_list

		# if response["channels"] # if statement just in case something went wrong.
		# 	return response["channels"] # response.parsed_response["channels"]
		# else
		# 	return []
		# end
	end

	def self.send_message(channel, message)
		message_url = "#{URL}chat.postMessage"
		response = HTTParty.post(message_url,
			body: {
				"token" => TOKEN,
				"channel" => channel,
				"text" => message,
				"username" => "FrontRowNewsBot",
				"icon_emoji" => ":nerd_face:",
				"as_user" => "false"
			},
			:header => { 'Content-Type' => 'application/x-www-form-urlencoded' }
		)
		# return response.success? # initial way we did this.
		return response # changed after testing. Can keep the original way if you want
	end
end
