require_relative '../lights'

module Routines
  class Wakeup

    def initialize(tag)
      begin
        @lights = Lights[tag]
      rescue Lights::TagNotFound
        puts "You specified the tag '#{tag}' but it was not found on the network."
        exit(1)
      end
    end

    def run(
        sunrise_duration: 30,
        grace_period: 30,
        raves: 1,
        party_length: 10,
        encore_delay: 60,
        aftermath_brightness: 0.5
      )
      dim_to_nothing
      turn_on
      unleash_sunrise(sunrise_duration)
      allow_time_to_surface(grace_period)
      raves.times do
        glowstick_rave(party_length)
        allow_time_to_surface(encore_delay)
      end
      settle_down(aftermath_brightness)
    end

    private

    def turn_off
      puts "Turning off"
      @lights.turn_off
    end

    def dim_to_nothing
      puts "Dimming to nothing"
      @lights.set_color(darkness, :duration => 0)
    end

    def turn_on
      puts "Turning on"
      @lights.turn_on
    end

    def unleash_sunrise(seconds)
      puts "Fading in gently"
      @lights.set_color(bright_blue, :duration => seconds)
      sleep(seconds)
    end

    def allow_time_to_surface(seconds)
      puts "Allowing #{seconds} seconds to let you surface"
      sleep(seconds)
    end

    def glowstick_rave(seconds, period = 0.1)
      puts "Waking you up more violently"
      @lights.pulse(darkness, :cycles => seconds/period, :period => period)
      sleep(seconds)
    end

    def settle_down(aftermath_brightness)
      puts "Settling down to a more normal setting"
      @lights.set_color(lightness(aftermath_brightness))
    end

    def lightness(brightness = 0.5)
      LIFX::Color.white(:kelvin => 3500, :brightness => brightness)
    end

    def bright_blue
      LIFX::Color.blue(:brightness => 1)
    end

    def darkness
      LIFX::Color.blue(:brightness => 0)
    end
  end
end
