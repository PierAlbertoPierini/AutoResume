def count_words
  begin
    $testVariable_one = $string_text.scan(/\w+/).reduce(Hash.new(0)){|res,w| res[w.downcase]+=1;res}
  rescue
    $testVariable_one = ""
  end
end
