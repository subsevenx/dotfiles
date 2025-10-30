;;; orgconf.el --- Org UI conf -*- lexical-binding: t; -*-
;;; Commentary: Configuration for my org mode.
;;; Code:

(use-package org
  :preface
  (defun org-mode-setup ()
    (org-indent-mode 1)
    (variable-pitch-mode 1)
    (auto-fill-mode 0)
    (visual-line-mode 1))
  (defun org-mode-visual-fill ()
    (setq visual-fill-column-width 100
          visual-fill-column-center-text t)
    (visual-fill-column-mode 1))
  :hook ((org-mode . org-mode-setup)
         (org-mode . org-mode-visual-fill)
         (org-mode . (lambda ()
                       (font-lock-add-keywords
                        nil '(("^ *\\([-]\\) "
                               (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•")))))))))
  :config
  (setq org-ellipsis " ▼"
        org-pretty-entities t
        org-hide-emphasis-markers t))

(use-package visual-fill-column :defer t)

;; Prefer modern bullets
(use-package org-superstar
  :hook (org-mode . org-superstar-mode)
  :custom
  (org-superstar-headline-bullets-list '("◉" "○" "●" "◉" "⚬" "◈" "◇"))
  (org-superstar-item-bullet-alist '((?* . ?•) (?+ . ?•) (?- . ?•)))
  :config
  (setq org-superstar-leading-bullet ?\s)
  (setq org-indent-mode-turns-on-hiding-stars nil))
  
(require 'org-indent)

;; Variable height for headings
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
(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch :height 0.85)
(set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch) :height 0.85)
(set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch) :height 0.85)
(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch) :height 0.85)
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

(provide 'orgconf)

;;; orgconf.el ends here
