erlbrew
=======
Erlbrew is a silly bash script designed to reduce the pain of installing
various versions of Erlang side-by-side.

Installation
------------
Drop `erlbrew` into $HOME/bin.  Make sure it's executable as in `chmod +x
erlbrew`. You may optionally need to throw a `hash -r` to your bash shell.

You should also edit your $PATH to include $HOME/bin/erlbrew in whatever
position you like. It probably makes the most sense to put it *first* in your
list though.

Usage
-----
Once erlbrew is installed and executable, it accepts four basic commands:

* download
* build
* install

These commands do what it says on the tin.  Also install implies build and
download, build implies download and download implies nothing.

Finally, once you have an installed Erlang environment, use the `use` command
to make erlbrew build a bunch of symbolic links to $HOME/bin/erlbrew and then
rehash your bash command cache.

Supported platform
------------------
At the moment only Mac OS X is supported.  It should be easy to add Linux or
other Unix support.  I've had some troubles building Erlang on Mac OS X 10.8
though so I might crib some solutions from the homebrew erlang recipe.

Examples
--------

    erlbrew install R14B04
    erlbrew use R14B04

    erlbrew install R16B
    erlbrew use R16B

License
-------
Copyright (c) 2013 Mark Allen

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

he above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
