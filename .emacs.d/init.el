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
(use-package doom-themes
  :ensure t
  :custom
  ;; Global settings (defaults)
  (Doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
 
  :config
  (load-theme 'doom-challenger-deep t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; Plugins

;; Make M-x and other mini-buffers sortable, filterable
(use-package ivy
  :init
  (ivy-mode 1)
  (setq ivy-height 15
        ivy-use-virtual-buffers t
        ivy-use-selectable-prompt t))

(use-package counsel
  :after ivy
  :init
  (counsel-mode 1)
  :bind (:map ivy-minibuffer-map))

;; Completions

(use-package company
  :bind (("C-." . company-complete))
  :custom
  (company-idle-delay 0)
  (company-dabbrev-downcase nil)
  (company-show-numbers t)
  (company-tooltip-limit 10)
  :config
  (global-company-mode)

    ;; use numbers 0-9 to select company completion candidates
  (let ((map company-active-map))
    (mapc (lambda (x) (define-key map (format "%d" x)
                        `(lambda () (interactive) (company-complete-number ,x))))
          (number-sequence 0 9))))

(use-package flycheck
  :config
  (add-hook 'prog-mode-hook 'flycheck-mode) ;; lint always-on
  (add-hook 'after-init-hook #'global-flycheck-mode))

;; Package for interacting with language servers
(use-package lsp-mode
  :commands lsp
  :config
  (setq lsp-prefer-flymake nil
	lsp-headerline-breadcrumb-mode nil))

(provide '.emacs)

;;; init.el ends here
