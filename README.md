Starcraft II Achievements
=========================

Download all the achievements of a SC2 player.

This library downloads all the achievements from a player's public profile,
extracts the relevant data and then convert it all to an array, with the
most recent earned achievement first and then ordered by date.

I'm planning to use this as a part of a bigger system, so that's why I haven't
built-in some sort of cache.

## INSTALLATION

Everything is nicely packed as a gem, so all you have to do is:

```
$ gem install sc2_achievements
```

## USAGE

```
>> require 'sc2_achievements'
=> true
>> achievements = SC2Achievements.for('/3396700/1/Tato')
=> [{:date=>"2012-09-20", :points=>10, :title=>"That\342\200\231s Teamwork", ... }]
```

## TODO

I've opened a couple of tickets with some stuff that needs to be done, in case
anyone wanna help out.

## CONTRIBUTE

1. Fork it.
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Commit your changes (`git commit -am 'Added some feature'`).
4. Push to the branch (`git push origin my-new-feature`).
5. Create a new pull request.

## COPYRIGHT

Copyright (c) 2012 Eduardo Grajeda Blandón.
