require_relative '../routines/wakeup'

DEFAULTS =
{
  :tag                  => 'luke',
  :sunrise_duration     => 30,
  :grace_period         => 30,
  :raves                => 1,
  :party_length         => 10,
  :encore_delay         => 60,
  :aftermath_brightness => 0.5,
}

if ARGV.include? "--help"
  puts "Uses light to wake up everybody in the room."
  puts "Usage: #{Process.argv0} tag [sunrise_duration grace_period raves party_length encore_delay aftermath_brightness]"
  puts "Defaults: #{Process.argv0} #{DEFAULTS[:tag]} [#{DEFAULTS[:sunrise_duration]} #{DEFAULTS[:grace_period]} #{DEFAULTS[:raves]} #{DEFAULTS[:party_length]} #{DEFAULTS[:encore_delay]} #{DEFAULTS[:aftermath_brightness]}]"
  exit
end

tag                  =  ARGV[0] || 'luke'
sunrise_duration     = (ARGV[1] || DEFAULTS[:sunrise_duration]).to_f
grace_period         = (ARGV[2] || DEFAULTS[:grace_period]).to_f
raves                = (ARGV[3] || DEFAULTS[:raves]).to_i
party_length         = (ARGV[4] || DEFAULTS[:party_length]).to_f
encore_delay         = (ARGV[5] || DEFAULTS[:encore_delay]).to_f
aftermath_brightness = (ARGV[6] || DEFAULTS[:aftermath_brightness]).to_f

Routines::Wakeup.new(tag).run(
  sunrise_duration: sunrise_duration,
  grace_period: grace_period,
  raves: raves,
  party_length: party_length,
  encore_delay: encore_delay,
  aftermath_brightness: aftermath_brightness,
)
