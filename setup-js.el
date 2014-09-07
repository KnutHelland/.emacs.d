(require 'flymake-node-jshint)
(require 'js2-refactor)

(add-hook 'js-mode-hook (lambda () (flymake-mode 1)))
(custom-set-faces
 '(flymake-errline ((((class color)) (:foreground "#073642")))))

(define-key js2-mode-map (kbd "C-k") 'js2r-kill)

(add-hook 'js2-mode-hook 'whitespace-mode)
(add-hook 'js2-mode-hook (lambda () (interactive)
			   (subword-mode 1)
			   (setq indent-tabs-mode t
				 tab-width 8)
			   (smart-tabs-mode)))



(provide 'setup-js)
