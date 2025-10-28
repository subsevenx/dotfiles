
;;; Code:
(setq org-hide-emphasis-markers t)

(font-lock-add-keywords 'org-mode
			'(("^ *\\([-]\\) "
			   (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(provide 'org)

;;; org.el ends here
