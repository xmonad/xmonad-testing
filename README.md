# XMonad Testing Repository

This repository is useful for testing new features introduced into
[XMonad][] (and xmonad-contrib) as well as troubleshooting
new/existing configurations.  It is also an example of how to build
your own XMonad using [stack][] or [cabal][].

## Building All Dependencies with a Specific Configuration File

Using [stack][], building everything is quite easy:

    $ stack setup
    $ stack build

Using a recent enough [cabal][], building everything is even easier:

    $ cabal new-build

If you'd like to change which configuration file is being used for the
build, just replace `config.hs` with your own file.

## Testing in Isolation

Don't want to replace your current window manager just to play with
[XMonad][] or experiment with your configuration?  No problem.

Build XMonad with your configuration file of choice using the
direction above and then use the following script to run your custom
XMonad in another xorg session using [Xephyr][]:

    $ bin/run-in-xephyr.sh

## Testing Someone Else's Pull Request

  1. Clone this repository:

        $ git clone --recursive https://github.com/xmonad/xmonad-testing.git
        $ cd xmonad-testing

  2. Bring in the changes from the pull request:

     For this example we will use an example pull request for
     `xmonad-contrib`.  The steps are the same for `xmonad`.

     At the bottom of the pull request page there should be some text
     that looks like:

     > Add more commits by pushing to the BRANCH branch on REPO.

     Here I will be using *BRANCH* and *REPO* as placeholders.
     Replace them in the following commands as necessary.

     You will need the URL for *REPO*, so either click on that link
     and copy the URL or use whatever support your browser gives you
     for copying the URL of a link.  Below I will refer to the URL for
     *REPO* as *REPO_URL*.

        $ cd xmonad-contrib
        $ git checkout -b BRANCH master
        $ git pull REPO_URL BRANCH
        $ cd ..

  3. Create a configuration file that will test the changes in the
     pull request.  Ideally you will create a config file in the
     `configs` directory and symlink it to `config.hs`.  The only
     thing that actually matters though is that the configuration ends
     up in the `config.hs` file at the root of `xmonad-testing`.

  4. Build xmonad with your changes.  Use the build instructions
     above.  You can build with `stack` or `cabal`.

  5. Launch `xmonad` in a new xorg server using the *Testing in
     Isolation* instructions above.

  6. Add a comment to the pull request detailing your experience
     testing the changes.

[xmonad]: http://xmonad.org/
[stack]: https://docs.haskellstack.org/en/stable/README/
[cabal]: http://cabal.readthedocs.io/en/latest/nix-local-build-overview.html
[xephyr]: https://www.freedesktop.org/wiki/Software/Xephyr/
