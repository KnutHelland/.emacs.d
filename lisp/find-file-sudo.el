

;; SUDO edit:
(defun th-find-file-sudo (file)
  "Opens FILE with root privileges."
  (interactive "F")
  (set-buffer (find-file (concat "/sudo::" file)))
  (rename-buffer (concat "sudo::" (buffer-name))))

(defun th-find-file-sudo-maybe ()
  "Re-finds the current file as root if it's read-only after
querying the user."
  (interactive)
  (let ((file (buffer-file-name)))
    (and (not (file-writable-p file))
         (y-or-n-p "File is read-only.  Open it as root? ")
         (progn
           (kill-buffer (current-buffer))
           (th-find-file-sudo file)))))

(add-hook 'find-file-hook 'th-find-file-sudo-maybe)


(provide 'find-file-sudo)
