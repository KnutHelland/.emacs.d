(require 'flymake-node-jshint)
(require 'js2-refactor)

(add-hook 'js-mode-hook (lambda () (flymake-mode 1)))
(custom-set-faces
 '(flymake-errline ((((class color)) (:foreground "#073642")))))

; (define-key js2-mode-map (kbd "C-k") 'js2r-kill)

(add-hook 'js2-mode-hook 'whitespace-mode)

(defcustom jsimports-command "/usr/local/bin/node"
  ""
  :type 'string
  :group 'jsimports)

(setq jsimports-command "jsimports")

;; (defun jsimports ()
;;   (interactive)
;;   (save-excursion
;; 	(save-buffer)
;; 	(call-process "node" nil (get-buffer-create "*jsimports-output*") nil "/Users/knut/Desktop/devbox/code/cockpit/system/src/cockpit/public/app/desktop/src/js/test.js" (buffer-file-name) "-w")
;; 	(revert-buffer nil t)))

(defun jsimports--goto-line (line)
  (goto-char (point-min))
  (forward-line (1- line)))

;; Delete the current line without putting it in the kill-ring.
(defun jsimports--delete-whole-line (&optional arg)
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

(defun jsimports--apply-rcs-patch (patch-buffer)
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
            (error "invalid rcs patch or internal error in jsimports--apply-rcs-patch"))
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
                (jsimports--goto-line (- from line-offset))
                (incf line-offset len)
                (jsimports--delete-whole-line len)))
             (t
              (error "invalid rcs patch or internal error in jsimports--apply-rcs-patch")))))))))

(defun jsimports ()
  "Formats the current buffer according to the gofmt tool."

  (interactive)
  (let ((tmpfile (flymake-create-temp-inplace buffer-file-name "jsimports"))
        (patchbuf (get-buffer-create "*Jsimports patch*"))
        (errbuf (get-buffer-create "*Jsimports Errors*"))
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
      (if (zerop (call-process jsimports-command nil errbuf nil tmpfile "-w"))
          (progn
            (if (zerop (call-process-region (point-min) (point-max) "diff" nil patchbuf nil "-n" "-" tmpfile))
                (message "Buffer already have correct imports")
              (jsimports--apply-rcs-patch patchbuf)
              (message "Applied jsimports"))
            (if errbuf (kill-buffer errbuf)))
        (message "Could not apply jsimports")
        (if errbuf (jsimports--process-errors (buffer-file-name) tmpfile errbuf)))

      (kill-buffer patchbuf)
      (delete-file tmpfile))))


(defun jsimports--process-errors (filename tmpfile errbuf)
  ;; (with-current-buffer errbuf
  ;;   (progn
  ;; 	  (message "%s" (buffer-string))
  ;; 	  (kill-buffer errbuf))
  ;; 	;; Convert the gofmt stderr to something understood by the compilation mode.
  ;; 	(goto-char (point-min))
  ;; 	(insert "jsimports errors:\n")
  ;; 	(while (search-forward-regexp (concat "^\\(" (regexp-quote tmpfile) "\\):") nil t)
  ;; 	  (replace-match (file-name-nondirectory filename) t t nil 1))
  ;; 	(compilation-mode)
  ;; 	(display-buffer errbuf)))
  )



(define-key js2-mode-map (kbd "C-x M-j") 'jsimports)

(defun dos2unix (buffer)
  "Automate M-% C-q C-m RET C-q C-j RET"
  (interactive "*b")
  (save-excursion
	(goto-char (point-min))
	(while (search-forward (string ?\C-m) nil t)
	  (replace-match (string ?\C-j) nil t))))

(defun js2-mode-customization ()

  (subword-mode 1)
  (setq indent-tabs-mode t
	tab-width 4)
  (smart-tabs-mode))

(add-hook 'js2-mode-hook 'js2-mode-customization)

(provide 'setup-js)
