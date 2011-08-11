require 'rubygems'
require 'open-uri'
require 'json'

class ActiveTweet
  class << self
    def mock(data)
      tap do
        @data = data
      end
    end

    def find_by_hashtag(hashtag)
      tap do
      end
    end

    def collect
      if @data
        @data
      end
    end
  end
end
