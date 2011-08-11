require 'active_tweet'

Given /^that there are at least (\d+) tweets for the term \#(\w+)$/ do |number_of_tweets,hashtag|
  tweets = (1..number_of_tweets.to_i).map { |i| "Tweet number #{ i } for ##{ hashtag }" }
  @tweets = ActiveTweet.mock(tweets)
end

When /^I search for \#(\w+)$/ do |hashtag|
  @tweets = @tweets.find_by_hashtag(hashtag)
end

Then /^I should get (\d+) tweets$/ do |number_of_tweets|
  @tweets.collect.count.should == number_of_tweets.to_i
end
