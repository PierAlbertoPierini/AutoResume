#!/usr/bin/env ruby
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

# require_relative 'src/calculate.rb'

root = TkRoot.new {title "AutoResume"}
content = Tk::Tile::Frame.new(root)
TkOption.add '*tearOff', 0

# Variables

# Start Menu

menu_click = Proc.new {
   Tk.messageBox(
      'type'    => "ok",  
      'icon'    => "info",
      'title'   => "Title",
      'message' => "Message"
   )
}

file_menu = TkMenu.new(root)

file_menu.add('command',
              'label'     => "New...",
              'command'   => menu_click,
              'underline' => 0)
file_menu.add('command',
              'label'     => "Open...",
              'command'   => menu_click,
              'underline' => 0)
file_menu.add('command',
              'label'     => "Close",
              'command'   => menu_click,
              'underline' => 0)
file_menu.add('separator')
file_menu.add('command',
              'label'     => "Save",
              'command'   => menu_click,
              'underline' => 0)
file_menu.add('command',
              'label'     => "Save As...",
              'command'   => menu_click,
              'underline' => 5)
file_menu.add('separator')
file_menu.add('command',
              'label'     => "Exit",
              'command'   => menu_click,
              'underline' => 3)


menu_bar = TkMenu.new
menu_bar.add('cascade',
             'menu'  => file_menu,
             'label' => "File")

root.menu(menu_bar)

# End menu

content = Tk::Tile::Frame.new(root) {padding "10 5 10 10"}.grid( :sticky => 'nsew')
TkGrid.columnconfigure root, 0, :weight => 1; TkGrid.rowconfigure root, 0, :weight => 1

# Start Text

my_resume = TkText.new(content) {width 50; height 20; borderwidth 1; wrap 'word'; font TkFont.new('times 9 italic')}.grid( :column => 0, :row => 1, :sticky => 'w')
my_resume.insert 'end', "Paste your resume"

job_application = TkText.new(content) {width 50; height 20; borderwidth 1; wrap 'word'; font TkFont.new('times 9 italic')}.grid( :column => 1, :row => 1, :sticky => 'e')
job_application.insert 'end', "Paste job post"

# End Text

# Start Buttons

Tk::Tile::Button.new(content) {text 'Clear'; command {calculate}}.grid( :column => 0, :row => 2, :sticky => 'w')
Tk::Tile::Button.new(content) {text 'Paste'; command {calculate}}.grid( :column => 0, :row => 2, :sticky => 'e')
Tk::Tile::Button.new(content) {text 'Clear'; command {calculate}}.grid( :column => 1, :row => 2, :sticky => 'w')
Tk::Tile::Button.new(content) {text 'Paste'; command {calculate}}.grid( :column => 1, :row => 2, :sticky => 'e')



# End Buttons

Tk.mainloop
