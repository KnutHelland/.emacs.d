;;----------------------------------------------------------------------
;; .emacs for Knut Helland
;;----------------------------------------------------------------------

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))


;; Path to my Emacs folder This is the folder where I put extra modes
;; and stuff that I like. And in Dropbox so I can have the same file
;; on all computers ;)
;(setq MY-EMACS-FOLDER (if (or (eq system-type 'gnu/linux)
;			      (eq system-type 'linux))
;			  "/home/knut/Dropbox/resources/emacs"
;			"x:/Dropbox/resources/emacs"))

(setq MY-EMACS-FOLDER (file-name-directory (or load-file-name buffer-file-name)))

;; Mac specifics:
(when (eq system-type 'darwin)
  (setq mac-option-modifier nil
	mac-command-modifier 'meta
;	mac-function-modifier 'hyper
        mac-function-modifier 'ctrl
	x-select-enable-clipboard t))

(text-scale-adjust 1)

(setq user-mail-address "knutoh@gmail.com")
(setq user-full-name "Knut Helland")

;; Turn off menubar and toolbar and disable splash screen.
(menu-bar-mode nil)
(tool-bar-mode 0) ; <- Had to remove this on my mac.
(scroll-bar-mode 0) ; <- Had to remove this too on mac.
(transient-mark-mode 0)
(setq inhibit-splash-screen t)

;; Don't want my emacs to create a lot of files: (I know the risk)
(auto-save-mode nil)
(setq make-backup-files nil)
(global-auto-revert-mode 1)


(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)


(load-file (concat MY-EMACS-FOLDER "/knut-fn.el"))
(add-to-list 'load-path (concat MY-EMACS-FOLDER "/auto-complete"))

;; Load packages:
(add-to-list 'load-path MY-EMACS-FOLDER)
(add-to-list 'load-path (concat MY-EMACS-FOLDER "/jade-mode"))
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
(require 'go-mode)

(require 'flymake-node-jshint)
(require 'flymake-cursor)
(add-hook 'js-mode-hook (lambda () (flymake-mode 1)))
(custom-set-faces
 '(flymake-errline ((((class color)) (:foreground "#073642")))))

(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Setup rainbow delimiters
(global-rainbow-delimiters-mode)

;; Setup fill column indicator
(setq fci-rule-column 80)

;; Switch between light and dark theme:
(add-to-list 'custom-theme-load-path (concat MY-EMACS-FOLDER "/emacs-color-theme-solarized"))
(defun theme-dark ()
  "Use solarized dark theme."
  (interactive)
  (load-theme 'solarized-dark t))
(defun theme-light ()
  "Use solarized light theme."
  (interactive)
  (load-theme 'solarized-light t))

(theme-dark)

(defun settings ()
  "Open .emacs file"
  (interactive)
  (find-file (concat MY-EMACS-FOLDER "/.emacs")))


;; Expand-region.el
(add-to-list 'load-path (concat MY-EMACS-FOLDER "/expand-region"))
(require 'expand-region)
(global-set-key (kbd "C-@") 'er/expand-region)

;; 
(add-to-list 'load-path (concat MY-EMACS-FOLDER "/magit-1.2.0"))
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

(add-hook 'js-mode-hook (lambda () (interactive)
                                  (setq-default indent-tabs-mode nil)
                                  (setq js-indent-level 4)))

(defun set-js-indent []
  (interactive)
  (setq js-indent-level 4))


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
;(global-set-key (kbd "C-c C-d") 'duplicate-line)
(global-set-key (kbd "M-p") (lambda () (interactive) (previous-line 5)))
(global-set-key (kbd "M-n") (lambda () (interactive) (next-line 5)))
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
(global-set-key (kbd "H-f") 'next-buffer)
(global-set-key (kbd "H-b") 'previous-buffer)
(global-set-key (kbd "H-p") (lambda () (interactive) (other-window 1)))
(global-set-key (kbd "H-n") (lambda () (interactive) (other-window -1)))

(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-ø") 'kill-region)

(global-set-key (kbd "C-x M-7") 'comment-region)
(global-set-key (kbd "C-x M-/") 'uncomment-region)

(global-unset-key (kbd "M-l"))
(global-unset-key (kbd "M-u"))


;; (global-set-key (
;;                  [?\M-f ?\M-b ?\C-  ?\C-  ?\M-b ?\M-c nil]))


;; Emacs jabber
;(add-to-list 'load-path (concat MY-EMACS-FOLDER "/emacs-jabber"))
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

