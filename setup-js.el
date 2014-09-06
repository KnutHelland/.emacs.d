(require 'flymake-node-jshint)
(add-hook 'js-mode-hook (lambda () (flymake-mode 1)))
(custom-set-faces
 '(flymake-errline ((((class color)) (:foreground "#073642")))))

(setq js2-mode-hook nil)
(add-hook 'js2-mode-hook (lambda () (interactive)
			   (subword-mode 1)
			   (setq indent-tabs-mode t
				 tab-width 8)
			   (smart-tabs-mode)))



(provide 'setup-js)
