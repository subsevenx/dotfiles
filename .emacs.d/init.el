;;; package --- Summary
;;; Commentary: Personal emacs bindings and configs.

;;; Code:
;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

  ;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

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


;; Local File
(load-file "~/.emacs.d/personal.el")

(setq personal-file (locate-user-emacs-file("~/.emacs.d/personal.el"))
(load personal-file :no-error-if-file-is-missing)

;; EOF
(provide 'init.el)

;;; init.el ends here
