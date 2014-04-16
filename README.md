erlbrew
=======
Erlbrew is a bash script designed to reduce the pain of installing
various versions of Erlang side-by-side.

Installation
------------
Drop `erlbrew` into $HOME/bin.  Make sure it's executable as in `chmod +x
erlbrew`. You may optionally need to throw a `hash -r` to your bash shell.

You should also edit your $PATH to include `$HOME/bin/erlbrew.d` in whatever
position you like. It probably makes the most sense to put it *first* in your
list though.

Dependencies
------------
erlbrew explicitly relies on the following tools:

* bash
* GNU tar
* curl

It also assumes that you have a working compiler environment with
GNU make, GCC (or Apple's LLVM backed GCC), and other compiler
tools like flex and as.

If you installed [Apple's "command line compiler" package](https://developer.apple.com/downloads), 
you should be good to go. If not, you can get them without having to download
*all* of Xcode from the App Store.

Usage
-----
Once erlbrew is installed and executable, it accepts five basic commands:

* `download`
* `build`
* `install`
* `use`
* `list`

These commands do what it says on the tin.  `install` implies build and
download, `build` implies download. If you wish, you can augment the
flags passed to the `configure` script by putting them in the shell 
variable `ERLBREW_CONFIGURE_OPTIONS`.

Once you have an installed Erlang environment, use the `use` command
to make erlbrew build a bunch of symbolic links in `$HOME/bin/erlbrew.d/` and 
rehash your bash command cache.

You can also use the `list` command (with no release spec) to see the
installed releases available. A `*` will be listed next to the release
currently in use.

Supported platform
------------------
At the moment only Mac OS X is supported.  It should be easy to add Linux or
other Unix support.  

Something broke
---------------
erlbrew does its work in a work directory located at `$HOME/erlbrew/.build/current`
It also writes a logfile in this directory named `erlbrew.log` which contains
all messages from STDOUT and STDERR.

Cleanup
-------
erlbrew scans its work directory for build directories that are older than 7 days
and deletes them automatically.

Examples
--------

    $ erlbrew use R14B04
    You have switched to Erlang R14B04
    $ erl

    Erlang R14B04 (erts-5.8.5) [source] [64-bit] [smp:2:2] [rq:2] [async-threads:0] [kernel-poll:false]

    Eshell V5.8.5  (abort with ^G)
    1> q().
    ok
    
    $ erlbrew use R16B
    You have switched to Erlang R16B
    $ erl

    Erlang R16B (erts-5.10.1) [source] [64-bit] [smp:2:2] [async-threads:10] [kernel-poll:false]

    Eshell V5.10.1  (abort with ^G)
    1> q().
    ok

    $ ERLBREW_CONFIGURE_OPTIONS='--with-dynamic-trace=dtrace'
    erlbrew install R15B03
    Downloading Erlang R15B03
    ######################################################################## 100.0%
    Tarball has correct MD5 checksum
    Unpacking Erlang R15B03
    Configuring Erlang R15B03 for darwin13
    Building Erlang R15B03
    Installing Erlang R15B03

    $ erlbrew list
    * R14B04
      R15B03
      R16B

See also
--------
* [kerl](https://github.com/spawngrid/kerl) - same idea, better implementation :)
* [perlbrew](https://github.com/gugod/App-perlbrew) - my inspiration

License
-------
Copyright (c) 2013 Mark Allen

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
