;;; package --- Summary
;;; Commentary: Personal emacs bindings and configs.

;;; Code:
;; Initialize package sources
;; Straight
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; GUI settings
(setq custom-file (locate-user-emacs-file "~/.emacs.d/custom.el"))
(load custom-file :no-error-if-file-is-missing)

;; Mute warnings

(add-to-list 'display-buffer-alist
             '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
               (display-buffer-no-window)
               (allow-no-window . t)))

;; Initialize quality of life settings
(load-file "~/.emacs.d/qol.el")

;; Plugins
(load-file "~/.emacs.d/plugins.el")

;; Loads config for org-mode
(load-file "~/.emacs.d/orgconf.el")

;; Themes
(load-file "~/.emacs.d/theme.el")

;; EOF
(provide 'init.el)

;;; init.el ends here
