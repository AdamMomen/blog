require_relative "html_css_to_image.rb"

module TweetToImage
  def self.url(tweet_id)
    prevTweetId = File.open("./assets/tweet.txt").read.split
    if(Integer(prevTweetId[0]) == tweet_id)
      return nil
    end

    html = "<blockquote class='twitter-tweet' style='width: 400px;' data-dnt='true'>
<p lang='en' dir='ltr'></p>

<a href='https://twitter.com/fortnitegame/status/#{tweet_id}'></a>

</blockquote> <script async src='https://platform.twitter.com/widgets.js' charset='utf-8'></script>"
    
    File.write("./assets/tweet.txt", tweet_id)
    HtmlCssToImage.url(html: html, ms_delay: 3000, selector: ".twitter-tweet")
  end
end
