;; typed from http://www.vimeo.com/1013263
(defun ido-find-file-in-tag-files ()
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t))
      (visit-tags-table-buffer))
    (find-file
     (ido-completing-read "Project file: "
                          (tags-table-files)
                          nil t))))

(global-set-key (kbd "M-p") 'ido-find-file-in-tag-files)
