#!/usr/bin/env ruby
#  encoding: UTF-8
#
#  word_analyser.rb
#
#  Copyright 2017 Pier Alberto <pieralbertopierini@gmail.com>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#
#

class Analyser
  def initialize(text, filter)
    @words = text.split
    @filter = filter.split
  end
  def word_occurrences
    @word_occurrences string_text.scan(/\w+/).reduce(Hash.new(0)){|res,w| res[w.downcase]+=1;res}
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

  def text_list
    list = ""
    word_occurrences.sort_by { |key, value| value }.reverse.each do |key, value|
      list << "  #{value}: #{key}\n"
    end
    "\n" + list + " "
  end

  private

  def filtered_words
    @filtered_words ||= @words.reject do |word|
      @filter.include?(word)
    end
  end
end
