def count_words(string)
  string.scan(/\w+/).reduce(Hash.new(0)){|res,w| res[w.downcase]+=1;res}
end
