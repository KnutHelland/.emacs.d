;;----------------------------------------------------------------------
;; .emacs for Knut Helland
;;----------------------------------------------------------------------

(defun settings ()
  "Open .emacs file"
  (interactive)
  (find-file (concat user-emacs-directory "/init.el")))

;; Basic keybindings
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-ø") 'kill-region)
(global-set-key (kbd "C-M-7") 'undo)
(global-set-key (kbd "M-p") (lambda () (interactive) (previous-line 5)))
(global-set-key (kbd "M-n") (lambda () (interactive) (next-line 5)))
(global-set-key (kbd "C-.") 'complete-symbol)

;; User information
(setq user-mail-address "knutoh@gmail.com")
(setq user-full-name "Knut Helland")

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path (concat user-emacs-directory "site-lisp"))
(require 'setup-package)
(require 'initial-config)
(require 'appearance)

;; Install our packages
(load-file (concat user-emacs-directory "ensure-package-installed.el"))
(ensure-package-installed
 'magit
 'guide-key
 'exec-path-from-shell
 ;; 'rainbow-delimiters
 'fill-column-indicator
 ;; 'nrepl
 ;; 'ac-nrepl
 'smart-tabs-mode
 'flymake-cursor
 'go-mode
 'coffee-mode
 'markdown-mode
 'flymake-php
 'less-css-mode
 'protobuf-mode
 'clojure-mode
 ;;'emacs-eclim             ;; Java Eclipse interaction
 'frame-cmds
 'expand-region)
(package-initialize)

(require 'global-setups)
(require 'setup-paredit)
(require 'setup-guide-key)
(require 'knut-fn)
(require 'php-mode)
(require 'setup-php)
(require 'setup-ido)
(require 'setup-js)
(require 'find-file-sudo)
(eval-after-load 'clojure-mode '(require 'setup-clojure))
(eval-after-load 'go-mode '(require 'setup-go))
(eval-after-load 'markdown-mode '(require 'setup-markdown))


;; File extensions:
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.cljs\\'" . clojure-mode))

;; Global key bindings
(global-set-key (kbd "C-@") 'er/expand-region)
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-x g") 'goto-line)
(global-set-key (kbd "C-x C-g") 'goto-line)
(global-set-key (kbd "C-x M-7") 'comment-region)
(global-set-key (kbd "C-x M-/") 'uncomment-region)
(global-set-key (kbd "C-x i") (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "<C-268632080>") (lambda () (interactive) (scroll-screen-and-cursor -5)))
(global-set-key (kbd "<C-268632078>") (lambda () (interactive) (scroll-screen-and-cursor +5)))
(global-set-key (kbd "C-c C-d") 'duplicate-line)
(global-set-key (kbd "<up>") 'scroll-screen-and-cursor-up)
(global-set-key (kbd "<C-M-268632080>") (lambda () (interactive) (other-window 1)))
(global-set-key (kbd "<down>") 'scroll-screen-and-cursor-down)
(global-set-key (kbd "<C-M-268632078>") (lambda () (interactive) (other-window -1)))
(global-unset-key (kbd "M-l"))
(global-unset-key (kbd "M-u"))


;; Tab mode:
(add-hook 'coffee-mode-hook (lambda () (interactive)
                              (setq-default indent-tabs-mode nil)
                              (setq tab-width 4)))

;; (add-hook 'php-mode-hook (lambda () (interactive)
;;                            (setq-default indent-tabs-mode nil)
;;                            (setq tab-width 2)))


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
