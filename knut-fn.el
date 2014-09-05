
;; Custom functions for Knut Helland

(defun duplicate-line ()
  "Duplicates the current line downwards."
  (interactive)
  (save-excursion
    (move-beginning-of-line 1)
    (set-mark (point))
    (next-line 1)
    (kill-ring-save (mark) (point))
    (yank))
  (next-line 1))

(defun scroll-screen-and-cursor (lines)
  "Scrolls and moves cursor"
  (scroll-down-line (- 0 lines))
  (next-line lines))

(defun scroll-screen-and-cursor-up ()
  "Scrolls one line up and moves the cursor one line down."
  (interactive)
  (scroll-screen-and-cursor -1))

(defun scroll-screen-and-cursor-down ()
  "Scrolls one line down and moves the cursor one line up."
  (interactive)
  (scroll-screen-and-cursor 1))


(provide 'knut-fn)
