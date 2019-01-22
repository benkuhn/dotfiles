;;; GUI is evil
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'blink-cursor-mode) (blink-cursor-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(column-number-mode 1)
(show-paren-mode 1)

(setq ring-bell-function 'ignore)

;;; don't annoy me
(setq disabled-command-function nil)
(setq inhibit-startup-message t)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq initial-scratch-message "")
(setq inhibit-startup-message t)

;;; make mark ring usable
(setq set-mark-command-repeat-pop t)

;;; only one space!
(setq sentence-end-double-space nil)

;;; fix backups
(setq backup-by-copying t      ; don't clobber symlinks
      backup-directory-alist
      '(("." . "~/.emacs.d/backups"))    ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)       ; use versioned backups

;;; completion
(setq completion-ignored-extensions dired-omit-extensions)

;;; Never split horizontally by default; I like my vertical space
(setq split-height-threshold nil)

;;; Graphical dialogs crash emacs, God only knows why
; Source: http://superuser.com/questions/125569/how-to-fix-emacs-popup-dialogs-on-mac-os-x
(defadvice y-or-n-p (around prevent-dialog-yorn activate)
  "Prevent y-or-n-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))
