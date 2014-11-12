

(defcustom phpimports-command "/usr/local/bin/phpimports"
  ""
  :type 'string
  :group 'phpimports)

(setq phpimports-command "phpimports")

;; (defun phpimports ()
;;   (interactive)
;;   (save-excursion
;; 	(save-buffer)
;; 	(call-process "node" nil (get-buffer-create "*phpimports-output*") nil "/Users/knut/Desktop/devbox/code/cockpit/system/src/cockpit/public/app/desktop/src/js/test.js" (buffer-file-name) "-w")
;; 	(revert-buffer nil t)))

(defun phpimports--goto-line (line)
  (goto-char (point-min))
  (forward-line (1- line)))

;; Delete the current line without putting it in the kill-ring.
(defun phpimports--delete-whole-line (&optional arg)
  ;; Derived from `kill-whole-line'.
  ;; ARG is defined as for that function.
  (setq arg (or arg 1))
  (if (and (> arg 0)
           (eobp)
           (save-excursion (forward-visible-line 0) (eobp)))
      (signal 'end-of-buffer nil))
  (if (and (< arg 0)
           (bobp)
           (save-excursion (end-of-visible-line) (bobp)))
      (signal 'beginning-of-buffer nil))
  (cond ((zerop arg)
         (delete-region (progn (forward-visible-line 0) (point))
                        (progn (end-of-visible-line) (point))))
        ((< arg 0)
         (delete-region (progn (end-of-visible-line) (point))
                        (progn (forward-visible-line (1+ arg))
                               (unless (bobp)
                                 (backward-char))
                               (point))))
        (t
         (delete-region (progn (forward-visible-line 0) (point))
                        (progn (forward-visible-line arg) (point))))))

(defun phpimports--apply-rcs-patch (patch-buffer)
  "Apply an RCS-formatted diff from PATCH-BUFFER to the current
buffer."
  (let ((target-buffer (current-buffer))
        ;; Relative offset between buffer line numbers and line numbers
        ;; in patch.
        ;;
        ;; Line numbers in the patch are based on the source file, so
        ;; we have to keep an offset when making changes to the
        ;; buffer.
        ;;
        ;; Appending lines decrements the offset (possibly making it
        ;; negative), deleting lines increments it. This order
        ;; simplifies the forward-line invocations.
        (line-offset 0))
    (save-excursion
      (with-current-buffer patch-buffer
        (goto-char (point-min))
        (while (not (eobp))
          (unless (looking-at "^\\([ad]\\)\\([0-9]+\\) \\([0-9]+\\)")
            (error "invalid rcs patch or internal error in phpimports--apply-rcs-patch"))
          (forward-line)
          (let ((action (match-string 1))
                (from (string-to-number (match-string 2)))
                (len  (string-to-number (match-string 3))))
            (cond
             ((equal action "a")
              (let ((start (point)))
                (forward-line len)
                (let ((text (buffer-substring start (point))))
                  (with-current-buffer target-buffer
                    (decf line-offset len)
                    (goto-char (point-min))
                    (forward-line (- from len line-offset))
                    (insert text)))))
             ((equal action "d")
              (with-current-buffer target-buffer
                (phpimports--goto-line (- from line-offset))
                (incf line-offset len)
                (phpimports--delete-whole-line len)))
             (t
              (error "invalid rcs patch or internal error in phpimports--apply-rcs-patch")))))))))

(defun phpimports ()
  "Formats the current buffer according to the gofmt tool."

  (interactive)
  (let ((tmpfile (flymake-create-temp-inplace buffer-file-name "phpimports"))
        (patchbuf (get-buffer-create "*Phpimports patch*"))
        (errbuf (get-buffer-create "*Phpimports Errors*"))
        (coding-system-for-read 'utf-8)
        (coding-system-for-write 'utf-8))

    (save-restriction
      (widen)
      (if errbuf
          (with-current-buffer errbuf
            (setq buffer-read-only nil)
            (erase-buffer)))
      (with-current-buffer patchbuf
        (erase-buffer))

      (write-region nil nil tmpfile)

      ;; We're using errbuf for the mixed stdout and stderr output. This
      ;; is not an issue because gofmt -w does not produce any stdout
      ;; output in case of success.
      (if (zerop (call-process phpimports-command nil errbuf nil tmpfile "-w"))
          (progn
            (if (zerop (call-process-region (point-min) (point-max) "diff" nil patchbuf nil "-n" "-" tmpfile))
                (message "Buffer already have correct imports")
              (phpimports--apply-rcs-patch patchbuf)
              (message "Applied phpimports"))
            (if errbuf (kill-buffer errbuf)))
        (message "Could not apply phpimports")
        (if errbuf (phpimports--process-errors (buffer-file-name) tmpfile errbuf)))

      (kill-buffer patchbuf)
      (delete-file tmpfile))))


(defun phpimports--process-errors (filename tmpfile errbuf)
  ;; (with-current-buffer errbuf
  ;;   (progn
  ;; 	  (message "%s" (buffer-string))
  ;; 	  (kill-buffer errbuf))
  ;; 	;; Convert the gofmt stderr to something understood by the compilation mode.
  ;; 	(goto-char (point-min))
  ;; 	(insert "phpimports errors:\n")
  ;; 	(while (search-forward-regexp (concat "^\\(" (regexp-quote tmpfile) "\\):") nil t)
  ;; 	  (replace-match (file-name-nondirectory filename) t t nil 1))
  ;; 	(compilation-mode)
  ;; 	(display-buffer errbuf)))
  )



(define-key php-mode-map (kbd "C-x M-j") 'phpimports)


(defun php-customization ()
  (setq comment-use-syntax t)
  (setq indent-tabs-mode t))

(add-hook 'php-mode-hook 'flymake-mode)
(add-hook 'php-mode-hook 'whitespace-mode)
(add-hook 'php-mode-hook 'php-customization)
(add-hook 'php-mode-hook 'outline-minor-mode)
(add-hook 'php-mode-hook 'smart-tabs-mode)
(add-hook 'php-mode-hook 'subword-mode)
(define-key php-mode-map (kbd "C-.") 'yas/create-php-snippet)

(define-key php-mode-map (kbd "M-<right>") 'show-subtree)
(define-key php-mode-map (kbd "M-<left>") 'hide-subtree)
(define-key php-mode-map (kbd "M-S-<left>") 'hide-other)

(defun php-impl (interactive "p") (kmacro-exec-ring-item (quote ([19 102 117 110 99 116 105 111 110 13 134217826 134217826 67109112 tab 5 backspace 32 backspace return 123 return 116 104 114 111 119 32 110 101 119 32 69 120 99 101 112 116 105 111 110 40 39 77 101 116 104 111 100 32 110 111 116 32 105 109 112 108 101 109 101 110 116 101 100 32 117 101 backspace backspace 121 101 116 39 41 59 return 125 return return 1 4] 0 "%d")) arg))


(provide 'setup-php)
