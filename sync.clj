(require 'cemerick.pomegranate)
(cemerick.pomegranate/add-dependencies
 :coordinates
 '[[org.clojure/tools.nrepl
    "0.2.3"
    :exclusions
    ([org.clojure/clojure])]
   [clojure-complete/clojure-complete
    "0.2.3"
    :exclusions
    ([org.clojure/clojure])]
   [ritz/ritz-nrepl-middleware "0.7.0"]
   [org.clojure/tools.trace "0.7.5"]
   [compliment/compliment "0.0.1"]]
 :repositories
 '[["central"
    {:snapshots false, :url "http://repo1.maven.org/maven2/"}]
   ["clojars" {:url "https://clojars.org/repo/"}]])
(cemerick.pomegranate/add-classpath
 "/home/phillord/src/knowledge/lein-sync/src")
(cemerick.pomegranate/add-classpath
 "/home/phillord/src/knowledge/lein-sync/dev-resources")
(cemerick.pomegranate/add-classpath
 "/home/phillord/src/knowledge/lein-sync/resources")
