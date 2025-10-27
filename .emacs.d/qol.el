
;;; Code:

;; Fullscreen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Shell Env
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(global-display-line-numbers-mode 1)
(save-place-mode)
(global-hl-line-mode t)
(show-paren-mode t)
(delete-selection-mode t)

(defalias 'yes-or-no-p 'y-or-n-p)

(provide 'qol)
;;; qol.el ends here
