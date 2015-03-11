class FeedsController < ApplicationController

    def index
        require 'httparty'

        @twitter_response = get_response("http://codefight.davidbanham.com/twitter")
        @facebook_response = get_response("http://codefight.davidbanham.com/facebook")
        @instagram_response = get_response("http://codefight.davidbanham.com/instagram")

        save_feed( @twitter_response, "twitter" )
        save_feed( @instagram_response, "instagram" )
        save_feed( @facebook_response, "facebook" )

        returned_value = {
            twitter:  Feed.where(network: "twitter").order(created_at: :desc).limit(3).pluck(:tweet),
            instagram: Feed.where(network: "instagram").order(created_at: :desc).limit(3).pluck(:picture),
            facebook: Feed.where(network: "facebook").order(created_at: :desc).limit(3).pluck(:status)
        }

        render json: returned_value
    end

    private

    def save_feed( feed_response, network )
        if feed_response
            JSON.parse( feed_response ).each do |object|
              to_save = { network: network }
              to_save = to_save.merge( object )
              Feed.create( to_save )
            end
        end
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
