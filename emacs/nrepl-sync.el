;; The contents of this file are subject to the GPL License, Version 3.0.
;;
;; Copyright (C) 2013, Phillip Lord, Newcastle University
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(require 'nrepl)

(defun nrepl-sync-in (host port &optional project)
  "Connect nrepl to HOST and PORT, associate it with the current
project, and then load .sync.clj in the project root, to set that
remote REPL up appropriately, for the current project. With a
prefix arg, this prompts for a project.

See the lein-sync plugin for a way to generate .sync.clj."
  (setq nrepl-current-clojure-buffer (current-buffer))
  (interactive (list (read-string "Host: " nrepl-host nil nrepl-host)
                     (string-to-number
                      (let ((port (nrepl-default-port)))
                        (read-string "Port: " port nil port)))
                     (when current-prefix-arg
                       (ido-read-directory-name "Project: "))))
  (let ((project-dir
         (nrepl-project-directory-for
          (or project (nrepl-current-dir)))))
    (when (nrepl-check-for-repl-buffer `(,host ,port) project-dir)
      (let ((process (nrepl-connect host port)))
        (setq nrepl-sync-last process)
        (with-current-buffer (process-buffer process)
          (setq nrepl-project-dir project-dir)
          (message
           "Eval .sync.clj: %s"
           (nrepl-send-string-sync
            (format "(load-file \"%s/.sync.clj\")"
                    (expand-file-name project-dir)))))
        (message "Connecting to nREPL on %s:%s..." host port)))))


(eval-after-load 'clojure-mode
  '(define-key clojure-mode-map (kbd "C-c M-s") 'nrepl-sync-in))

(provide 'nrepl-sync)