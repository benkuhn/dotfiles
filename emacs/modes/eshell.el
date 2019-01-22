(setq eshell-prompt-function
      (lambda ()
        (concat
         (propertize (concat " " (abbreviate-file-name (eshell/pwd)) " ") 'face 'bsk/eshell-dir)
         (propertize "$" 'display (powerline-arrow-left 'bsk/eshell-dir 'default))
         " ")))

;;;; Code to automatically warn when command finishes
;; TODO(ben): generalize to other command modes??
(defun my-eshell-precmd ()
  (setq-local last-cmd-time (current-time)))
(add-hook 'eshell-pre-command-hook 'my-eshell-precmd)

;; TODO(ben): OS X only
(defun shell-quote (s)
  (concat "\"" s "\""))
(defun send-notification (title message)
  (shell-command (string-join (list "terminal-notifier"
                                    "-activate org.gnu.Emacs -sender org.gnu.Emacs"
                                    "-message " (shell-quote message)
                                    "-title" (shell-quote title)) " ")))

(defun my-eshell-init ()
  ;; WTF? for some reason the eshell mode map is buffer local >:(
  ;; if you look in the code it says FIXME: what the hell? when that is set up :P

  ;; Don't override my M-? binding for help
  (define-key eshell-mode-map (kbd "M-?") nil))
(add-hook 'eshell-mode-hook 'my-eshell-init)

(defun my-eshell-postcmd ()
  (if (and (boundp 'last-cmd-time)
           (> (time-to-seconds (time-since last-cmd-time)) 10))
      (send-notification "Command finished" eshell-last-command-name)))
(add-hook 'eshell-post-command-hook 'my-eshell-postcmd)

(setq eshell-highlight-prompt nil)

(global-set-key (kbd "C-c C-e") 'eshell)
