# File from http://rubywordcount.com/

text = WordsOnlySanitizer.to_words(File.read('words.txt'))
filter = WordsOnlySanitizer.to_words(File.read('filter_words.txt'))
analyser = Analyser.new(text, filter)

puts "Word count after filtering is: #{analyser.word_count}"
puts "\n"

puts "The most frequent words are:"
analyser.highest_occurring_words.each do |key, value|
  puts "  - #{key}: #{value} occurences"
end
puts "\n"

puts "The longest words are:"
analyser.longest_words.each do |word|
  puts "  - #{word.first}: #{word.last} characters"
end
puts "\n"

puts "Word list:"
puts analyser.html_list

#puts "JSON object:"
#puts analyser.json_list
