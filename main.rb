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
require_relative 'src/word_counter.rb'


$root = TkRoot.new( :title => "AutoResume", :width => 400, :height => 300)

Tk::Tile::Frame.new($root).grid( :padx => 350, :pady => 250)
Tk::Tile::SizeGrip.new($root).grid( :column => 999, :row => 999, :sticky => 'se')
TkOption.add '*tearOff', 0

# Variables

# Menu Actions
menu_click = Proc.new {
   Tk.messageBox(
      'type'    => "ok",
      'icon'    => "info",
      'title'   => "Message",
      'message' => "Function not supported"
   )
}

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
              'command'   => proc {openDocument},
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

# End menu

# Window menagement
content = Tk::Tile::Frame.new($root) {padding "10 5 10 10"}.grid( :sticky => 'nsew')
TkGrid.columnconfigure $root, 0, :weight => 1; TkGrid.rowconfigure $root, 0, :weight => 1

# Start Text

# Start Notebook

notebook = Tk::Tile::Notebook.new($root){place('height' => 480, 'width' => 700, 'x' => 10, 'y' => 10)}

f1 = TkFrame.new(notebook)
f2 = TkFrame.new(notebook)
f3 = TkFrame.new(notebook)
f4 = TkFrame.new(notebook)
f5 = TkFrame.new(notebook)
f6 = TkFrame.new(notebook)
f7 = TkFrame.new(notebook)
f8 = TkFrame.new(notebook)

notebook.add f1, :text => 'Stats', :state => 'normal'
notebook.add f2, :text => 'Soft Skills', :state => 'disabled'
notebook.add f3, :text => 'Hard Skills', :state => 'disabled' 
notebook.add f4, :text => 'Technical Knowledge', :state => 'disabled'
notebook.add f5, :text => 'Volunteer Experiences & Causes', :state => 'disabled'
notebook.add f6, :text => 'Employment History', :state => 'disabled'
notebook.add f7, :text => 'Education and Training', :state => 'disabled'
notebook.add f8, :text => 'Exceptions', :state => 'normal'

# End Notebook

# Stats
my_resume = TkText.new(f1) {width 40; height 25; borderwidth 1; wrap 'word'; font TkFont.new('times 9 italic')}.grid( :column => 0, :row => 1)
my_resume.insert(1.0, "here is my text to insert")
text_my_resume = my_resume.get("1.0", 'end')

# working button
TkButton.new(f1) do 
	text 'Clear'
	command do
	my_resume.delete("1.0", 'end')
    end
    grid( :column => 0, :row => 2, :sticky => 'w')
 end
 
lab	=	TkLabel.new(f1){text text_my_resume}.grid( :column => 2, :row => 1)
 
TkButton.new(f1) do 
	text 'Send'
	command do
	my_resume.delete("1.0", 'end')
    end
    grid( :column => 0, :row => 2, :sticky => 'e')
end

# my_resume.insert 'end', "Paste your resume"
#Tk::messageBox :message => count_words(my_resume).sort

job_application = TkText.new(f1) {width 40; height 25; borderwidth 1; wrap 'word'; font TkFont.new('times 9 italic')}.grid( :column => 1, :row => 1)
job_application.insert(1.0, 'Paste job post')
job_my_resume = job_application.get("1.0", 'end')

TkButton.new(f1) do 
	text 'Clear'
	command do
	job_application.delete("1.0", 'end')
    end
    grid( :column => 1, :row => 2, :sticky => 'w')
 end
 
lab	=	TkLabel.new(f1){text job_my_resume}.grid( :column => 3, :row => 1)
 
TkButton.new(f1) do 
	text 'Send'
	command do
	job_application.delete("1.0", 'end')
    end
    grid( :column => 1, :row => 2, :sticky => 'e')
end

# Exceptions
# Find how to add automatically to add new exceptions
except_001 = TkEntry.new(f8)
variable001 = TkVariable.new
except_001.textvariable = variable001
except_001.value = "Ciao"
except_001.place('height' => 25, 'width'  => 150, 'x'   => 10, 'y'   => 10)

# Help Window
# t = TkToplevel.new(parent)
# Tk::messageBox :message => 'Have a good day'

Tk.mainloop
