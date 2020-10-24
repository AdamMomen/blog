require 'dotenv/load'

require_relative 'tweet_to_image.rb'
require_relative 'waka.rb'
#require 'twitter'
require 'pry'
require 'octokit'

# Now playing: Cher - Believe
#  twitter = Twitter::REST::Client.new do |config|
#    config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
#    config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
#    config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
#    config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
#  end

# latest_tweet = twitter.user_timeline("adammomen8", count: 1, exclude_replies: true, include_rts: false).first
# tweet_id = latest_tweet.id
# tweet_url = latest_tweet.uri.to_s

#  tweet_image = TweetToImage.url(tweet_id)

## Create new readme
template = File.open('README_TEMPLATE.md', 'r')
text = template.read

## Get stats from wakaTime api
waka_data = Waka.getDevHours

## Stars
client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
recent_stars = client.stargazers("adammomen/adammomen", per_page: 100).map(&:login).reverse

f = File.new('README.md', 'w')
f.write(
    text
    .gsub("<star-count>", recent_stars.count.to_s)
    #.gsub("<tweet-image-url>", tweet_image).gsub("<tweet-url>", tweet_url)
    .gsub("<code-stats>", waka_data)
    .gsub("<stars>", recent_stars.join(", "))
)
f.close
