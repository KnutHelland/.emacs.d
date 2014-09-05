(setq gofmt-command "goimports")

(setq go-mode-hook nil)
(add-hook 'go-mode-hook
	  (lambda ()
	    (setq tab-width 2)
	    (local-set-key (kbd "M-.") 'godef-jump)
	    (local-set-key (kbd "C-x M-j") 'gofmt)
	    (fci-mode)))

(provide 'setup-go)
