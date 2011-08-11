require 'active_tweet'

describe ActiveTweet do
  before(:each) do
    @tweets = ActiveTweet.mock([])
  end

  it 'should raise an error if calling map without a find_by_hashtag' do
    lambda { @tweets.map }.should raise_error(ArgumentError)
  end

  it 'should return an array when calling map' do
    @tweets.find_by_hashtag('hello').map.should be_a_kind_of(Array)
  end
end
