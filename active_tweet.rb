require 'rubygems'
require 'open-uri'
require 'json'
require 'uri'

class ActiveTweet
  def initialize(data = [])
    @data = data
    @hashtag = nil
    @links = false
    @limit = 100
  end

  def self.mock(data)
    ActiveTweet.new(data)
  end

  def find_by_hashtag(hashtag)
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
    @data = @data.grep /\##{ @hashtag }/
    @data = @data.map { |tweet| URI.extract(tweet) }.flatten.compact.uniq if @links
    @data.first(@limit)
  end
end
