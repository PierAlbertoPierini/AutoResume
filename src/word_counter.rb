def count_words(string_text)
  string_text.scan(/\w+/).reduce(Hash.new(0)){|res,w| res[w.downcase]+=1;res}
end

#file = File.open ('myfile.txt', 'r')
