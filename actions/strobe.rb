require_relative '../lifx/lights'

tag               =  ARGV[0] || 'luke'
party_duration    = (ARGV[1] || 3).to_f
strobe_color      =  ARGV[2] || 'white'
strobe_brightness = (ARGV[3] || 1).to_f
flash_period      = (ARGV[4] || 0.1).to_f
base_color        =  ARGV[5]
base_brightness   = (ARGV[6] || 0).to_f

if base_color
  Lights[tag].set_color(
    LIFX::Color.send(base_color, :brightness => base_brightness)
  )
end

Lights[tag].pulse(
  LIFX::Color.send(strobe_color, :brightness => strobe_brightness),
  cycles: party_duration / flash_period,
  period: flash_period,
)
