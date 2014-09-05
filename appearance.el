
;; Switch between light and dark theme:
(when (boundp 'custom-theme-load-path)
  ;; (add-to-list 'custom-theme-load-path (concat user-emacs-directory "/emacs-color-theme-solarized"))
  ;; (defun theme-dark ()
  ;;   "Use solarized dark theme."
  ;;   (interactive)
  ;;   (load-theme 'solarized-dark t))
  ;; (defun theme-light ()
  ;;   "Use solarized light theme."
  ;;   (interactive)
  ;;   (load-theme 'solarized-light t))
  
  ;; ;(theme-dark)
  (load-theme 'deeper-blue t))

(setq-default line-spacing 4)


;;
;; Whitespace mode
;;

(setq whitespace-display-mappings
      '((space-mark 32 [183] [46])
        (tab-mark 9 [8594 9] [92 9])))

(custom-set-faces
  '(whitespace-space ((t (:foreground "#333"))))
  ; '(whitespace-empty ((t (:foreground "firebrick" :background "SlateGray1"))))
  ;;'(whitespace-hspace ((t (:foreground "lightgray" :background "LemonChiffon3"))))
  '(whitespace-hspace ((t ())))
  '(whitespace-indentation ((t (:foreground "#333"))))
  '(whitespace-line ((t (:foreground "#333"))))
  '(whitespace-newline ((t (:foreground "orange" :background "blue"))))
  '(whitespace-space-after-tab ((t (:foreground "#333" :background "green"))))
  '(whitespace-space-before-tab ((t (:foreground "black" :background "DarkOrange"))))
  '(whitespace-tab ((t (:foreground "#333"))))
  '(whitespace-trailing ((t (:foreground "red" :background "yellow")))))

(setq whitespace-style '(face tabs spaces tab-mark space-mark))

(global-whitespace-mode t)



(provide 'appearance)
