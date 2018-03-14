# File from http://rubywordcount.com/



#require 'json'

class Analyser
  def initialize(text, filter)
    @words = text.split
    @filter = filter.split
  end

  def word_count
    filtered_words.size
  end

  def word_occurrences
    @word_occurrences ||= filtered_words.inject(Hash.new(0)) do |result, word|
      result[word] += 1
      result
    end
  end

  def highest_occurring_words
    word_occurrences.group_by { |key, value| value }.max_by { |key, value| key }.last
  end

  def longest_words
    filtered_words.inject({}) do |result, word|
      result[word] = word.length
      result
    end.group_by { |key, value| value }.max_by { |key, value| key }.last
  end

  def html_list
    list = ""
    word_occurrences.sort_by { |key, value| value }.reverse.each do |key, value|
      list << "  <li>#{key}: #{value}</li>\n"
    end
    "<ul>\n" + list + "</ul>"
  end

  #def json_list
  #  JSON.parse(word_occurrences.to_json)
  #end

private

  def filtered_words
    @filtered_words ||= @words.reject do |word|
      # Downcase so that Hello and hello count as two occurrences
      word.downcase!
      @filter.include?(word)
    end
  end
end
