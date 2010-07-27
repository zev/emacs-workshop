;; This is presentation runner copied and modified from Sacha Chua's
;; democamp presentation.
;; http://sachachua.com/blog/2009/12/behind-the-scenes-livin-la-vida-emacs/

(progn ;; Setup
  (defvar democamp/presentation-dir (concat default-directory "presentations/"))
  (defvar democamp/presentation-file (concat default-directory "rubykaigi.el"))
  (defvar democamp/image-dir (concat default-directory "images/"))
  (defvar democamp/code-dir (concat default-directory "code/"))
  (defvar democamp/cue-buffer "*RubyKaigi*")

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
      (eval (read sexp))))

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


  (global-set-key (kbd "C->") 'democamp/next)
  (global-set-key (kbd "C-<") 'democamp/previous)
  (global-set-key (kbd "C-?") 'democamp/repeat)
  (global-set-key (kbd "C-!") 'democamp/skip)
)

