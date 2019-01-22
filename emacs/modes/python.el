(after 'python
  (message "configuring Python mode")
  ;; this is the worst way of defining keybindings :(
  (eval-when-compile (require 'jedi nil t))
  (setq jedi:setup-keys t)
  (setq jedi:key-goto-definition (kbd "C-c ."))
  (setq jedi:get-in-function-call-delay 0)
  (add-hook 'python-mode-hook 'jedi:setup)

  ;; Rope mode... see http://milkbox.net/note/installing-pymacs-rope-on-emacs-24/
  (require 'pymacs)
  ; (pymacs-load "ropemacs" "rope-")

  (after 'ropemacs
  ; conflicts with my help shortcut and I don't use it anyway
    (define-key ropemacs-local-keymap (kbd "M-?") nil))

  (add-hook 'python-mode-hook 'my-setup-python)

  (define-key python-mode-map (kbd "M-q") 'python-fill-paragraph)
  (define-key python-mode-map (kbd "C-c C-c") 'recompile)

  (defun my-setup-python ()
    ;(add-hook 'before-save-hook 'delete-trailing-whitespace 't 't)
    ))
