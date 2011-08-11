require 'active_tweet'

hashtag = ARGV.shift
links = ActiveTweet.new.find_by_hashtag(hashtag).limit(100).links.map

links.each_with_index do |link,index|
  puts "#{ index + 1 } #{ link }"
end

