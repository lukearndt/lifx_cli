# LIFX CLI

This repository contains a few command line tools for controlling LIFX bulbs. I hacked them together at Railscamp 15 in Brisbane and wasn't focused toward making a polished product at the time, so don't expect gorgeous code. It's pretty procedural, but it seems to do the job.

## Wakeup script

Let's be honest.

Waking up to a blaring alarm isn't much fun. It's annoying. It's unpleasant. Who wants their first thought every day to be "Argh, turn off that noise!"?

Wouldn't it be better to train and use your body's in-built Circadian Rhythm?

### How it works

By replacing the bedroom light with a LIFX bulb and using this system to control it, I hope to replace my conventional alarm clock. The LIFX bulb is controlled on a schedule using a combination of crontab and ruby scripts.

### How to set it up

- Step 1: Obtain a device that you can use to host this on in your house that you don't mind leaving on all the time (eg: Rasberry Pie)
- Step 2: Clone this repo onto it
- Step 3: Use crontab to schedule wakeup alarms by calling `ruby actions/wakeup.rb` with whatever options you'd prefer in the following format:

```shell
bin/wakeup.rb tag [sunrise_duration grace_period raves party_length encore_delay aftermath_brightness]
```

#### Example crontab entry:

```bash
# To wake me up at 8:05am every day:
15 8 * * * ruby path/to/app/bin/wakeup.rb tag_of_light [other options]

# To wake me up at 7:30am Monday to Friday:
30 7 * * 1-5 ruby path/to/app/bin/wakeup.rb tag_of_light [other options]

```

#### What's crontab?

It's a task scheduling feature of linux and unix based operating systems. If you're running windows, you can probably use the Task Scheduler to similar effect.

## Rainbow clock

The rainbow clock requires 3 LIFX bulbs, so it's not the cheapest clock in the world. If you're up for that level of investment, though, it's quite pretty.

### How it works

Each of the three bulbs is used to represent a different measure of time:

- Hours
- Tens of minutes
- Minutes

Think of it like a digital clock, except that it uses colours instead of numberic digits. You can find the codefigured colour mappings at the top of this file:

https://github.com/lukearndt/lifx_cli/blob/master/routines/rainbow_clock.rb

### How to set it up

- Step 1: Obtain a device that you can use to host the repository and control the lights
- Step 2: Clone this repo onto it
- Step 3: Add different tags to the LIFX bulbs so that you can distinguish between them (default tags: 'hours', 'tens_of_minutes', 'minutes')
- Step 4: Start the clock using `ruby actions/display_clock.rb` and pass in any non-default tags (or just set different defaults if you really want)

### Anything else of note?

Yeah, the lights go dark at 4:04 for some reason. Something about a 'time not found' error. Plus, they go haywire at 5:00; some kind of 'internal time error'?

Waiting until 4:05 or 5:01 seems to resolve each respective issue.

