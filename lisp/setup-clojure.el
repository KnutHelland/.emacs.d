;; Clojure mode

(add-hook 'clojure-mode-hook 'nrepl-interaction-mode)
(add-hook 'clojure-mode-hook 'fci-mode)
(add-hook 'clojure-mode-hook 'auto-complete-mode)
(define-key clojure-mode-map (kbd "RET") 'newline-and-indent)
(add-hook 'clojure-mode-hook (lambda () (interactive)
			       (set-fill-column 80)
			       (define-key clojure-mode-map (kbd "C-x C-r") 'nrepl-eval-buffer)))

(provide 'setup-clojure)
