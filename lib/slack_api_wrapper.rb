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
end
