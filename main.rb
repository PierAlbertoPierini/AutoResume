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


root = TkRoot.new {title "AutoResume"}
Tk::Tile::Frame.new(root).grid( :padx => 350, :pady => 250)
Tk::Tile::SizeGrip.new(root).grid( :column => 999, :row => 999, :sticky => 'se')
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

# Start Menu

file_menu = TkMenu.new(root)

file_menu.add('command',
              'label'     => "New...",
              'command'   => menu_click,
              'underline' => 0)
file_menu.add('command',
              'label'     => "Open...",
              'command'   => proc {openDocument},
              'underline' => 0,
              'accel' =>'Ctrl-o')
root.bind('Control-o', proc {openDocument})
file_menu.add('command',
              'label'     => "Close",
              'command'   => menu_click,
              'underline' => 0)
file_menu.add('separator')
file_menu.add('command',
              'label'     => "Save",
              'command'   => ar_savefile,
              'underline' => 0)
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
root.bind('Control-q', proc {exit})

menu_bar = TkMenu.new
menu_bar.add('cascade',
             'menu'  => file_menu,
             'label' => "File")

root.menu(menu_bar)

# End menu

content = Tk::Tile::Frame.new(root) {padding "10 5 10 10"}.grid( :sticky => 'nsew')
TkGrid.columnconfigure root, 0, :weight => 1; TkGrid.rowconfigure root, 0, :weight => 1

# Start Text

# Start Notebook

notebook = Tk::Tile::Notebook.new(root){place('height' => 480, 'width' => 700, 'x' => 10, 'y' => 10)}

f1 = TkFrame.new(notebook)
f2 = TkFrame.new(notebook)
f3 = TkFrame.new(notebook)
f4 = TkFrame.new(notebook)
f5 = TkFrame.new(notebook)
f6 = TkFrame.new(notebook)
f7 = TkFrame.new(notebook)

notebook.add f1, :text => 'Stats'
notebook.add f2, :text => 'Soft Skills', :state => 'disabled'
notebook.add f3, :text => 'Hard Skills', :state => 'disabled' 
notebook.add f4, :text => 'Technical Knowledge', :state => 'disabled'
notebook.add f5, :text => 'Volunteer Experiences & Causes', :state => 'disabled'
notebook.add f6, :text => 'Employment History', :state => 'disabled'
notebook.add f7, :text => 'Education and Training', :state => 'disabled'

# End Notebook


my_resume = TkText.new(f1) {width 40; height 25; borderwidth 1; wrap 'word'; font TkFont.new('times 9 italic')}.grid( :column => 0, :row => 1)
# my_resume.insert 'end', "Paste your resume"
#Tk::messageBox :message => count_words(my_resume).sort

job_application = TkText.new(f1) {width 40; height 25; borderwidth 1; wrap 'word'; font TkFont.new('times 9 italic')}.grid( :column => 1, :row => 1)
job_application.insert 'end', "Paste job post"

# End Text

# Start Buttons

Tk::Tile::Button.new(f1) {text 'Clear'; command {calculate}}.grid( :column => 0, :row => 2, :sticky => 'w')
Tk::Tile::Button.new(f1) {text 'Send'; command {Tk::messageBox :message => count_words(my_resume).sort}}.grid( :column => 0, :row => 2, :sticky => 'e')
Tk::Tile::Button.new(f1) {text 'Clear'; command {calculate}}.grid( :column => 1, :row => 2, :sticky => 'w')
Tk::Tile::Button.new(f1) {text 'Paste'; command {calculate}}.grid( :column => 1, :row => 2, :sticky => 'e')

# End Buttons

Tk.mainloop
