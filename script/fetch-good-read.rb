#!/usr/bin/env ruby
require 'rss'
require 'open-uri'
require 'json'

url = 'https://www.goodreads.com/review/list_rss/150379591?key=WUhMZYCSeQn7n_6sqH20k8uhCzw_k-ltsbgRuk9duHVIx85q&shelf=to-read'

URI.open(url) do |rss|
  feed = RSS::Parser.parse(rss)
  books = feed.items.map do |item|
    # find the index of the 4th \n in itm.description string
    # and return the substring from 0 to that index
    description = item.description.split("\n")

    {
      'name' => item.title,
      'image' => description[2],
      'author' => description[3].gsub("author: ", "").strip,
    }
  end

  File.open('../website/_data/books.json', 'w') do |f|
    f.write(JSON.pretty_generate(books))
  end

  puts 'Books saved to books.json'
end
