Starcraft II Achievements parser
================================

Download all the achievements of a SC2 player as JSON.

This library downloads all the achievements from a player's public profile,
extracts the relevant data and then convert it all to a JSON array, with the
most recent earned achievement first.

I'm planning to use this as a part of a bigger system, so that's why I haven't
built-in some sort of cache.

## INSTALLATION

Everything is nicely packed as a gem, so all you have to do is:

```
$ gem install sc2_achievements_parser
```

## USAGE

```
>> SC2AchievementsParser.get('/2693272/1/NakedSnake')
=> 
```

## CONTRIBUTE

1. Fork it.
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Commit your changes (`git commit -am 'Added some feature'`).
4. Push to the branch (`git push origin my-new-feature`).
5. Create a new pull request.

## COPYRIGHT

Copyright (c) 2012 Eduardo Grajeda Blandón.
