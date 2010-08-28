
;; change-major-mode-hook
;; after-change-major-mode-hook
;; (command-history)
;; (list-command-history)
;; pre-command-hook
;; post-command-hook


(setq rubykaigidribble "rubykaigidribble.txt")
(create-file-buffer rubykaigidribble)
;; for now user will have to save dribble

(defun track-command-executed ()
  "Records command executed and keys pressed"
  (with-current-buffer rubykaigidribble
    (insert (format "cmd: %s keys %s\n" this-command (this-command-keys)))))
    ;;(write-file rubykaigidribble)    ))

(defun track-mode-change ()
  "Record the major mode and all minor-modes activated"
  (with-current-buffer rubykaigidribble
    (insert (format "major-mode: %s\nminor-modes: %s\n\n" major-mode minor-mode-list))
    (write-file rubykaigidribble)    ))

;; Not sure why, but setting these as a defun only winds up executing
;; the last hook.
(progn
  (add-hook 'pre-command-hook 'track-command-executed))
;; change mode only shows fundamental mode...
  ;;(add-hook 'after-change-major-mode-hook 'track-mode-change))


(progn
  (remove-hook 'pre-command-hook 'track-command-executed)
  (remove-hook 'after-change-major-mode-hook 'track-mode-change))
