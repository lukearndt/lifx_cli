require_relative '../lifx/lights'

module Routines
  class RainbowClock

    HOUR_COLORS =
    {
      0 => 'red',
      1 => 'orange',
      2 => 'yellow',
      3 => 'green',
      4 => 'blue',
      5 => 'purple',
    }

    TENS_OF_MINUTES_COLORS =
    {
      0 => 'red',
      1 => 'orange',
      2 => 'yellow',
      3 => 'green',
      4 => 'blue',
      5 => 'purple',
    }

    MINUTES_COLORS =
    {
      0 => 'red',
      1 => 'orange',
      2 => 'yellow',
      3 => 'green',
      4 => 'blue',
      5 => 'purple',
      6 => 'pink',
      7 => 'cyan',
      8 => 'white',
      9 => '',
    }

    def initialize(hours_tag, minutes_tag, tens_of_minutes_tag)
      @hour_lights            = Lights[hours_tag]
      @tens_of_minutes_lights = Lights[tens_of_minutes_tag]
      @minute_lights          = Lights[minutes_tag]
    rescue Lights::TagNotFound
      puts "You specified a tag that was not found on the network."
      exit(1)
    end

    def run
      display_time
      get_on_a_minute
      while true
        tick
        sleep(60)
      end
    end

    private

    def all_lights_available?
      @hour_lights && @tens_of_minutes_lights && @minute_lights
    end

    def display_unavailability_warnings
      puts "I'm missing some lights!"
      puts "Hours lights: #{@hour_lights}"
      puts "Tens of minutes lights: #{@hour_lights}"
      puts "Minutes lights: #{@minute_lights}"
    end

    def display_time
      display_unavailability_warnings unless all_lights_available?

      display_hours
      display_tens_of_minutes
      display_minutes
    end

    def display_hours
      @hour_lights.set_color hour_color
      puts "Hour lights set #{hour_color} as we are in hour #{Time.now.hour}."
    end

    def hour_color
      LIFX::Color.send(HOUR_COLORS[(Time.now.hour / 6).to_i])
    end

    def display_tens_of_minutes

    end

    def display_minutes
      @minute_lights.set_color minute_color
      puts "Minute lights set #{minute_color} as we are in minute #{Time.now.min}."
    end

    def minute_color
      LIFX::Color.send(MINUTE_COLORS[(Time.now.min / 10).to_i])
    end

    def get_on_a_minute
      sleep(60 - Time.now.sec)
    end

    def tick
      display_minutes
      display_hours if Time.now.min == 0
    end

  end
end
