;;; Code:
(use-package doom-themes
  :ensure t
  :custom
  ;; Global settings (defaults)
  (Doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
 
  :config
  (load-theme 'doom-snazzy t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(provide 'theme)

;;; theme.el ends here
