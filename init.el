;;----------------------------------------------------------------------
;; .emacs for Knut Helland
;;----------------------------------------------------------------------

(defun settings () "Open .emacs file" (interactive)
  (find-file (concat user-emacs-directory "/init.el")))

(defun notes () "Open personal notebook" (interactive)
  (find-file (concat user-emacs-directory "/../notes/knut.org")))

(defun appearance () "Open appearance file" (interactive)
  (find-file (concat user-emacs-directory "/lisp/appearance.el")))

;; Basic keybindings
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-ø") 'kill-region)
(global-set-key (kbd "C-M-7") 'undo)
(global-set-key (kbd "M-p") (lambda () (interactive) (previous-line 5)))
(global-set-key (kbd "M-n") (lambda () (interactive) (next-line 5)))
(global-set-key (kbd "C-.") 'completion-at-point)

;; User information
(setq user-mail-address "knutoh@gmail.com")
(setq user-full-name "Knut Helland")

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(add-to-list 'load-path (concat user-emacs-directory "lisp"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp"))
(require 'setup-package)
(require 'initial-config)
(require 'appearance)

;; Install our packages
(load-file (concat user-emacs-directory "/lisp/ensure-package-installed.el"))
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
 'yasnippet
 'go-mode
 'coffee-mode
 'markdown-mode
 'flymake-php
 'yafolding
 'php-auto-yasnippets
 'less-css-mode
 'js2-mode
 'js2-refactor
 'protobuf-mode
 'clojure-mode
 ;;'emacs-eclim             ;; Java Eclipse interaction
 'frame-cmds
 ;; 'fiplr
 'flx-ido
 'ido-vertical-mode
 'multiple-cursors
 'perspective
 'projectile
 'persp-projectile
 'expand-region)
(package-initialize)

(require 'global-setups)
(require 'setup-paredit)
(require 'setup-guide-key)
(require 'setup-html)
(require 'setup-yasnippet)
(require 'knut-fn)
(require 'php-mode)
;; (require 'find-file-in-project)
;; (require 'setup-ffip)
(require 'setup-php)
(require 'setup-ido)
(require 'find-file-sudo)
(eval-after-load 'clojure-mode '(require 'setup-clojure))
(eval-after-load 'go-mode '(require 'setup-go))
(eval-after-load 'markdown-mode '(require 'setup-markdown))
(eval-after-load 'js2-mode '(require 'setup-js))

(setq set-mark-command-repeat-pop t)

(projectile-global-mode)
(setq projectile-completion-system 'ido)
(setq projectile-indexing-method 'alien)
(setq projectile-enable-caching t)
(setq projectile-remember-window-configs t)
(setq projectile-file-exists-remote-cache-expire (* 10 60))
(define-key projectile-mode-map (kbd "C-c p g") 'projectile-grep)

(add-hook 'html-mode-hook 'whitespace-mode)

(persp-mode)
(require 'persp-projectile)
(define-key projectile-mode-map (kbd "C-c p p") 'projectile-persp-switch-project)

(setq org-hide-leading-stars t)
(setq org-startup-indented t)
(setq org-todo-keywords '("TODO" "WAITING" "DONE"))

;; File extensions:
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.cljs\\'" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . html-mode))

;; Global key bindings
(global-set-key (kbd "C-@") 'er/expand-region)
(global-set-key (kbd "RET") 'newline-and-indent)
; (global-set-key (kbd "C-x g") 'goto-line)
; (global-set-key (kbd "C-x C-g") 'goto-line)
(global-set-key (kbd "C-x M-7") 'comment-region)
(global-set-key (kbd "C-x M-/") 'uncomment-region)
(global-set-key (kbd "C-x i") (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "<C-268632080>") (lambda () (interactive) (scroll-screen-and-cursor -5)))
(global-set-key (kbd "<C-268632078>") (lambda () (interactive) (scroll-screen-and-cursor +5)))
(global-set-key (kbd "C-c C-d") 'duplicate-line)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-S-a") 'dabbrev-expand)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c b") 'magit-blame-mode)
(global-set-key (kbd "C-c m") 'magit-status)
(global-set-key (kbd "C-c l") 'magit-log)
(global-set-key (kbd "C-x C-c") (lambda () (interactive) (if (yes-or-no-p "Really want to quit Emacs? ") (save-buffers-kill-terminal))))
(global-set-key (kbd "M-h") 'ns-do-hide-emacs)
(global-set-key (kbd "C-<tab>") 'yas-expand)
(global-set-key (kbd "C-x f") 'projectile-find-file)
; (global-set-key (kbd "<up>") 'scroll-screen-and-cursor-up)
(global-set-key (kbd "<C-M-268632080>") (lambda () (interactive) (other-window 1)))
; (global-set-key (kbd "<down>") 'scroll-screen-and-cursor-down)
(global-set-key (kbd "<C-M-268632078>") (lambda () (interactive) (other-window -1)))
(global-unset-key (kbd "M-l"))
(global-unset-key (kbd "M-u"))
(global-unset-key (kbd "C-x m"))


(setq-default tab-width 4)
(defvaralias 'cperl-indent-level 'tab-width)
(defvaralias 'js-indent-level 'tab-width)
;(defvaralias 'js2-basic-offset 'tab-width)

;; (defun jsimports ()
;;   "Formats the current buffer according to the jsimports tool."

;;   (interactive)
;;   (let ((tmpfile (make-temp-file "jsimports" nil ".js"))
;;         (patchbuf (get-buffer-create "*Gofmt patch*"))
;;         (errbuf (if gofmt-show-errors (get-buffer-create "*Gofmt Errors*")))
;;         (coding-system-for-read 'utf-8)
;;         (coding-system-for-write 'utf-8))

;;     (save-restriction
;;       (widen)
;;       (if errbuf
;;           (with-current-buffer errbuf
;;             (setq buffer-read-only nil)
;;             (erase-buffer)))
;;       (with-current-buffer patchbuf
;;         (erase-buffer))

;;       (write-region nil nil tmpfile)

;;       ;; We're using errbuf for the mixed stdout and stderr output. This
;;       ;; is not an issue because gofmt -w does not produce any stdout
;;       ;; output in case of success.
;;       (if (zerop (call-process "/home/dev/code/cockpit/system/src/cockpit/public/app/desktop/src/js/test.js" nil errbuf nil tmpfile))
;;           (progn
;;             (if (zerop (call-process-region (point-min) (point-max) "diff" nil patchbuf nil "-n" "-" tmpfile))
;;                 (message "Buffer is already jsimports")
;;               (go--apply-rcs-patch patchbuf)
;;               (message "Applied jsimports"))
;;             (if errbuf (kill-buffer errbuf)))
;;         (message "Could not apply gofmt")
;;         (if errbuf (gofmt--process-errors (buffer-file-name) tmpfile errbuf)))

;;       (kill-buffer patchbuf)
;;       (delete-file tmpfile))))

(smart-tabs-advice js2-indent-line js2-basic-offset)

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
