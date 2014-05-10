require 'lifx'
require_relative '../lib/lights'

light      = ARGV[0] || 'luke'
color      = ARGV[1] || 'white'
brightness = ARGV[2].to_f || 1

lifx_color = LIFX::Color.send(color, :brightness => brightness)
puts "Color: #{lifx_color}"

Lights[light].set_color(lifx_color)

LIFX::Client.lan.flush
