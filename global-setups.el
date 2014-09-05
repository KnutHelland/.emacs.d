;; Setup fill column indicator
(setq fci-rule-column 80)

;; Correct path on mac
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(provide 'global-setups)
