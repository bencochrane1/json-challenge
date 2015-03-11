class FeedsController < ApplicationController

    def index
        require 'httparty'
        @twitter_response = get_response("http://codefight.davidbanham.com/twitter")
        @facebook_response = get_response("http://codefight.davidbanham.com/facebook")
        @instagram_response = get_response("http://codefight.davidbanham.com/instagram")

        # SAVE

        save_feeds( @twitter_response, "twitter" )
        save_feeds( @facebook_response, "facebook" )
        save_feeds( @instagram_response, "instagram" )


        # returned_value = {
        #     twitter: @twitter_response || Feed.where(:type => "twitter").limit(3),
        #     instagram: @instagram_response || Feed.where(:type => "instagram").limit(3),
        #     facebook: @facebook_response || Feed.where(:type => "facebook").limit(3)
        # }

    end

    private

    def save_feeds( feed_response, type )
        if !feed_response
            return false
        end

        to_save = {}
        JSON.parse( feed_response ).each do |object|
            # to_save[key] = value
            object.each do |key, value|
                binding.pry
                to_save[key] = value
            end
        end
        # binding.pry   
    end

    def is_json?( response )
        begin
            JSON(response)
        rescue
            false
        end
    end

    def get_response( url )
        returned = HTTParty.get(url)
        is_json?( returned )
        # is_json?( response ) ? returned : "Sorry, this isn't valid."
    end

end


# Instagram -> username, picture
# Facebook -> name, status
# Twitter -> username, tweet/




# Feed.where(:type => "twitter")
