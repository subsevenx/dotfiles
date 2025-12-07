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

  (defun org-set-created-prop ()
    """Sets creation date of task when initial status keyword is set"""
    (when (and org-state
               (or (null org-last-state)
                   (string= org-last-state "")))
      (org-set-property "CREATED"
			(format-time-string "[%Y-%m-%d %a %H:%M:%S]"))))

  (defun org-delete-first-logbook ()
    """Deletes first logbook drawer"""
    (when (and org-state
               (or (null org-last-state)
                   (string= org-last-state "")))
      (run-at-time 0.1 nil
		   (lambda ()
		     (save-excursion
		       (org-back-to-heading t)
		       (let ((end (save-excursion (outline-next-heading) (point))))
			 (when (re-search-forward "^[ \t]*:LOGBOOK:" end t)
			   (let ((drawer-start (line-beginning-position)))
			     (when (re-search-forward "^[ \t]*:END:" end t)
			       (delete-region drawer-start (1+ (line-end-position))))))))))))

  ;; These functions were taken from: https://howardism.org/Technical/Emacs/journaling-org.html
  ;; They have been slightly modified.
  ;; This is an in-progress experiment to see what type of journaling setup works for me.
  (defun get-journal-file-today ()
    "Return filename for today's journal entry."
    (let ((daily-name (format-time-string "%Y-%m-%d-%H-%M-%S")))
      (expand-file-name (concat org-journal-dir daily-name ".org"))))

  (defun journal-file-today ()
    "Create and load a journal file based on today's date."
    (interactive)
    (find-file (get-journal-file-today)))
  
  :hook ((org-mode . org-mode-setup)
         (org-mode . org-mode-visual-fill))

  :config
  ;; Journaling Options
  (setq org-journal-dir "~/notes/current/100.Personal/")

  ;; Core Org Options
  (setq org-log-into-drawer t
	org-log-done 'time
	org-log-repeat 'time
	org-log-states-order-reversed t
	org-ellipsis " ▼"
        org-pretty-entities t
	org-hide-leading-stars t
        org-hide-emphasis-markers t
	org-outline-path-complete-in-steps t
	org-refile-use-outline-path 'file
	org-outline-path-complete-in-steps nil
	org-refile-targets
	'(("~/Notes/200.Professional/200.Professional.Agenda.Done.org" :maxlevel . 1))
	org-time-stamp-formats
	'("<%Y-%m-%d %a>" . "<%Y-%m-%d %a %H:%M:%S>")
	org-agenda-files
	'("~/notes/current/200.Professional/200.Professional.Agenda.org")
	org-todo-keywords
	'((sequence "TODO(t!)" "MAYBE(m!)" "WAITING(w!)" "NEXT(n!)" "STARTED(s!)"
                    "|" "DONE(d!)" "DEFERRED(f@)" "CANCELLED(c@)")
          (sequence "NOTE(o)" "|"))
	org-todo-keyword-faces
	'(("TODO" :foreground "DarkOrange" :weight bold)
          ("MAYBE" :foreground "plum2" :weight bold)
          ("WAITING" :foreground "gold" :weight bold)
          ("NEXT" :foreground "khaki3" :weight bold)
          ("STARTED" :foreground "chartreuse" :weight bold)
          ("NOTE" :foreground "MediumBlue" :weight normal)
          ("DONE" :foreground "MediumSpringGreen" :weight bold)
          ("DEFERRED" :foreground "DimGray" :weight bold)
          ("CANCELLED" :foreground "firebrick3" :strike-through t :weight bold)))

  ;; Hook custom functions
  (add-hook 'org-after-todo-state-change-hook #'org-set-created-prop)
  (add-hook 'org-after-todo-state-change-hook #'org-delete-first-logbook)

 :bind (:map org-mode-map
	     ("C-c C-}" . org-timestamp-up-day)
	     ("C-c C-{" . org-timestamp-down-day)
	     ("C-c c" . org-capture)
	     ("C-c f j" . journal-file-today)))

;; save active buffers when triggering refile
(advice-add 'org-refile :after 'org-save-all-org-buffers)

(require 'org-id)
(setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)

(require 'org-indent)

(provide 'orgconf)

;;; orgconf.el ends here
