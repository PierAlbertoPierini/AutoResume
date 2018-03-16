class WordCounter
  def self.scan_words(string_text)
    string_text.scan(/\w+/).reduce(Hash.new(0)){|res,w| res[w.downcase]+=1;res}
  end
end

def self.count_words(string)
  words = string.split(' ')
  frequency = Hash.new(0)
  words.each { |word| frequency[word.downcase] += 1 }
  return frequency
end

#class WordAnalyzer
#  def initialize(text,filter)
#    @words = text.split
#    @filter = filter.split
