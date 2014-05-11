require 'lifx'
require_relative '../lifx/lights'

light      =  ARGV[0] || 'luke'
color      =  ARGV[1] || 'white'
brightness = (ARGV[2] || 1).to_f
kelvin     = (ARGV[3] || 3500).to_f

lifx_color = LIFX::Color.send(color, :brightness => brightness, :kelvin => kelvin)
puts "Color: #{lifx_color}"

Lights[light].set_color(lifx_color)

LIFX::Client.lan.flush
