require_relative '../lifx/lights'

if ARGV.empty?
  puts Lights.all
else
  ARGV.each do |tag|
    puts Lights.with_tag tag
  end
end
