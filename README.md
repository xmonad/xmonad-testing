# XMonad Testing Repository

This repository is useful for testing new features introduced into
[XMonad][] (and xmonad-contrib) as well as troubleshooting
new/existing configurations.  It is also an example of how to build
your own XMonad using [stack][].

## Building All Dependencies with a Specific Configuration File

Using [stack][], building everything is quite easy:

    $ stack setup
    $ stack build

If you'd like to change which configuration file is being used for the
build, just replace `config.hs` with your own file.

## Testing in Isolation

Don't want to replace your current window manager just to play with
[XMonad][] or experiment with your configuration?  No problem.

Build XMonad with your configuration file of choice using the
direction above and then use the following script to run your custom
XMonad in another xorg session using [Xephyr][]:

    $ bin/run-in-xephyr.sh

[xmonad]: http://xmonad.org/
[stack]: https://docs.haskellstack.org/en/stable/README/
[xephyr]: https://www.freedesktop.org/wiki/Software/Xephyr/
