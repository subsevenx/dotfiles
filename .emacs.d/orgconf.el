;;; orgconf.el --- Org UI conf -*- lexical-binding: t; -*-
;;; Commentary: Configuration for my org mode.
;;; Code:
(use-package org
  :pin org
  :preface
  ;; Font set-up
  (defun org-font-setup ()
    (dolist (face '((org-level-1 . 1.35)
                    (org-level-2 . 1.3)
                    (org-level-3 . 1.2)
                    (org-level-4 . 1.1)
                    (org-level-5 . 1.1)
                    (org-level-6 . 1.1)
                    (org-level-7 . 1.1)
                    (org-level-8 . 1.1)))
      (set-face-attribute (car face) nil :font "Droid Sans" :weight 'bold :height (cdr face)))

    (set-face-attribute 'org-document-title nil :font "Droid Sans" :weight
			'bold :height 1.8)

    ;; Some parts must use fixed-pitch even when variable pitch is set.
    (set-face-attribute 'org-block nil    :inherit 'fixed-pitch)
    (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
    (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
    (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
    (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
    (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

  (defun org-mode-setup ()
    (org-font-setup)
    (org-indent-mode 1)
    (variable-pitch-mode 1)
    (auto-fill-mode 0)
    (visual-line-mode 1))
  
  (defun org-mode-visual-fill ()
    (setq visual-fill-column-width 120
          visual-fill-column-center-text t)
    (visual-fill-column-mode 1))
  
  :hook ((org-mode . org-mode-setup)
         (org-mode . org-mode-visual-fill))

  :config
  (setq org-log-into-drawer t
	org-log-done 'time
	org-log-repeat 'time
	org-log-states-order-reversed t
	org-ellipsis " ▼"
        org-pretty-entities t
        org-hide-emphasis-markers t
	org-outline-path-complete-in-steps t
	org-refile-use-outline-path 'file
	org-outline-path-complete-in-steps nil
	org-refile-targets '(("~/Notes/200.Profressional/200.Professional.Agenda.Done.org" :maxlevel . 3))
	org-time-stamp-formats '("<%Y-%m-%d %a>" . "<%Y-%m-%d %a %H:%M:%S>")
	org-agenda-files
	'("~/Notes/200.Profressional/200.Profressional.Agenda.org"))

  ;; Conf: Agenda, keywords, templates.
  (setq org-todo-keywords
	'((sequence "TODO(t!)" "MAYBE(m!)" "WAITING(w!)" "NEXT(n!)" "STARTED(s!)"
                    "|" "DONE(d!)" "DEFERRED(f@)" "CANCELLED(c@)")
          (sequence "NOTE(o)" "|")))
  
  (setq org-todo-keyword-faces
	'(("TODO" :foreground "DarkOrange" :weight bold)
          ("MAYBE" :foreground "plum2" :weight bold)
          ("WAITING" :foreground "gold" :weight bold)
          ("NEXT" :foreground "khaki3" :weight bold)
          ("STARTED" :foreground "chartreuse" :weight bold)
          ("NOTE" :foreground "MediumBlue" :weight normal)
          ("DONE" :foreground "MediumSpringGreen" :weight bold)
          ("DEFERRED" :foreground "DimGray" :weight bold)
          ("CANCELLED" :foreground "firebrick3" :strike-through t :weight bold))))

(require 'org-indent)

(provide 'orgconf)

;;; orgconf.el ends here
