;;; package --- Summary
;;; Commentary: Personal emacs bindings and configs.

;;; Code:

;; Package manager
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/packages/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(setq
 use-package-always-ensure t
 use-package-verbose t)

;; Initialize quality of life settings
(load-file "~/.emacs.d/qol.el")

;; Themes
(load-file "~/.emacs.d/theme.el")

;; Plugins
(load-file "~/.emacs.d/plugins.el")


;; EOF
(provide 'init.el)

;;; init.el ends here
