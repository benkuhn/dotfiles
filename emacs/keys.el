;;; better keybindings.
;; if no active region, do backward-delete-word
(global-set-key (kbd "C-w") 'my-c-w)
;; C-x b foo C-x k
(global-set-key "\C-xk" 'kill-this-buffer)
;; C-h should backspace
(define-key key-translation-map "\C-h" "\C-?")
(global-set-key (kbd "M-?") 'help-command)
(global-set-key (kbd "C-x M-%") 'replace-string)
;; regexp isearch
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-S") 'isearch-forward)
(global-set-key (kbd "C-R") 'isearch-backward)
;; recent file
(global-set-key (kbd "M-g r") 'helm-recentf)
;; qrr is awesome and useful
(global-set-key "\C-x\C-r" 'query-replace-regexp)
;; as is s-i-r
(global-set-key (kbd "\C-x r S") 'string-insert-rectangle)
;; Eclipse-like beginning of line
(global-set-key "\C-a" 'smart-beginning-of-line)
(global-set-key [home] 'smart-beginning-of-line)
;; more convenient things
(global-set-key "\M-Y" 'yank-pop-forwards)
(global-set-key "\M-Q" 'unfill-paragraph)
;; freaking completion/help buffers sticking around all the time
(global-set-key (kbd "C-M-S-q") 'quit-other-window)
;; by analogy to C-x l
(global-set-key (kbd "C-x w") 'count-words)
;; I never use open-line, but use other-window a lot
(global-set-key (kbd "C-o") 'other-window)
(after 'dired
  (define-key dired-mode-map (kbd "C-o") 'other-window))
(after 'ggtags
  (define-key ggtags-global-mode-map (kbd "C-o") 'other-window)
  (define-key ggtags-global-mode-map (kbd "o") 'compilation-display-error))

;; Better window movement (these keys are currently undefined)
(global-set-key (kbd "s-<left>") 'windmove-left)
(global-set-key (kbd "s-<right>") 'windmove-right)
(global-set-key (kbd "s-<up>") 'windmove-up)
(global-set-key (kbd "s-<down>") 'windmove-down)

(global-unset-key (kbd "C-x o")) ;; hack to break old habit
;; Some of the help functions are crazy slow and I only ever hit them by accident
(define-key help-map (kbd "h") nil)
(define-key help-map (kbd "s") nil)

;;; program shortcuts
(global-set-key (kbd "C-x C-4") 'mu4e)

;;; org mode
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;;; magit
(global-set-key "\C-xg" 'magit-status)

;;; duplicate line
(global-set-key "\C-c\C-d" 'duplicate-line)

;;; zen mode
(global-set-key "\C-x\C-z" 'zen-mode)

;;; helm etc
(global-set-key (kbd "C-.") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "s-t") 'helm-projectile)

;;; Beeminded files
(global-unset-key (kbd "C-x C-b"))
(global-set-key (kbd "C-x C-b C-d") 'new-daily-review)
(global-set-key (kbd "C-x C-b C-s") 'new-strategic-review)
(global-set-key (kbd "C-x C-b C-f") 'finish-beeminded-file)

;;; Fullscreen. This is C-s-f, dunno why emacs doesn't like that syntax
(global-set-key (kbd "<C-s-268632070>") 'toggle-frame-fullscreen)
