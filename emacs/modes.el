;;; load everything in the modes/ directory
(dolist (fname (directory-files "~/conf/emacs/modes"))
  (if (and (> (length fname) 3) (string= (substring fname -3) ".el"))
      (load-library-from-init (concat "modes/" fname))))

;;; Emacs Speaks Statistics
;(require 'ess-site)

;;; nicer filenames
(require 'uniquify)
(setq
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")

;;; recentf mode
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 100)

;;; text mode
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

;;; kill unused buffers
(require 'midnight)
(midnight-delay-set 'midnight-delay "4:30am")
(setq clean-buffer-list-delay-general 10)

;; markdown-mode
(autoload 'markdown-mode "markdown-mode" "A major mode for Markdown" t)
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))

;;; w3m customizations
(setq w3m-default-display-inline-images t)

;;; for LaTeX: auto-refresh PDF buffers
(add-hook 'doc-view-mode-hook 'auto-revert-mode)

;;; powerline
;(require 'powerline)
;(powerline-default-theme)

;;; undo tree
;(require 'undo-tree)
;(global-undo-tree-mode 1)

(require 'use-package)
(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("M-y" . helm-show-kill-ring)
         ("C-x b" . helm-buffers-list))
  :config (progn
	          (setq helm-buffers-fuzzy-matching t)
            (helm-mode 1)))

(if (require 'diminish nil 'noerror)
    (progn
      
      (defmacro lazy-diminish (mode &optional modename lighter)
        (unless modename
          (setq modename (intern (concat (symbol-name mode) "-mode"))))
        (unless lighter
          (setq lighter ""))
        `(after ',mode
           (diminish ',modename ,lighter)))
      
      (lazy-diminish auto-complete)
      (lazy-diminish ropemacs)
      (lazy-diminish yasnippet yas-minor-mode)
      (lazy-diminish undo-tree)
      (lazy-diminish helm)
      (lazy-diminish helm-gtags)
      (lazy-diminish ggtags))
  (message "diminish not installed"))


(if (require 'projectile nil 'noerror)
    (progn
      (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
      (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
      (projectile-mode +1))
  (message "projectile not installed"))

