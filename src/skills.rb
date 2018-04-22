class Skills
  def initialize(text)
    @words = text.split
  end


# TODO:
# process every line in a text file with ruby (version 2).
file='file.txt'
f = File.open(file, "r")  # r = read
f.each_line { |line|
  puts line
}
f.close

# TODO: append lines in a File.read
open('myfile.out', 'a') do |f|
  f << "and again ...\n"
end

def skills_text(number_words)
  list = highest_occurring_words(number_words).sort_by {|word, occs| occs}.reverse.map do |word, occs|
    "  #{word}: #{occs}"
  end.join("\n")
  "\n" + list + "\n"
end

private

  def filtered_skills
      filtered_words ||= @words.reject do |word|
        word.downcase!
        @filter.include?(word)
      end
  end
end
