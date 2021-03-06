require 'active_tweet'

Given /^that there are at least (\d+) tweets for the term \#(\w+)$/ do |number_of_tweets,hashtag|
  tweets = (1..number_of_tweets.to_i).map { |i| "Tweet number #{ i } for ##{ hashtag }" }
  @tweets = ActiveTweet.mock(tweets)
end

Given /^that there are (\d+) links and a few tweets associated with the term \#(\w+)$/ do |number_of_links,hashtag|
  tweets  = (1..5).map { |i| "Tweet number #{ i } for ##{ hashtag }" }
  tweets += (1..number_of_links.to_i).map { |i| "Some URL http://something#{ i }.com for ##{ hashtag }" }
  @tweets = ActiveTweet.mock(tweets)
end

Given /^that there are (\d+) unique links out of (\d+) total associated with the term \#(\w+)$/ do |number_of_unique_links,number_of_links,hashtag|
  total_dups = number_of_links.to_i - number_of_unique_links.to_i
  number_of_unique_links = number_of_unique_links.to_i - 1
  tweets  = (1..total_dups).map { |i| "Some URL http://something.com for ##{ hashtag }" }
  tweets += (1..number_of_unique_links).map { |i| "Some URL http://something#{ i }.com for ##{ hashtag }" }
  @tweets = ActiveTweet.mock(tweets)
end

When /^I search for \#(\w+)$/ do |hashtag|
  @tweets = @tweets.find_by_hashtag(hashtag)
end

When /^limit to (\d+) results$/ do |count|
  @tweets = @tweets.limit(count.to_i)
end

Then /^I should get (\d+) tweets$/ do |number_of_tweets|
  @tweets.map.count.should == number_of_tweets.to_i
end

When /^filter for links$/ do
  @tweets = @tweets.links
end

Then /^I should get (\d+) links$/ do |number_of_links|
  @tweets.map.count.should == number_of_links.to_i
end
