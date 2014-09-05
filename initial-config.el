
;; Turn off menubar and toolbar and disable splash screen.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(transient-mark-mode -1)
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)

;; Going silent
(setq visible-bell t)

;; Automatically refresh buffers
(global-auto-revert-mode 1)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;; Show keystrokes immediately
(setq echo-keystrokes 0.000001)

;; Move files to trash when deleting
(setq delete-by-moving-to-trash t)

;; Undo/redo window configs with C-c left/right
(winner-mode 1)

;; Highlight matching parentheses when the point is on them.
(show-paren-mode 1)

;; ;; Navigate inside CamelCase words
;; This does not work good when finding files and/or scrolling.
;; (global-subword-mode 1)

;; Always display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; Lines should be 80 characters wide, not 72
(setq fill-column 80)

;; Don't be so stingy on the memory, we have lots now. It's the distant future.
(setq gc-cons-threshold 20000000)

;; Enable system clipboard
(setq x-select-enable-clipboard t)

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

;; Mac or not mac:
(if (eq system-type 'darwin)
  (setq mac-option-modifier nil
	mac-command-modifier 'meta
        mac-function-modifier 'ctrl)
  (set-face-attribute 'default nil :height 100))

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Understandable buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

(provide 'initial-config)
