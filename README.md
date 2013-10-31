# lein-sync

A leiningen plugin to enable syncing an existing Clojure REPL to the current
leiningen project using pomegranate.

Sometimes, when you do not control the launch of the JVM which is running your
REPL. This might be because the JVM was launched some time ago, or for
instance, because you are running a Clojure REPL inside an application with a
complex launch procedure. One solution is to reach for
[pomegranate](https://github.com/cemerick/pomegranate) which allows you to
dynamically expand the classpath or to add Maven dependencies; you can add
pomegranate to the classpath of the JVM which launches the REPL once, then do
what ever you want later.

This is okay as a quick fix, but if you need to do this often, it's painful.
What you really want to do is create a new leiningen project, and add all of
the tools and scripts that you use regularly to this. lein-sync is for this
purpose; it generates a file `.sync.clj` which when evaled in the REPL will
make sync dependencies and classpaths to those of the current project.

## Motivation

lein-sync was originally developed for use with
[protege-nrepl](https://github.com/phillord/protege-nrepl) and
[tawny-owl](https://github.com/phillord/tawny.owl), although is independent of
either.

## Usage

To generate the appropriate `.sync.clj`

    $ lein sync

At the repl, type

    user> (load-file "~/my_project/.sync.clj")

If you are using Emacs and `nrepl.el` then `nrepl-sync.el` will start your
nrepl and sync it for you.


## Installation

Put `[lein-sync "0.1.0]` into the `:plugins` vector of your
`:user` profile.




## License

Copyright © 2013 FIXME

Distributed under the Eclipse Public License either version 1.0 or (at
your option) any later version.
