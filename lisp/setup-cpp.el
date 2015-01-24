
(defun c++-customization ()
  (setq comment-use-syntax t)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 4))

(add-hook 'c++-mode-hook 'whitespace-mode)
(add-hook 'c++-mode-hook 'c++-customization)
(add-hook 'c++-mode-hook 'smart-tabs-mode)
(add-hook 'c++-mode-hook 'subword-mode)

(provide 'setup-cpp)
