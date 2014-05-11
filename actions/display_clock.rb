require_relative '../routines/rainbow_clock'

hours_tag           = ARGV[0] || 'hours'
tens_of_minutes_tag = ARGV[1] || 'tens_of_minutes'
minutes_tag         = ARGV[2] || 'minutes'

Routines::RainbowClock.new(hours_tag, tens_of_minutes_tag, minutes_tag).run
