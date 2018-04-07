require 'json'

class WordsAnalyser
  def initialize(text, filter)
    @words = text.split
    @filter = filter.split
  end

  def highest_occurring_words(number_words)
    Hash[words_occurrences.sort_by { |k,v| -v }[0..(number_words-1)]]
  end

  def words_occurrences
    word_occurrences ||= filtered_words.inject(Hash.new(0)) do |result, word|
      result[word] += 1
      result
    end
  end

  def highest_occurring_words_list(number_words)
    list = highest_occurring_words(number_words).sort_by {|word, occs| occs}.reverse.map do |word, occs|
      "  #{word}: #{occs}"
    end.join("\n")
    "\n" + list + "\n"
  end

  def text_list
    list = words_occurrences.sort_by {|word, occs| occs}.reverse.map do |word, occs|
      "  #{word}: #{occs}"
    end.join("\n")
    "\n" + list + "\n"
  end

  def html_list
    list = words_occurrences.sort_by {|word, occs| occs}.reverse.map do |word, occs|
      "  <li>#{word}: #{occs}</li>"
    end.join("\n")
    "<ul>\n" + list + "\n</ul>"
  end

  def json_list
    JSON.parse(filtered_words.to_json)
  end
end

private

def filtered_words
    filtered_words ||= @words.reject do |word|
      word.downcase!
      @filter.include?(word)
end
end
