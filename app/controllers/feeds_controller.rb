class FeedsController < ApplicationController

  def index

    # this uses the get_reponse function to parse the JSON from the below URLs
    @twitter_response = get_response("http://codefight.davidbanham.com/twitter")
    @facebook_response = get_response("http://codefight.davidbanham.com/facebook")
    @instagram_response = get_response("http://codefight.davidbanham.com/instagram")


    # this uses the save_feed method on the various urls from above as well as takes in the network name relevant to each social network
    save_feed( @twitter_response, "twitter" )
    save_feed( @instagram_response, "instagram" )
    save_feed( @facebook_response, "facebook" )


    # this is the overall json that we want to output to localhost:3000 which creates a hash with the twitter, facebook and instagram content
    # I could return the entire set of data about the tweet also, but the challenge mentioned specifically to give twitter: [tweets] etc so that is why I have used pluck to pull out just the tweets, pictures and statuses from the social networks - ps the best tweet is the one from Will Ferrell - love it!!!!
    # ordering the returned values by desc allows me to get the last 3 instead of the first 3 if I didn't include .order
    returned_value = {
      twitter:  Feed.where(network: "twitter").order(created_at: :desc).limit(3).pluck(:tweet),
      instagram: Feed.where(network: "instagram").order(created_at: :desc).limit(3).pluck(:picture),
      facebook: Feed.where(network: "facebook").order(created_at: :desc).limit(3).pluck(:status)
    }

    render json: returned_value
  end

  private

  # this saves the feed to the database if there is a valid feed_response given to it. save_feed takes in feed_response and network (i.e. facebook , twitter, instagram)
  # if feed_response is valid, then for each object in the parsed feed_reponses, create an object called to_save, which has the network instantiated by telling the hash to add in whatever network it sees, then it will add in the rest of the info about that object using merge to put that into the same object so this will be adding in for example the username and tweet on top in addtion to the network of twitter.
  # Feed.create will then create a new line item in the model, and save it to the database with the to_save hash of data
  def save_feed( feed_response, network )
    if feed_response
      JSON.parse( feed_response ).each do |object|
        to_save = { network: network }
        to_save = to_save.merge( object )
        Feed.create( to_save )
      end
    end
  end


  # checks to see if the input is JSON by calling JSON on whatever is passed into it - if it throws an error - then rescue it from the begin block and return false
  def is_json?( response )
    begin
      JSON(response)
    rescue
      false
    end
  end


  # gets a response in JSON format using the parser HTTParty gem - it also uses the is_json function to see whether or not it's json that is given from the URL - if it's not then return false - if it is return the JSON string
  def get_response( url )
    returned = HTTParty.get(url)
    is_json?( returned )
  end

end