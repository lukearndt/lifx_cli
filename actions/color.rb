require 'lifx'
require_relative '../lifx/lights'

find_by    =  ARGV[0]
selector   =  ARGV[1] || 'luke'
color      =  ARGV[2] || 'white'
brightness = (ARGV[3] || 0.2).to_f # make testing less blinding
kelvin     = (ARGV[4] || 3500).to_f

lifx_color = LIFX::Color.send(color, :brightness => brightness, :kelvin => kelvin)
puts "Color: #{lifx_color}"

lights = if find_by == 'tag'
  Lights[selector]
elsif find_by == 'label'
  Lights.with_label(selector)
end

lights.set_color(lifx_color)

LIFX::Client.lan.flush
