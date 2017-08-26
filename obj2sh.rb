#!/usr/bin/env ruby

#### Coded By Virus007 ####

require "colorize"

# Check argv
unless ARGV.length == 1
    puts "Usage : ./obj2sh.rb [File]"
    exit
end

#check platform
unless RUBY_PLATFORM =~ /linux/
    puts "This Script Just Run In Linux!".red
    exit
end

$file = ARGV[0]

puts "[+] Generating Shell code!\n".green

run = %x{for i in `objdump -d #{$file} | tr '\t' ' ' | tr ' ' '\n' | egrep '^[0-9a-f]{2}$' ` ; do echo -n \"\\x$i\" ; done}
# puts run.red

## Deleting Bad Char
puts "[+] Deleting Bad Char!\n".green

run.gsub! "\\x00", ""
run.gsub! "\\x0a", ""
run.gsub! "\\xff", ""

puts "[!] Shell code Size : #{run.size}\n\n".yellow

puts run.red