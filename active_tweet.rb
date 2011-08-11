require 'rubygems'
require 'open-uri'
require 'json'
require 'uri'

class ActiveTweet
  def initialize(data = nil)
    @data = data
    @hashtag = nil
    @links = false
    @limit = 100
  end

  def self.mock(data)
    ActiveTweet.new(data)
  end

  def find_by_hashtag(hashtag)
    raise ArgumentError.new('Please provide a valid hashtag') unless hashtag.match(/^\w+$/)
    tap { @hashtag = hashtag }
  end

  def links
    tap { @links = true }
  end

  def limit(count)
    tap { @limit = count }
  end

  def map
    raise ArgumentError.new('No query was specified') if @hashtag.nil?
    if @data
      @data = @data.grep /\##{ @hashtag }/
    else
      @data = []
      hash = fetch

      while @data.count < @limit
        @data += hash['results'].map { |result| result['text'] }
        hash = fetch(hash['next_page']) rescue break
      end
    end
    @data = @data.map { |tweet| URI.extract(tweet, 'http') }.flatten.compact.uniq if @links
    @data.first(@limit)
  end

  private

  def fetch(params = URI.escape("?q=##{ @hashtag }"))
    url = "http://search.twitter.com/search.json#{ params }"
    json = open(url).read
    JSON.parse(json)
  end
end
