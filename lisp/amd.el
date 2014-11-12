
;; (defun amd--find-define ()
;;   (interactive)
;;   (save-excursion

;;     (beginning-of-buffer)
;;     (save-match-data
;;       ;; Match the whole define block:
;;       (re-search-forward amd--regexp)
;;       (goto-char (match-beginning 0))
;;       (let ((end (match-end 0)))
;; 	(re-search-forward "define\s*(\s*\\[\s*")
;; 	(while (and (re-search-forward "['\"][[:alnum:]\/\!]+['\"]")
;; 		    (< (point) end))
;; 	  (message (buffer-substring (match-beginning 0) (match-end 0))))))))

;; (defun amd--find-define ()
;;   (interactive)
;;   (save-excursion

;;     (beginning-of-buffer)
;;     (save-match-data
;;       ;; Match the whole define block:
;;       (re-search-forward amd--regexp)
;;       (goto-char (match-beginning 0))
;;       (let ((end (match-end 0)))
;; 	(re-search-forward "define\s*(\s*\\[\s*")
;; 	(for do (re-search-forward "['\"][[:alnum:]\/\!]+['\"]")
;; 	     until (and (re-search-forward "['\"][[:alnum:]\/\!]+['\"]")
;; 			(not (< (point) end)))
;; 	     do)

;; 	(while (and )
;; 	  (message (buffer-substring (match-beginning 0) (match-end 0))))))))


(global-set-key (kbd "C-@") 'amd--find-define)
(defvar amd--regexp "define\s*(\s*\\[\s*\\(['\"][[:alnum:]\/]*['\"],?[[:space:]\n\r]*\\)*\s*\\],[[:space:]\n\r]*function[[:space:]\n\r]*(\\([[:alnum:]_]*,[[:space:]\n\r]*\\)*[[:alnum:]_]*)")

;; (defvar amd--regexp-
;;   (concat "define\s*(\s*\\[\s*"                                ;; Match start of the define
;; 	  "\\(['\"][[:alnum:]\/!]*['\"],?[[:space:]\n\r]*\\)*" ;; Match every path
;; 	  "\s*\\],[[:space:]\n\r]*function[[:space:]\n\r]*("   ;; Match ], function (
;; 	  "\\([[:alnum:]_]*,[[:space:]\n\r]*\\)*[[:alnum:]_]*" ;; Match every argument
;; 	  ")"))

;; (message (concat amd--regexp "\n" amd--regexp-))

(defun amd-add-import (path name)
  (interactive "sEnter path: \nsEnter variable name: ")
  (amd--find-define examplebuffer))

(defvar examplebuffer "define(['hei/hallo', 'jaha/neinei'], function(Hallo, Neinei) {")

"define\s*(\s*\\[\s*\\(['\"][[:alnum:]\/]*['\"],?[[:space:]\n\r]*\\)*\s*\\],[[:space:]\n\r]*function[[:space:]\n\r]*([[:alnum:_]]*"

"define\s*(\s*\\[\s*\\(['\"][[:alnum:]\/]*['\"],?[[:space:]\n\r]*\\)*\s*\\],[[:space:]\n\r]*function[[:space:]\n\r]*(\\([[:alnum:_]]*,[[:space:]\n\r]*\\)*"

(provide 'amd) 
