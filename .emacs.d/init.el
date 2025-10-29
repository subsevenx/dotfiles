;;; package --- Summary
;;; Commentary: Personal emacs bindings and configs.

;;; Code:

;; Vars
(defvar dan/default-font-size 180)
(defvar dan/default-variable-font-size 180)

;; Package manager
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
	("melpa-stable" . "https://stable.melpa.org/packages/")
	("org" . "https://orgmode.org/elpa/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(setq
 use-package-always-ensure t
 use-package-verbose t)

;; GUI settings
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;; Loads config for org-mode
(load-file "~/.emacs.d/orgconf.el")

;; Plugins
(load-file "~/.emacs.d/plugins.el")

;; Initialize quality of life settings
(load-file "~/.emacs.d/qol.el")

;; Themes
(load-file "~/.emacs.d/theme.el")

;; Load MacOS-specific config
(load-file "~/.emacs.d/mac.el")

;; EOF
(provide 'init.el)

;;; init.el ends here
