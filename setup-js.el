(require 'flymake-node-jshint)
(add-hook 'js-mode-hook (lambda () (flymake-mode 1)))
(custom-set-faces
 '(flymake-errline ((((class color)) (:foreground "#073642")))))

(setq js2-mode-hook nil)
(add-hook 'js2-mode-hook (lambda () (interactive)
			   ;; (setq-default indent-tabs-mode nil)
			   (subword-mode 1)
			   (setq indent-tabs-mode 1)
			   (setq tab-width 4)
			   (setq js2-basic-offset 4)))



(provide 'setup-js)
