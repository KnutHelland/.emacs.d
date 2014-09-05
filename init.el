;;----------------------------------------------------------------------
;; .emacs for Knut Helland
;;----------------------------------------------------------------------

(defun settings ()
  "Open .emacs file"
  (interactive)
  (find-file (concat user-emacs-directory "/init.el")))

(setq user-mail-address "knutoh@gmail.com")
(setq user-full-name "Knut Helland")

(add-to-list 'load-path user-emacs-directory)
(require 'setup-package)
(require 'initial-config)

;; Install our packages
(load-file (concat user-emacs-directory "/ensure-package-installed.el"))
(ensure-package-installed
 'magit
 'guide-key
 'exec-path-from-shell
 'rainbow-delimiters
 'fill-column-indicator
 'nrepl
 'ac-nrepl
 'smart-tabs-mode
 'go-mode
 'coffee-mode
 'markdown-mode
 'less-css-mode
 'protobuf-mode
 'clojure-mode)
(package-initialize)

(require 'setup-guide-key)

;(eval-after-load 'guide-key '(require 'setup-guide-key))










(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)


; (load-file (concat user-emacs-directory "/knut-fn.el"))
; (load-file (concat user-emacs-directory "/2048.el"))
(add-to-list 'load-path (concat user-emacs-directory "/auto-complete"))


;; Load packages:

(add-to-list 'load-path (concat user-emacs-directory "/jade-mode"))
;; (add-to-list 'load-path (concat user-emacs-directory "/emacs-eclim"))
(require 'knut-fn)
(require 'auto-complete)
(require 'clojure-mode)
(require 'markdown-mode)
(require 'php-mode)
(require 'nrepl)
(require 'ac-nrepl)
(require 'rainbow-delimiters)
(require 'coffee-mode)
(require 'exec-path-from-shell)
(require 'fill-column-indicator)
(require 'sws-mode)
(require 'jade-mode)
(require 'less-css-mode)
(require 'protobuf-mode)

;;(require 'go-mode)
;; (setq gofmt-command "goimports")
;; (add-to-list 'load-path "/usr/local/Cellar/go/1.2/libexec/misc/emacs")
;; (require 'go-mode-load)
;; (setq go-mode-hook nil)
;; (add-hook 'go-mode-hook (lambda ()
;;                           (setq tab-width 2)
;;                           (local-set-key (kbd "M-.") 'godef-jump)
;;                           (local-set-key (kbd "C-x M-j") 'gofmt)
;; 			  (fci-mode)))


;; (require 'eclim)
;; (global-eclim-mode)
;; (require 'eclimd)
;; (require 'auto-complete-config)
;; (ac-config-default)
;; (require 'ac-emacs-eclim-source)
;; (ac-emacs-eclim-config)
(require 'frame-cmds)

;; (require 'flymake-node-jshint)
;; (require 'flymake-cursor)
; (add-hook 'js-mode-hook (lambda () (flymake-mode 1)))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(flymake-errline ((((class color)) (:foreground "#073642")))))

(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Setup rainbow delimiters
(global-rainbow-delimiters-mode)

;; Setup fill column indicator
(setq fci-rule-column 80)

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
  (load-theme 'deeper-blue t)
  )



;; Expand-region.el
(add-to-list 'load-path (concat user-emacs-directory "/expand-region"))
(require 'expand-region)
(global-set-key (kbd "C-@") 'er/expand-region)

;; 
(add-to-list 'load-path (concat user-emacs-directory "/magit-1.2.0"))
(require 'magit)


;; Setup nrepl auto complete:
;; (add-hook 'nrepl-mode-hook 'auto-complete-mode)
;; (add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
;; (add-hook 'nrepl-mode-hook 'paredit-mode)
;; (add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
;; (eval-after-load "auto-complete"
;; 		 '(add-to-list 'ac-modes 'nrepl-mode))

;; enable IDO mode:
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(add-hook 'ido-setup-hook (lambda ()
			    (define-key ido-completion-map (kbd "C-w") 'backward-kill-word)))
		;(define-key ido-completion-map (kbd "C-M-n") 'ido-next-work-directory)
	        ;(define-key ido-completion-map (kbd "C-M-p") 'ido-prev-work-directory)))

;; File associations:
(add-to-list 'auto-mode-alist '("\\.cljs\\'" . clojure-mode))

;; Smooth scrolling:
(setq scroll-margin 5 scroll-conservatively 10000)

(setq-default line-spacing 3)

;; Clojure mode
(add-hook 'clojure-mode-hook 'nrepl-interaction-mode)
(add-hook 'clojure-mode-hook 'fci-mode)
(add-hook 'clojure-mode-hook 'auto-complete-mode)
(define-key clojure-mode-map (kbd "RET") 'newline-and-indent)
(add-hook 'clojure-mode-hook (lambda () (interactive)
			       (set-fill-column 80)
			       (define-key clojure-mode-map (kbd "C-x C-r") 'nrepl-eval-buffer)))

;; Tab mode:
(add-hook 'coffee-mode-hook (lambda () (interactive)
                              (setq-default indent-tabs-mode nil)
                              (setq tab-width 4)))

;; (add-hook 'php-mode-hook (lambda () (interactive)
;;                            (setq-default indent-tabs-mode nil)
;;                            (setq tab-width 2)))

;CamelCaseWord

(setq js2-mode-hook nil)
(add-hook 'js2-mode-hook (lambda () (interactive)
                                  ;(setq-default indent-tabs-mode nil)
			   (subword-mode 1)
                                  (setq indent-tabs-mode 1)
				  (setq tab-width 4)
                                  (setq js2-basic-offset 4)))


;; SUDO edit:
(defun th-find-file-sudo (file)
  "Opens FILE with root privileges."
  (interactive "F")
  (set-buffer (find-file (concat "/sudo::" file)))
  (rename-buffer (concat "sudo::" (buffer-name))))

(defun th-find-file-sudo-maybe ()
  "Re-finds the current file as root if it's read-only after
querying the user."
  (interactive)
  (let ((file (buffer-file-name)))
    (and (not (file-writable-p file))
         (y-or-n-p "File is read-only.  Open it as root? ")
         (progn
           (kill-buffer (current-buffer))
           (th-find-file-sudo file)))))

(add-hook 'find-file-hook 'th-find-file-sudo-maybe)


;; Paredit
(autoload 'enable-paredit-mode "paredit" "" t)
(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)

;; Custom key bindings
;(global-set-key (kbd "C-c C-d") 'duplicate-line)duplicate-line
(global-set-key (kbd "M-p") (lambda () (interactive) (previous-line 1)(previous-line 1)(previous-line 1)(previous-line 1)(previous-line 1)))
(global-set-key (kbd "M-n") (lambda () (interactive) (next-line 1)(next-line 1)(next-line 1)(next-line 1)(next-line 1)))
(global-set-key (kbd "C-M-7") 'undo)
(global-set-key (kbd "<C-268632080>") (lambda () (interactive) (scroll-screen-and-cursor -5)))
(global-set-key (kbd "<C-268632078>") (lambda () (interactive) (scroll-screen-and-cursor +5)))

(global-set-key (kbd "C-x g") 'goto-line)
(global-set-key (kbd "C-x C-g") 'goto-line)

;; Scrolling with arrows:
(global-set-key (kbd "<up>") 'scroll-screen-and-cursor-up)
; (global-set-key (kbd "C-M-p") 'scroll-screen-and-cursor-up)
(global-set-key (kbd "<C-M-268632080>") (lambda () (interactive) (other-window 1)))
(global-set-key (kbd "<down>") 'scroll-screen-and-cursor-down)
; (global-set-key (kbd "C-M-n") 'scroll-screen-and-cursor-down)
(global-set-key (kbd "<C-M-268632078>") (lambda () (interactive) (other-window -1)))

;(global-set-key (kbd "H-p") (lambda () (interactive) (scroll-down-line 3)))
;(global-set-key (kbd "H-n") (lambda () (interactive) (scroll-up-line 3)))
;; (global-set-key (kbd "H-f") 'next-buffer)
;; (global-set-key (kbd "H-b") 'previous-buffer)
;; (global-set-key (kbd "H-p") (lambda () (interactive) (other-window 1)))
;; (global-set-key (kbd "H-n") (lambda () (interactive) (other-window -1)))

(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-ø") 'kill-region)

(global-set-key (kbd "C-x M-7") 'comment-region)
(global-set-key (kbd "C-x M-/") 'uncomment-region)

;; Go to other window backward:
(global-set-key (kbd "C-x i") (lambda () (interactive) (other-window -1)))

(global-unset-key (kbd "M-l"))
(global-unset-key (kbd "M-u"))



;; (global-set-key (kbd "M-O") 'eclim-java-import-organize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#e9e2cb" "#c60007" "#728a05" "#a57705" "#2075c7" "#c61b6e" "#259185" "#708183"])
 '(background-color "#fcf4dc")
 '(background-mode light)
 '(cursor-color "#52676f")
 '(custom-safe-themes (quote ("3b2a73c9999eff3a91d105c65ab464b02841ad28dfa487253a228cfd91bf5f3e" default)))
 ;; '(eclim-executable "/Applications/eclipse/eclim")
 '(foreground-color "#52676f"))

;; (add-hook 'eclim-mode-hook
;; 	  (lambda ()
;; 	    (fci-mode)
;; 	    (setq c-basic-offset 4
;; 		  tab-width 4
;; 		  indent-tabs-mode t)))

(add-hook
 'markdown-mode-hook
 (lambda ()
   (define-key markdown-mode-map (kbd "M-p")  (lambda () (interactive) (previous-line 5)))
   (define-key markdown-mode-map (kbd "M-n")  (lambda () (interactive) (next-line 5)))))
;; (global-set-key (
;;                  [?\M-f ?\M-b ?\C-  ?\C-  ?\M-b ?\M-c nil]))


;; Emacs jabber
;(add-to-list 'load-path (concat user-emacs-directory "/emacs-jabber"))
;(require 'jabber)
;(require 'jabber-autoloads)



(defun clj-doc (query)
  "Show nrepl-doc and go back to current window."
  (interactive "P")
  (nrepl-doc query)
  (other-window 1))

(add-hook 'clojure-mode-hook (lambda () 
			     (define-key clojure-mode-map (kbd "C-c C-d") 'clj-doc)))

(defun toggle-fullscreen-mac ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

;(toggle-fullscreen-mac)
;(frame-parameters)

(defun toggle-fill-paragraph ()
  ;; Based on http://xahlee.org/emacs/modernization_fill-paragraph.html
  "Fill or unfill the current paragraph, depending upon the current line length.
When there is a text selection, act on the region.
See `fill-paragraph' and `fill-region'."
  (interactive)
  ;; We set a property 'currently-filled-p on this command's symbol
  ;; (i.e. on 'my-toggle-fill-paragraph), thus avoiding the need to
  ;; create a variable for remembering the current fill state.
  (save-excursion
    (let* ((deactivate-mark nil)
           (line-length (- (line-end-position) (line-beginning-position)))
           (currently-filled (if (eq last-command this-command)
                                 (get this-command 'currently-filled-p)
                               (< line-length fill-column)))
           (fill-column (if currently-filled
                            most-positive-fixnum
                          fill-column)))

      (if (region-active-p)
          (fill-region (region-beginning) (region-end))
        (fill-paragraph))

      (put this-command 'currently-filled-p (not currently-filled)))))
