(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive "^")
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line 1))))

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(defun yank-pop-forwards (arg)
  (interactive "p")
  (yank-pop (- arg)))

;;; function to rotate a list of strings
(defun permute-strings (args)
  (interactive (list (get-permute-args 1)))
  (save-excursion
    (save-restriction
      (narrow-to-region (point) (mark))
      (beginning-of-buffer)
      (replace-string (car args) "__TMP__")
      (let ((end (permute-strings-helper args)))
        (beginning-of-buffer)
        (replace-string "__TMP__" end)))))

(defun permute-strings-helper (args)
  (if (cadr args)
      (progn
        (beginning-of-buffer)
        (replace-string (cadr args) (car args))
        (permute-strings-helper (cdr args)))
    (car args)))

(defun get-permute-args (num)
  (let ((arg (read-string "String to permute: " nil 'my-history)))
    (if (string= arg "")
        nil
      (cons arg (get-permute-args (+ num 1))))))

;;; make C-w work nicely
(defun my-c-w ()
  (interactive)
  (if (region-active-p)
      (kill-region (region-beginning) (region-end))
    (backward-kill-word 1)))

;;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph    
(defun unfill-paragraph ()
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(defun truncate-list (n lst)
  (if (eq n 1)
      (setcdr lst nil)
    (truncate (- n 1) (cdr lst))))

(defun quit-other-window ()
  (interactive)
  (quit-window nil (next-window)))

;;; previous window function for keybinding
(defun prev-window ()
  (interactive)
  (other-window -1))

;; duplicate line
;; source: http://stackoverflow.com/a/998472
(defun duplicate-line (arg)
  "Duplicate current line, leaving point in lower line."
  (interactive "*p")

  ;; save the point for undo
  (setq buffer-undo-list (cons (point) buffer-undo-list))

  ;; local variables for start and end of line
  (let ((bol (save-excursion (beginning-of-line) (point)))
        eol)
    (save-excursion

      ;; don't use forward-line for this, because you would have
      ;; to check whether you are at the end of the buffer
      (end-of-line)
      (setq eol (point))

      ;; store the line and disable the recording of undo information
      (let ((line (buffer-substring bol eol))
            (buffer-undo-list t)
            (count arg))
        ;; insert the line arg times
        (while (> count 0)
          (newline)         ;; because there is no newline in 'line'
          (insert line)
          (setq count (1- count)))
        )

      ;; create the undo information
      (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list)))
    ) ; end-of-let

  ;; put the point in the lowest line and return
  (next-line arg))

;;; Create templates of files

(setq beeminded-files-root "~/Dropbox (Personal)/Beeminded/")

(defun my-read-file-as-string (path)
  (with-temp-buffer
    (insert-file-contents path)
    (buffer-string)))

(defun new-beeminded-file-from-template (folder)
  (let* ((filename (format-time-string "%Y-%m-%d"))
         (folder-path (concat beeminded-files-root folder "/"))
         (path (concat folder-path filename ".org"))
         (template (my-read-file-as-string (concat folder-path "TEMPLATE.org")))
         (bufname (concat "Today's " folder)))
    (if (get-buffer bufname)
        (progn
          (switch-to-buffer bufname)
          (message "Buffer already exists; did you mean to call finish-beeminded-file instead?"))
      (progn
        (find-file path)
        (insert template)
        (save-buffer)
        (beginning-of-buffer)
        (next-line)
        (rename-buffer bufname)))))

(defun finish-beeminded-file ()
  ; TODO(ben) perhaps make a Beeminder API call myself? That way no
  ; Zapier dependency...
  (interactive)
  (let* ((bufname (buffer-name))
         (filename (buffer-file-name))
         (new-filename (dired-replace-in-string ".org" "-done.org" filename)))
    (cond ((not (file-in-directory-p filename beeminded-files-root))
           (message "Buffer isn't beeminded"))
          ((not (beeminded-file-is-filled-out))
           (message "Buffer isn't filled out"))
          ((string-suffix-p "-done.org" filename)
           (message "Buffer is already done"))
          (t
           (save-buffer)
           (rename-file filename new-filename)
           (set-visited-file-name new-filename)
           (set-buffer-modified-p nil)
           (rename-buffer bufname)
           (message "Marked as done!")))))

(defun beeminded-file-is-filled-out ()
  "Check that every heading contains some text"
  ; TODO(ben) there has GOT to be a better way to write this...
  (eval `(and . ,(org-map-entries 'beeminded-entry-is-filled-out))))

(defun beeminded-entry-is-filled-out ()
  "With the cursor at the beginning of an entry, return t if the
length of the body is > 5, false otherwise"
  (end-of-line)
  (let ((pos (point)))
    (outline-next-heading)
    (let ((len (- (point) pos)))
      (> len 5))))

(defun new-daily-review ()
  (interactive)
  (new-beeminded-file-from-template "Daily Review"))

(defun new-strategic-review ()
  (interactive)
  (new-beeminded-file-from-template "Strategic Review"))

;;; Get rid of fancy chars
(defun de-fancify-region ()
  (interactive)
  (save-excursion
    (narrow-to-region (point) (mark))
    (beginning-of-buffer)
    (replace-string "—" "--")
    (beginning-of-buffer)
    (replace-string "’" "'")
    (beginning-of-buffer)
    (replace-string "‘" "'")
    (beginning-of-buffer)
    (replace-string "–" "--")
    (beginning-of-buffer)
    (replace-string "“" "\"")
    (beginning-of-buffer)
    (replace-string "”" "\"")
    (beginning-of-buffer)
    (replace-string "…" "...")
    (widen)))

(defmacro defmyhook (hookname &rest body)
  (let ((funcname (make-symbol (concat "bsk/" (symbol-name hookname)))))
  `(progn
     (defun ,funcname () ,@body)
     (add-hook ',hookname ',funcname))))
