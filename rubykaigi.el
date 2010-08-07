;; These are the slides that will be run during the RubyKaigi

(progn
  "This is a simple explanation for this slide"
  )

;; Window register a
(progn
  (menu-bar-mode 1)
  (tool-bar-mode -1)
  (set-face-attribute 'default nil :height 200)
;;   (set-frame-configuration '( 'frame-configuration
;;                              (fullscreen . fullboth)
;;                             ) 'nodelete)
;;  (find-file (concat democamp/presentation-dir "presentation-1.txt"))
;;  (democamp/say "RubyKaigi M-x ruby-and-emacs-workshop")
  (frame-configuration-to-register ?a))

;; Frame configuration b

(progn
  (set-face-attribute 'default nil :height 200)
  (delete-other-windows)
  (sit-for 1)
  (animate-sequence (list "M-x ruby-and-emacs-workshop" "RubyKaigi 2010" "Zev Blut" "& You" "2010-08-28") 1))

(democamp/load-presentation "intro.txt")

(progn
  (find-file (concat democamp/image-dir "intro.jpg")))

;; emacs basics (skippable based on attendees)
(democamp/load-presentation "basics.txt")

;; ruby-mode in action
;; epresent file 1
(democamp/load-presentation "presentation-1.txt")

;; kind of want a macro to show the key combination and the defun it
;; is mapped to then run the combo and delay for a second
(progn
  (set-face-attribute 'default nil :height 200)
  (democamp/load-code "cgi.rb")

  ;; simple paragraph movement
  (dcse 'forward-paragraph)
  (sit-for 1)
  (dcse 'backward-paragraph)
  (sit-for 1)
  ;; defun movement
  (dcse 'ruby-end-of-defun)
  (sit-for 1)
  (dcse 'ruby-beginning-of-defun)

  ;; sexp movement
  ;; may want to search to a def of inside an if
  (dcse 'forward-paragraph)
  (sit-for 1)
  (dcse 'forward-paragraph)
  (dcse 'ruby-forward-sexp)
  (dcse 'ruby-forward-sexp)
  (dcse 'ruby-forward-sexp)

  ;; block movement
  (search-forward "initialize")
  (dcse 'ruby-end-of-block)
  (dcse 'ruby-end-of-block)
  (dcse 'ruby-beginning-of-block)
  )


;; Using ri
(progn
  (set-face-attribute 'default nil :height 200)
  (democamp/load-code "sample.rb")
  (search-forward "inject")
  (yari))


;; after an epresent-mode the screen is wonky revert to frame config
(progn
  ;; jumping back does not seem to work (super slow genie effect)
  ;;(jump-to-register ?a)
  (set-face-attribute 'default nil :height 200))

;; Rinari emacs-rails

;; Shell mode

;; SQL mode ?

;; More advanced features

;; (progn
;;   (democamp/say "Spell-check, too.")
;;   (load-library "flyspell")
;;   (load-library "emacspeak-flyspell")
;;   (setq emacspeak-flyspell-highlight-personality nil)
;;  (flyspell-mode 1))

;; (progn
;;   (democamp/say "even Snake")
;;   (delete-other-windows)
;;   (snake))


(democamp/say "Now the wild stuff starts.")
(democamp/say "This should prove skip works.")

(democamp/say "Show and Tell time!")
