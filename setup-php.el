

(add-hook 'php-mode-hook 'flymake-mode)
(add-hook 'php-mode-hook 'whitespace-mode)
(define-key php-mode-map (kbd "C-.") 'yas/create-php-snippet)

(provide 'setup-php)
