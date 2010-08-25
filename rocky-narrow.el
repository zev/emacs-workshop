(defun elide-greater ()
  "Set selective display hiding anything greater than the current column
that the cursor is on."
   (interactive "")
   (set-selective-display (+ (current-column) 1)))

(global-set-key "\C-c." 'elide-greater)
