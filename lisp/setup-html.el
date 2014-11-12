(defun custom-html ()
  (setq sgml-basic-offset 4))

(add-hook 'html-mode-hook 'custom-html)

(provide 'setup-html)
