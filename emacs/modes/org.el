(after 'org

  (setq org-directory "~/Documents/org")
  (setq
   org-agenda-files (list org-directory)
   org-agenda-window-setup 'other-window
   org-default-notes-file (concat org-directory "/tasks.org")
   org-agenda-span 1
   org-mobile-inbox-for-pull (concat org-directory "/flagged.org")
   org-mobile-directory "~/Dropbox/Apps/MobileOrg"
   org-startup-indented t)

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;; Org mobile stuff: sync automatically
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (setq org-mobile-force-id-on-agenda-items nil)
  (defun org-mobile-sync ()
    (interactive)
    (org-mobile-push)
    (org-mobile-pull))
  (add-hook 'midnight-hook 'org-mobile-sync)

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;; Effort estimates
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (setq org-global-properties
        '(("Effort_ALL" . "0 0:05 0:15 0:30 1:00 1:30 2:00")))

  (defun agenda-gtd (hotkey tags)
    `(,hotkey ,(concat "Tagged with " tags)
              ((tags-todo "+time")
               (agenda ,tags)
               (tags-todo ,(concat tags "-time")))
              ((org-agenda-todo-ignore-scheduled t)
               (org-agenda-todo-ignore-deadlines t))
              ))

  (setq org-agenda-custom-commands
        `(
          ,(agenda-gtd "h" "+home")
          ,(agenda-gtd "p" "+phone")
          ,(agenda-gtd "e" "+errands")
          ,(agenda-gtd "t" "+time")
          ,(agenda-gtd "r" "+create")
          ,(agenda-gtd "o" "+consume")
          ,(agenda-gtd "b" "+busy")
          ,(agenda-gtd "h" "+home")
          ,(agenda-gtd "a" "")
          ))

  (setq org-agenda-dim-blocked-tasks 'invisible)
  (setq org-agenda-tags-todo-honor-ignore-options t)
  (setq org-enforce-todo-dependencies t)
  (setq org-track-ordered-property-with-tag "seq")
  (setq org-imenu-depth 4)
  )
