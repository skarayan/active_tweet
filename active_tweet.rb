require 'rubygems'
require 'open-uri'
require 'json'
require 'uri'

class ActiveTweet
  @links = false

  class << self
    # this is a way to imitate Twitter for testing purposes
    def mock(data)
      tap do
        @data = data
      end
    end

    def find_by_hashtag(hashtag)
      tap do
        @hashtag = hashtag
      end
    end

    def links
      tap do
        @links = true
      end
    end

    def collect
      if @data
        @data = @data.grep /\##{ @hashtag }/
      end
      @data = @data.map { |tweet| URI.extract(tweet) }.flatten.compact.uniq if @links
      @data
    end
  end
end
