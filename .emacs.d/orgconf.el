 
;;; Code:

;; Unicode Bullets for Org Mode
(use-package org-bullets
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "◉" "⚬" "◈" "◇")))

;; Make use of latest org-mode version
(use-package org
  :hook (org-mode . org-mode-setup)
  :config
  (setq org-ellipsis " ◇"))

(require 'org-indent)
(set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))

; I have to hook so options get added to run-time
(defun org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (org-bullets-mode 1))

(font-lock-add-keywords 'org-mode
			'(("^ *\\([-]\\) "
			   (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

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

(add-hook 'org-mode-hook 'variable-pitch-mode)

(provide 'orgconf)

;;; orgconf.el ends here
