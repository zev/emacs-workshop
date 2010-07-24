;; These are the slides that will be run during the RubyKaigi

(democamp/say "Placeholder")

;; Window register a
(progn
  (menu-bar-mode 1)
  (tool-bar-mode 1)
  (set-face-attribute 'default nil :height 200)
  (find-file (concat democamp/presentation-dir "presentation-1.txt"))
  (democamp/say "RubyKaigi M-x emacs-and-ruby")
  (frame-configuration-to-register ?a))

;; (progn
;;   (democamp/say "Spell-check, too.")
;;   (load-library "flyspell")
;;   (load-library "emacspeak-flyspell")
;;   (setq emacspeak-flyspell-highlight-personality nil)
;;  (flyspell-mode 1))


;; Emacs learning curve
;; Frame configuration b
(progn
  (find-file (concat democamp/image-dir "intro.jpg"))
  (democamp/say "intro image"))

(progn
  (set-face-attribute 'default nil :height 200)
  (delete-other-windows)
  (sit-for 1)
  (animate-sequence (list "M-x emacs-and-ruby" "RubyKaigi 2010" "Zev Blut" "+ You" "2010-08-28") 1))

;; Using ri
(progn
  (set-face-attribute 'default nil :height 200)
  (find-file (concat democamp/code-dir "sample.rb"))
  (search-forward "inject")
  (ri))

;; epresent file 1
(progn
  (find-file (concat democamp/presentation-dir "presentation-1.txt"))
  (outline-mode)
;;  (epresent-display-mode)
  (epresent-run-frame))

;; after an epresent-mode the screen is wonky revert to frame config
(progn
  ;; jumping back does not seem to work (super slow genie effect)
  ;;(jump-to-register ?a)
  (set-face-attribute 'default nil :height 200)
  (democamp/say "Emacs comes with a psychotherapist.")
  (doctor))

(progn
  (democamp/say "even Snake")
  (delete-other-windows)
  (snake))


;; Planner
(democamp/say "Now the wild stuff starts.")
(democamp/say "This should prove skip works.")

(democamp/say "Show and Tell time!")
