
;;; Code:

;; Make use of latest org-mode version
(use-package org
  :hook (org-mode . org-mode-setup)
  :config
  (setq org-ellipsis " ◇"
	org-hide-emphasis-markers t))

;; Unicode Bullets for Org Mode
(use-package org-bullets)

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

(provide 'orgconf)

;;; orgconf.el ends here
