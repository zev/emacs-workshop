;; These are the slides that will be run during the RubyKaigi

;; This is how I will record what I am doing to create a proper script.
(open-dribble-file "/tmp/rubykaigi-dribble.el")

;; Window register a
(progn
  "Initial setup"
  (menu-bar-mode 1)
  (tool-bar-mode -1)
  (frame-configuration-to-register ?b) ;; Store original config


  (message "face height is %s" (face-attribute 'default :height))
  (set-face-attribute 'default nil :height 200)
  (message "Mac set to full screen frame config \n %s" (current-frame-configuration))

  ;; does not work on carbon emacs
     (set-frame-configuration '('frame-configuration
                                ((fullscreen . fullboth))
                                ) 'nodelete)


;;   (set-frame-configuration '( 'frame-configuration
;;                               (width . 177)
;;                               (height . 47)
;;                               ) 'nodelete)

    (frame-configuration-to-register ?a))

;; Frame configuration b

(progn
  "animate"
  (set-face-attribute 'default nil :height 200)
  (delete-other-windows)
  (sit-for 1)
  (animate-sequence (list "M-x ruby-and-emacs-workshop" "RubyKaigi 2010" "Zev Blut" "& You" "2010-08-28") 1))

(democamp/load-presentation "intro.txt")

(progn
  "curves"
  ;; http://blogs.msdn.com/b/steverowe/archive/2004/11/17/code-editor-learning-curves.aspx
  (find-file (concat democamp/image-dir "curves.jpg")))

;; ruby-mode in action
;; epresent file 1
(democamp/load-presentation "presentation-1.txt")

;; kind of want a macro to show the key combination and the defun it
;; is mapped to then run the combo and delay for a second
(progn
  "Moving around ruby"
  (delete-other-windows)
  (jump-to-register ?b)
;;  (set-face-attribute 'default nil :height 200)
  (democamp/load-code "cgi.rb")

  ;; simple paragraph movement
  (dcse 'forward-paragraph 5)
  (dcse 'backward-paragraph 5)

  ;; defun movement
  (dcse 'ruby-end-of-defun 5)
  (dcse 'ruby-beginning-of-defun 5)

  ;; sexp movement
  ;; may want to search to a def of inside an if
  (dcse 'forward-paragraph 2)
  (dcse 'forward-paragraph 2)
  (dcse 'ruby-forward-sexp 4)
  (dcse 'ruby-forward-sexp 2)
  (dcse 'ruby-forward-sexp 2)

  ;; block movement
  (search-forward "initialize")
  (dcse 'ruby-end-of-block 5)
  (dcse 'ruby-end-of-block 2)
  (dcse 'ruby-beginning-of-block 5)
  )


;; Using ri
(progn
  "using ri"
  (delete-other-windows)
  (jump-to-register ?b)
  (set-face-attribute 'default nil :height 200)
  (democamp/load-code "sample.rb")
  (search-forward "inject")
  (yari))


(progn
  "inf ruby mode"
  (delete-other-windows)
  (dcse 'inf-ruby 5)
  (democamp/load-code "sample.rb")
  (delete-other-windows)
  (beginning-of-buffer)
  (sit-for 1)
  (search-forward "sum")
  (sit-for 1)
  (ruby-send-definition)
  (split-window-vertically)
  (switch-to-buffer "*ruby*")


  (switch-to-buffer "sample.rb")
  (end-of-buffer)
  (insert "\n\nHoge.new.sum([5])")
  ;; (move-beginning-of-line)
  ;; (set-mark-command)
  ;; (move-end-of-line)
  (ruby-send-region-and-go)
  )

;; from http://github.com/rust/dotemacs/blob/master/.emacs
(progn
  "Testing out align"
  (delete-other-windows)
  (progn
    (require 'align)
    (add-to-list 'align-rules-list
                 '(ruby-comma-delimiter
                   (regexp . ",\\(\\s-*\\)[^# \t\n]")
                   (repeat . t)
                   (modes . '(ruby-mode))))
    (add-to-list 'align-rules-list
                 '(ruby-hash-literal
                   (regexp . "\\(\\s-*\\)=>\\s-*[^# \t\n]")
                   (repeat . t)
                   (modes . '(ruby-mode))))
    (add-to-list 'align-rules-list
                 '(ruby-assignment-literal
                   (regexp . "\\(\\s-*\\)=\\s-*[^# \t\n]")
                   (repeat . t)
                   (modes . '(ruby-mode))))
    (add-to-list 'align-rules-list ;TODO add to rcodetools.el
                 '(ruby-xmpfilter-mark
                   (regexp . "\\(\\s-*\\)# => [^#\t\n]")
                   (repeat . nil)
                   (modes . '(ruby-mode))))
    )

  (democamp/load-code "align.rb")
  (beginning-of-buffer)
  (set-mark-command)
  (end-of-buffer)
  (dcse 'align 5)
  )

;; after an epresent-mode the screen is wonky revert to frame config
;; (progn
;;   ;; jumping back does not seem to work (super slow genie effect)
;;   ;;(jump-to-register ?a)
;;   (set-face-attribute 'default nil :height 200))

;; Rinari emacs-rails

;; Shell mode
(progn
  "Shell mode features"
  (delete-other-windows)
  ;;(jump-to-register ?a)
  (ansi-term "/bin/zsh")
  (insert "echo 'this is an example of scripting input inside an Emacs term'")
  (term-send-input)
  (insert (concat "cd " democamp/presentation-dir))
  (completing-read "enter for next command." '())
  (term-send-input)
  (insert "cat basics.txt")
  (term-send-input)

  (insert "echo back to term-line-mode C-c j to work with shell like a standard buffer")
  (term-send-input)
  (dcse 'term-line-mode 5)
  (dcse 'isearch-backward nil '("@Basics"))
  (dcse 'backward-sentence 3)
  (dcse 'term-char-mode 5)
  (insert "echo back to term-char-mode C-c k to show how it works like standard shell")
  (term-send-input)

  (insert "echo This is all very useful for things like passwords and what not")
  (term-send-input)
  )


;; SQL mode ?
(progn
  "Using SQL inside of emacs"
  (delete-other-windows)
  (setq sql-sqlite-program "sqlite3")
  (setq sql-database (concat democamp/code-dir "sample.db"))
  (sql-sqlite)
  (delete-other-windows)
  ;;create db
  (insert "create table memos(text, priority INTEGER);")
  (comint-send-input)
  (insert "insert into  memos  values('deliver   project description', 10);")
  (comint-send-input)
  (insert "insert into  memos  values('lunch with  Christine', 100);")
  (comint-send-input)

  (completing-read "enter for next command." '())
  (insert "select * from memos;")
  (comint-send-input)

  (completing-read "enter for next command." '())
  (insert "insert into memos values('show standard history with M-p', 20);")
  (comint-send-input)

  ;; Show sql-send-region from other buffer
  )


;; VCS
(progn
  "Show off magit and git.el in vc-status"
  (delete-other-windows)
  ;; more consisten with the cvs/svn/etc commands
  (completing-read "enter for next command." '())
  (dcse 'magit-status nil "")

  (completing-read "enter for next command." '())
  (dcse 'git-status nil "")
  ;; log and blame are strong here also integrats with vc tools so
  )

;; Showing grep
(progn
  "Show off occur"
  (delete-other-windows)
  (democamp/load-code "cgi.rb")
  (completing-read "enter to run occur." '())
  (dcse 'occur 5 "post")
  )

(progn
  "grep"
  (delete-other-windows)
  (rgrep "ruby")
  )

(progn
  "Tags"
  ;; Need to update etags for ruby and recursive directory search
  )


;; More advanced features

;; (progn
;;   (democamp/say "Spell-check, too.")
;;   (load-library "flyspell")
;;   (load-library "emacspeak-flyspell")
;;   (setq emacspeak-flyspell-highlight-personality nil)
;;  (flyspell-mode 1))

(progn
  "xkcd"
  (delete-other-windows)
  ;; http://xkcd.com/378/
  (find-file (concat democamp/image-dir "real_programmers.png")))

(democamp/load-presentation "learn_more.txt")

(progn
  "show and tell"
  (set-face-attribute 'default nil :height 200)
  (delete-other-windows)
  (sit-for 1)
  (animate-sequence (list "Show" "and" "Tell") 1))



;; change-major-mode-hook
;; after-change-major-mode-hook
;; (command-history)
;; (list-command-history)
;; pre-command-hook
;; post-command-hook



(defun track-command-executed ()
  "Records command executed and keys pressed"
    (message "cmd: %s keys %s\n" this-command (this-command-keys)))

(defun track-mode-change ()
  "Record the major mode and all minor-modes activated"
  (message "major-mode: %s\nminor-modes: %s\n\n" major-mode minor-mode-list))

(progn
  (add-hook 'pre-command-hook 'track-command-executed)
  (add-hook 'after-change-major-mode-hook 'track-mode-change))


(progn
  (remove-hook 'pre-command-hook 'track-command-executed)
  (remove-hook 'after-change-major-mode-hook 'track-mode-change))
