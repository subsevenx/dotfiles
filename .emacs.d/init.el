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
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

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
