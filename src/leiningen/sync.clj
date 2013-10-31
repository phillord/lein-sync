(ns leiningen.sync
  (:require [clojure.pprint])
  (:refer-clojure :exclude [sync]))
(defn deps [project]
  (get project :dependencies))

(defn repo [project]
  (get project :repositories))

(defn sync
  "Generate a .sync.clj file for this project"
  [project & args]
  (with-open [r (java.io.FileWriter. ".sync.clj")]
    (.write r ";; This file is auto-generated by lein sync\n")
    (clojure.pprint/pprint
     '(require 'cemerick.pomegranate) r)
    (clojure.pprint/pprint
     `(cemerick.pomegranate/add-dependencies
       :coordinates '[~@(deps project)]
       :repositories '~(repo project))
     r)
    (doseq [p
            (concat
             (get project :source-paths)
             (get project :resource-paths)
             )]
      (clojure.pprint/pprint
       `(cemerick.pomegranate/add-classpath ~p)
       r))
    ;; provide a non nil return value when loading
    (.write r "\".sync.clj has loaded correctly\"")))