# Light Sleeper

Let's be honest.

Waking up to a blaring alarm isn't much fun. It's annoying. It's unpleasant. Who wants their first thought every day to be "Argh, turn off that noise!"?

Wouldn't it be better to train and use your body's in-built Circadian Rhythm?

Light Sleeper is all about waking up to light.

## How it works

By replacing the bedroom light with a LIFX bulb and using this system to control it, I hope to replace my conventional alarm clock. The LIFX bulb is controlled on a schedule using a combination of Crontab and Ruby scripts.

## How to set it up

Step 1: Obtain a device that you can use to host this on in your house that you don't mind leaving on all the time (eg: Rasberry Pie)
Step 2: Run some form of linux or unix on the device
Step 3: Clone this repo onto it
Step 4: Use crontab to schedule wakeup alarms by calling bin/wakeup.rb with whatever options you'd prefer in the following format:

```shell
bin/wakeup.rb tag [sunrise_duration grace_period raves party_length encore_delay aftermath_brightness]
```

Example crontab entry:

```bash
# To wake me up at 8:05am every day:
15 8 * * * ruby path/to/app/bin/wakeup.rb tag_of_light [other options]

# To wake me up at 7:30am Monday to Friday:
30 7 * * 1-5 ruby path/to/app/bin/wakeup.rb tag_of_light [other options]

```

Happy napping!