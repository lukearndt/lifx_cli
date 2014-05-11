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

    MINUTE_COLORS =
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
      9 => 'white',
    }

    NINTH_MINUTE_ALT_COLOR = LIFX::Color.hsbk(0, 0, 0, 0)

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

    def get_on_a_minute
      sleep(60 - Time.now.sec)
    end

    def tick
      if time_not_found?
        display_nothing
      else
        display_minutes
        display_tens_of_minutes if Time.now.min % 10 == 0
        display_hours if Time.now.min == 0
      end
    end

    def time_not_found?
      Time.now.hours % 12 == 4 && Time.now.min == 4
    end

    def display_time
      display_unavailability_warnings unless all_lights_available?

      display_hours
      display_tens_of_minutes
      display_minutes
    end

    def display_nothing
      darkness = LIFX::Color.hsbk(0,0,0,0)
      all_lights.each do |lights|
        lights.set_color darkness
      end
    end

    def all_lights
      [@hour_lights, @tens_of_minutes_lights, @minute_lights]
    end

    # Hours

    def display_hours
      @hour_lights.set_color hour_color
      puts "Hour lights set #{hour_color_name} as we are in hour #{Time.now.hour} (15 % 6 = #{15 % 6})."
    end

    def hour_color
      LIFX::Color.send(hour_color_name)
    end

    def hour_color_name
      HOUR_COLORS[Time.now.hour % 6]
    end

    # Tens of minutes

    def display_tens_of_minutes
      @tens_of_minutes_lights.set_color tens_of_minutes_color
      puts "Tens of minutes lights set #{tens_of_minutes_color_name} as we are in minute #{Time.now.min}."
    end

    def tens_of_minutes_color
      LIFX::Color.send(tens_of_minutes_color_name)
    end

    def tens_of_minutes_color_name
      TENS_OF_MINUTES_COLORS[Time.now.min / 10]
    end

    # Minutes

    def display_minutes
      @minute_lights.set_color minute_color
      if ninth_minute?
        display_ninth_minute
      else
        puts "Minute lights set #{minute_color_name} as we are in minute #{Time.now.min}."
      end
    end

    def minute_color
      LIFX::Color.send(minute_color_name)
    end

    def minute_color_name
      MINUTE_COLORS[Time.now.min % 10]
    end

    # Ninth minute

    def ninth_minute?
      Time.now.min % 10 == 9
    end

    def display_ninth_minute
      @minute_lights.sine(NINTH_MINUTE_ALT_COLOR,
                          :cycles => 10,
                          :period => 6)
      puts "Pulsing minute lights as we are on the ninth minute of the ten."
    end
  end
end
