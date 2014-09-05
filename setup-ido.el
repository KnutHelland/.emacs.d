;; enable IDO mode:
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(add-hook 'ido-setup-hook (lambda ()
			    (define-key ido-completion-map (kbd "C-w") 'backward-kill-word)))


(provide 'setup-ido)
