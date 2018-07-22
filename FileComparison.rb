require_relative "CommandLineOptionsParser"
require_relative "FolderParser"
require_relative "ComparedObjects"
require_relative "Utils"
require 'terminal-table'
require 'phash'

options = CommandLineOptionsParser.parse(ARGV)

objects =  FolderParser.parse(options.folder1, options.folder2)

head = [COLOR_LIGHT_BLUE + options.folder1 + COLOR_NC, COLOR_LIGHT_BLUE + options.folder2 + COLOR_NC, "Duplicate %", "A|B|I|T|V"]
rows = []

objects.each do |obj|
  file1 = obj.get_file1.split('/')
  file1 = file1[file1.length - 1]
  file2 = obj.get_file2.split('/')
  file2 = file2[file2.length - 1]
  rows << [COLOR_GREEN + file1 + COLOR_NC, COLOR_GREEN + file2 + COLOR_NC, obj.get_simularity, obj.get_file_type]
end

table = Terminal::Table.new :headings => head, :rows => rows
table.align_column(2, :center)
table.align_column(3, :center)
puts table