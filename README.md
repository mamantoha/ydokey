# ydokey

A simple command-line utility for Linux to convent key commands to raw keycodes which used in [ydotool](https://github.com/ReimuNotMoe/ydotool)

## The Why & The How

From `ydotool key`:

> Since there's no way to know how many keyboard layouts are there in the world,
> we're using raw keycodes now.
>
> Syntax: `<keycode>:<pressed>`
>
> See `/usr/include/linux/input-event-codes.h` for available key codes (`KEY_*`).


For example `Ctrl+F8`.

What you want is:

```
ydotool key 29:1 66:1 29:0 66:0
```

With `ydokey` you can do the same with:

```
ydotool key $(ydokey -k Ctrl+F8)
```

See `ydokey -h` for more info.

## Installation

TODO: Write installation instructions here

## Contributing

1. Fork it (<https://github.com/mamantoha/ydokey/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Anton Maminov](https://github.com/mamantoha) - creator and maintainer
