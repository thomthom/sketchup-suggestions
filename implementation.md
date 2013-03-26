# RBS Suggested Changes

# __FILE__ and __LINE__ values

Ensuring these values are as expected not only allows for easier debugging
(especially if the issues occur on the users machine) as well as allows for
functionalities that currently require work-arounds (such as a loader is
required if you need relatives paths and want to work outside of the `Plugins`
folder)

As far as implementing this, it just means using the long form of eval_string

    eval_string(VALUE self, VALUE src, VALUE scope, const char *file, int line)

# Extending Sketchup Classes

Currently, it is not possible to subclass Classes provided from SketchUp, such
as `Length`, `Geom::Point3d` and `Geom::Vector3d`
For example, try
    `class MyLength < Length; end; MyLength.new()`
or
    `class MyPoint3d < Geom::Point3d; end; MyPoint3d.new().class`

# Operations
    TODO: http://sketchucation.com/forums/viewtopic.php?f=180&t=46886

# Ruby Version

The ruby version used for SketchUp (1.8.*) is old. As of June 2013, it will
officially have reached the end of its lifecycle (see 
[http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/47201](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/47201) )
Using an old version means we're missing out on a lot of cool features and
content. What's more, basically everything written about ruby (that's not about
rails) at least expects you to be on the 1.9 branch.

This is really off-putting, and many times annoying - one example is the
`String#start_with?`. It's something you expect a scripting language to have -
and when you search for it you see ruby, of course, does have it - if your
using at least the 1.9 branch. This also means we miss out on a lot of gems
(more on this later) because they don't (or no longer) support 1.8.x

# Ruby Library

Please include this with SketchUp. One of the first real issues I had with
using SketchUp as a Plugin developer was trying to use `net/http`. It was a
standard part of ruby - and the documentation says that it is available for
ruby 1.8.* - but why won't it load? Only by asking some more experienced
SketchUp users was I told that I would have to load in an external Ruby
installation to be able to get access to this (and many other) libraries.

I understand the full ruby distribution is a little heavier (in terms of
filesize) but the power it gives to developers is more than worth it -
especially considering the things plugin developers are creating.

# Ruby Gems

Ruby gems are important. Making it easy for users to be able to install gems is
important. Being able to allow plugins to ask users to install gems is
important.

Gems exist to make developers life's easier, and their code better. The best
evidence of this is that rubygems is standard (and loaded by default) in ruby
1.9.x.

One obvious draw to this is external requirements and C code. We can't expect
users to be install any pre-requisites or have a (compatible) compiler
installed and configured. But these things aren't always needed. There are
plenty of pure ruby gems (or gems with pure options)
