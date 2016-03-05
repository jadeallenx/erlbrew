erlbrew
=======
Erlbrew is a bash script designed to reduce the pain of installing
various versions of Erlang side-by-side.

Installation
------------
Drop `erlbrew` into $HOME/bin.  Make sure it's executable as in `chmod +x
erlbrew`. You may optionally need to throw a `hash -r` to your bash shell.

You should also edit your $PATH to include `$HOME/bin/.erlbrew.d` in whatever
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

You may also set `ERLBREW_MAKE_DOCS` if you want erlbrew to build the
release documentation. (The default behavior is to **not** build 
documentation.)

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

Some selected Erlang versions
-----------------------------
`erlbrew` has been tested and works on R14B04 onward.  Building Erlang before R14
may or may not work and we have little interest in making it work if its broken. (Sorry!)

For the [release of Erlang 17 and later](http://erlang.org/pipermail/erlang-questions/2014-April/078563.html), 
Ericcson decided to move to a new release naming scheme, dropping the R and the
build numbers.  So for the these releases, you would type:

    $ erlbrew install 17.5

for example.

Building Crypto on El Capitan
-----------------------------
As of El Capitan (OS X 10.11), Apple removed OpenSSL from its default compiler
tool distribution. OS X now ships with Apple's own cryptography library, but
Erlang still is bound to OpenSSL. 

A new environment variable `ERLBREW_OPENSSL_PATH` has been added. If erlbrew
detects that it's running on El Capitan, it will search `ERLBREW_OPENSSL_PATH`
first with a default location of `/usr/local/ssl`, and as a fall back, there 
appears to be an OpenSSL environment that's shipped as part of Xcode.  If 
neither location exists, then the script will error out.

If you use something like `brew install openssl`, then you should invoke an
installation like this:
 
    $ ERLBREW_OPENSSL_PATH="/usr/local/opt/openssl" erlbrew install XX.Y

Default build options
---------------------
In addition to the SSL library munging above, erlbrew also enables dirty schedulers
for Erlang 17 and 18 and DTrace support for everything. You can override that 
by specifying your own `ERLBREW_CONFIGURE_OPTIONS` if you wish.

**N.B.** If you specify your own configure options, you must also include appropriate
ssl library location(s) if needed.

Something broke
---------------
erlbrew does its work in a work directory located at `$HOME/.erlbrew/.build/current`
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
    
    $ erlbrew list
    * R14B04
      R15B03

    $ erlbrew install 18.2.1
    Downloading Erlang 18.2.1
    ######################################################################## 100.0%
    Tarball has correct MD5 checksum
    Unpacking Erlang 18.2.1
    Configuring Erlang 18.2.1 for darwin15
    Building Erlang 18.2.1
    Installing Erlang 18.2.1

See also
--------
* [kerl](https://github.com/spawngrid/kerl) - same idea, better implementation :)
* [perlbrew](https://github.com/gugod/App-perlbrew) - my inspiration

License
-------
Copyright (c) 2016 Mark Allen

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
