(add-hook
 'markdown-mode-hook
 (lambda ()
   (define-key markdown-mode-map (kbd "M-p")  (lambda () (interactive) (previous-line 5)))
   (define-key markdown-mode-map (kbd "M-n")  (lambda () (interactive) (next-line 5)))))

(provide 'setup-markdown)
