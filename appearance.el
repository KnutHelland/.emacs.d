
;; Switch between light and dark theme:
(when (boundp 'custom-theme-load-path)
  (add-to-list 'custom-theme-load-path (concat user-emacs-directory "/emacs-color-theme-solarized"))
  (defun theme-dark ()
    "Use solarized dark theme."
    (interactive)
    (load-theme 'solarized-dark t))
  (defun theme-light ()
    "Use solarized light theme."
    (interactive)
    (load-theme 'solarized-light t))
  
  ;(theme-dark)
  (load-theme 'deeper-blue t))


(provide 'appearance)
