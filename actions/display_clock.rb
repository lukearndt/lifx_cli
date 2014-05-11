require_relative '../routines/rainbow_clock'

brightness          = ARGV[0] || 1
hours_tag           = ARGV[1] || 'hours'
tens_of_minutes_tag = ARGV[2] || 'tens_of_minutes'
minutes_tag         = ARGV[3] || 'minutes'
all_lights_tag      = ARGV[4]

Routines::RainbowClock.new(brightness, hours_tag, tens_of_minutes_tag, minutes_tag, all_lights_tag).run
