#!/usr/bin/env ruby
#  encoding: UTF-8
#
#  main.rb
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

require 'tk'
require 'tkextlib/tile'
require_relative 'src/words_preprocessing.rb'
require_relative 'src/words_analyser.rb'

# Start Root window mainloop
$root = TkRoot.new( :title => "AutoResume", :width => 640, :height => 480)
# Contents
content = Tk::Tile::Frame.new($root) {padding "3 3 3 3"}
content.grid :sticky => 'nsew'
#config_column = TkGrid.columnconfigure $root, 0, :weight => 1
#config_row = TkGrid.rowconfigure $root, 0, :weight => 1
resize_window = Tk::Tile::SizeGrip.new($root)
resize_window.grid :column => 999, :row => 999, :sticky => 'nsew'
#TkOption.add '*tearOff', 0


# Variables example
$testVariable_one = TkVariable.new
$testVariable_two = TkVariable.new

# Menu Actions
menu_click = Proc.new {
   Tk.messageBox(
      'type'    => "ok",
      'icon'    => "info",
      'title'   => "Message",
      'message' => "Function not supported"
   )
}
## TODO: ope and save file
ar_openfile = Proc.new {
   Tk.getOpenFile
}
ar_savefile = Proc.new {
   Tk.getSaveFile
}

# File menu
file_menu = TkMenu.new($root, 'tearoff' => false)

file_menu.add('command',
              'label'     => "New...",
              'command'   => menu_click,
              'underline' => 0)
$root.bind('Control-N', proc {openDocument})
file_menu.add('command',
              'label'     => "Open...",
              'command'   => ar_openfile,
              'underline' => 0,
              'accel' =>'Ctrl-o')
$root.bind('Control-o', proc {openDocument})
file_menu.add('command',
              'label'     => "Close",
              'command'   => menu_click,
              'underline' => 0)
$root.bind('Control-c', proc {openDocument})
file_menu.add('separator')
file_menu.add('command',
              'label'     => "Save",
              'command'   => ar_savefile,
              'underline' => 0)
$root.bind('Control-S', proc {openDocument})
file_menu.add('command',
              'label'     => "Save As...",
              'command'   => menu_click,
              'underline' => 5)
file_menu.add('separator')
file_menu.add('command',
              'label'     => "Quit",
              'command'   => proc { exit },
              'underline' => 0,
              'accel' => 'Ctrl-q')
$root.bind('Control-q', proc {exit})

# Edit menu
edit_menu = TkMenu.new($root, 'tearoff' => false)

edit_menu.add('command',
              'label'     => "New...",
              'command'   => menu_click,
              'underline' => 0)

# Help menu
help_menu = TkMenu.new($root, 'tearoff' => false)

help_menu.add('command',
              'label'     => "New...",
              'command'   =>  menu_click,
              'underline' => 0)
# Add on the menu bar components
menu_bar = TkMenu.new

menu_bar.add('cascade',
             'menu'  => file_menu,
             'label' => "File")
menu_bar.add('cascade',
             'menu'  => edit_menu,
             'label' => "Edit")
menu_bar.add('cascade',
             'menu'  => help_menu,
             'label' => "Help")

$root.menu(menu_bar)

# Start Notebook

notebook = Tk::Tile::Notebook.new($root)
notebook.grid :column => 0, :row => 0, :sticky => 'nsew'

f1 = TkFrame.new(notebook)
f2 = TkFrame.new(notebook)
f3 = TkFrame.new(notebook)
f4 = TkFrame.new(notebook)
f5 = TkFrame.new(notebook)
f6 = TkFrame.new(notebook)
f7 = TkFrame.new(notebook)
f8 = TkFrame.new(notebook)

notebook.add f1, :text => 'Stats', :state => 'normal'
notebook.add f2, :text => 'Soft Skills', :state => 'normal'
notebook.add f3, :text => 'Hard Skills', :state => 'disabled'
notebook.add f4, :text => 'Technical Knowledge', :state => 'disabled'
notebook.add f5, :text => 'Volunteer Experiences & Causes', :state => 'disabled'
notebook.add f6, :text => 'Employment History', :state => 'disabled'
notebook.add f7, :text => 'Education and Training', :state => 'disabled'
notebook.add f8, :text => 'Exceptions', :state => 'disabled'

