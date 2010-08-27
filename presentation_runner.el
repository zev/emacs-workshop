;; This is presentation runner copied and modified from Sacha Chua's
;; democamp presentation.
;; http://sachachua.com/blog/2009/12/behind-the-scenes-livin-la-vida-emacs/

(progn ;; Setup
  (defvar democamp/presentation-dir (concat default-directory "presentations/"))
  (defvar democamp/presentation-file (concat default-directory "rubykaigi.el"))
  (defvar democamp/image-dir (concat default-directory "images/"))
  (defvar democamp/code-dir (concat default-directory "code/"))
  (defvar democamp/cue-buffer "*RubyKaigi*")
  (defvar democamp/command-buffer "*KeyCommand*")

  (defun democamp/load-code (codefile)
    "Load the code file and make sure the point is at the top"
    (find-file (concat democamp/code-dir codefile))
    (goto-char (point-min)))

  (defun democamp/load-presentation (presfile)
    "Load and start an epresent presentation file"
    (find-file (concat democamp/presentation-dir presfile))
    (outline-mode)
    (epresent-run-frame))

  (defun democamp/next ()
    (interactive)
    (let (start sexp)
      (with-current-buffer (find-file-noselect democamp/presentation-file)
        (setq start (point))
        (forward-sexp)
      (setq sexp (buffer-substring-no-properties start (point))))
      ;;(eval (read sexp))))
      (let ((esexp (read sexp)))
        (case (completing-read (format "%s %s: " (cadr esexp) "N/S/P :") '("N" "S" "P"))
          ("S" (democamp/skip))
          ("P" (democamp/previous))
          (t (eval esexp))))))

  (defun democamp/previous ()
    (interactive)
    (let (start sexp)
      (with-current-buffer (find-file-noselect democamp/presentation-file)
        (setq start (point))
        (backward-sexp)
        (setq sexp (buffer-substring-no-properties (point) start)))
      (eval (read sexp))))

  (defun democamp/repeat ()
    (interactive)
    (let (start sexp)
      (with-current-buffer (find-file-noselect democamp/presentation-file)
        (setq start (point))
        (backward-sexp)
        (setq sexp (buffer-substring (point) start))
        (forward-sexp))
      (eval (read sexp))))

  (defun democamp/skip ()
    (interactive)
    (let (start sexp)
      (with-current-buffer (find-file-noselect democamp/presentation-file)
        (setq start (point))
        (forward-sexp)
        (setq sexp (buffer-substring-no-properties start (point))))
      ))


  (defun democamp/say (text)
    (with-current-buffer (get-buffer-create democamp/cue-buffer)
      (erase-buffer)
      (insert text)
      (goto-char (point-min))
      (cond ((featurep 'emacspeak)
             (call-interactively 'emacspeak-speak-buffer))

            ((or (featurep 'aquamacs) (featurep 'mac-carbon) (featurep 'ns) )
             (shell-command-on-region (point-min) (point-max) "say")))))


  ;; look at tail.el for inspiration
  (defun democamp/show-and-execute-command (command &optional delay &rest args)
    (democamp/disp-command-window command)
    ;; will need to make sure that apply is on the code buffer
    (apply command args)
    (if (numberp delay)
        (sit-for delay)))

  (defalias 'dcse 'democamp/show-and-execute-command)

  (defun democamp/disp-command-window (command)
    (if (equal (selected-window) (minibuffer-window))
        (if (other-window 1)
            (select-window (other-window 1))
          (if window-system
              (select-frame (other-frame 1)))))

    (let* ((this-buffer (current-buffer))
           (this-window (selected-window))
           (command-disp-buf (set-buffer (get-buffer-create democamp/command-buffer)))
           (command-max-size 45)
           (command-raise t)
           (command-hide-delay 5))

      (if (cdr (assq 'unsplittable (frame-parameters)))
          ;; In an unsplittable frame, use something somewhere else.
          (display-buffer command-disp-buf)
        ;; (unless (or (and (fboundp 'special-display-p)
        ;;                  (special-display-p (buffer-name command-disp-buf)))
        ;;             (and (fboundp 'same-window-p)
        ;;                  (same-window-p (buffer-name command-disp-buf)))
        ;;             (get-buffer-window democamp/command-buffer)
        ;;             ;; By default, split the bottom window and use the lower part.
        ;;             (democamp/select-lowest-window)
        ;;             (split-window))
        ;;   (pop-to-buffer command-disp-buf))

        (pop-to-buffer command-disp-buf)
        (toggle-read-only 0)
        (erase-buffer)

        (democamp/insert-command-and-key command)

        (toggle-read-only 1)
        (shrink-window-if-larger-than-buffer (get-buffer-window command-disp-buf t))

        (if (> (window-height (get-buffer-window command-disp-buf t)) command-max-size)
            (shrink-window (- (window-height (get-buffer-window command-disp-buf t)) command-max-size)))
        (set-buffer-modified-p nil)

        (if command-raise
            (raise-frame (selected-frame)))

        (select-window this-window)

        (if command-hide-delay
            (run-with-timer command-hide-delay nil 'democamp/hide-command-buffer)))))

  (defun democamp/select-lowest-window ()
    "Select the lowest window on the frame."
    (if (fboundp 'frame-lowest-window)
        (select-window (frame-lowest-window))
      (let* ((lowest-window (selected-window))
             (bottom-edge (car (cdr (cdr (cdr (window-edges))))))
             (last-window (previous-window))
             (window-search t))
        (while window-search
          (let* ((this-window (next-window))
                 (next-bottom-edge (cadr (cddr (window-edges this-window)))))
            (when (< bottom-edge next-bottom-edge)
              (setq bottom-edge next-bottom-edge)
              (setq lowest-window this-window))
            (select-window this-window)
            (when (eq last-window this-window)
              (select-window lowest-window)
              (setq window-search nil)))))))

  (defun democamp/insert-command-and-key (command)
    (insert-string (concat "\n\nCommand: (" (symbol-name command) ") \n\n\n"))
    (insert-string (concat "Bound Keys: \n\n"))
    (where-is command t)
    (backward-sexp)
    (kill-line))

  ;; take from tail.el
  (defun democamp/hide-command-buffer ()
    (let ((window (get-buffer-window democamp/command-buffer t)))
      (and window
           (or (eq window (frame-root-window (window-frame window)))
               (delete-window window)))))

  (global-set-key (kbd "C->") 'democamp/next)
  (global-set-key (kbd "C-<") 'democamp/previous)
  (global-set-key (kbd "C-?") 'democamp/repeat)
  (global-set-key (kbd "C-!") 'democamp/skip)

  ;;make sure the runner starts at the beginning
  (progn
    (with-current-buffer (find-file-noselect democamp/presentation-file)
      (goto-char (point-min))))
)

