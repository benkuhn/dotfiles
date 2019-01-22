(define-key emacs-lisp-mode-map "\C-x\C-e" 'pp-eval-last-sexp)

(add-hook 'emacs-lisp-mode-hook
          (defun my-elisp-hook ()
            (font-lock-add-keywords nil '(("(\\(setq\\)" 1 'font-lock-keyword-face)
                                          ("[^[:word:]]\\(nil\\|t\\)[^[:word:]]" 1 'font-lock-keyword-face)))
         ))