# F1 (Stats)
#Variables for the words Preprocessing and Analyser
filter_text = WordsPreprocessing.to_words(File.read('exceptions/filter_list.txt'))
# variable to change in automatic the labels
$resultsResume = TkVariable.new
$resultsJob = TkVariable.new

my_resume = TkText.new(f1) {width 40; height 25; borderwidth 1; wrap 'word'; font TkFont.new('times 10 italic')}
my_resume.grid :row => 1, :column => 0
my_resume.insert(1.0, "here is my text to insert")
scroll_bar_resume = Tk::Tile::Scrollbar.new(f1, 'command' => proc { |*args| my_resume.yview *args })
scroll_bar_resume.grid :row => 1, :column => 1, :sticky => 'ns'
my_resume.yscrollcommand(proc { |first,last| scroll_bar_resume.set(first,last) })

Tk::Tile::Button.new(f1) do
	text 'Clear'
	command do
	my_resume.delete("1.0", 'end')
  end
  grid( :column => 0, :row => 2, :sticky => 'w')
 end

# Lable and Combobox
label_numberwords = Tk::Tile::Label.new(f1) {text 'Number Words to show:'}
label_numberwords.grid :row => 0, :column => 0, :sticky => 'e'

$number_words_var = TkVariable.new
numberwords = Tk::Tile::Combobox.new(f1) { textvariable $number_words_var }
numberwords.grid :row => 0, :column => 2, :sticky => 'w'
numberwords.bind("<ComboboxSelected>") { $number_words = $number_words_var.to_i }
numberwords.values = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

Tk::Tile::Button.new(f1) do
	text 'Count Words'
	command proc{resume_text = WordsPreprocessing.to_words(my_resume.get("1.0", 'end'));
      resume_analysed = WordsAnalyser.new(resume_text, filter_text);
      $resultsResume.value = resume_analysed.text_list_highest($number_words)}
  grid( :column => 0, :row => 2, :sticky => 'e')
end

label_1	=	Tk::Tile::Label.new(f1){textvariable $resultsResume}
label_1.grid :row => 1, :column => 4

job_application = TkText.new(f1) {width 40; height 25; borderwidth 1; wrap 'word'; font TkFont.new('times 10 italic')}
job_application.grid :row => 1, :column => 2
job_application.insert(1.0, 'Paste job post')
scroll_bar_job_application = Tk::Tile::Scrollbar.new(f1, 'command' => proc { |*args| job_application.yview *args })
scroll_bar_job_application.grid :column => 3, :row => 1, :sticky => 'ns'
job_application.yscrollcommand(proc { |first,last| scroll_bar_job_application.set(first,last) })

Tk::Tile::Button.new(f1) do
	text 'Clear'
	command do
	job_application.delete("1.0", 'end')
  end
  grid( :column => 2, :row => 2, :sticky => 'w')
end

label_2	=	Tk::Tile::Label.new(f1){textvariable $resultsJob}
label_2.grid :column => 6, :row => 1

Tk::Tile::Button.new(f1) do
	text 'Count Words'
   command proc{job_text = WordsPreprocessing.to_words(job_application.get("1.0", 'end'));
      job_analysed = WordsAnalyser.new(job_text, filter_text);
      $resultsJob.value = job_analysed.text_list_highest($number_words)}
  grid( :column => 2, :row => 2, :sticky => 'e')
end

# F2 (Soft Skill)
entry001 = TkEntry.new(f2)
variable001 = TkVariable.new
variable001.value = "Enter any text Variable"
entry001.grid :column => 0, :row => 1

entry002 = TkEntry.new(f2)
variable002 = TkVariable.new
variable002.value = "Enter any text Variable"
entry002.grid :column => 0, :row => 2

entry003 = TkEntry.new(f2)
variable003 = TkVariable.new
variable003.value = "Enter any text Variable"
entry003.grid :column => 0, :row => 3

TkWinfo.children(f2).each {|w| TkGrid.configure w, :padx => 5, :pady => 5}
# End root mainloop
Tk.mainloop
