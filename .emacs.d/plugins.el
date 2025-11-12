;;; -*- lexical-binding: t -*-

;;; package --- Summary
;;; Commentary:
;;; Provides package configuration

;;; Code:

;; Store temp files in a cache
(setq user-emacs-directory "~/.cache/emacs")

(use-package no-littering)

(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00")
  (setq
   use-package-always-ensure t
   use-package-verbose t))

;; HS Mode Preferences
(use-package hideshow
  :ensure nil
  :init
  (setq hs-minor-mode-map
        (let ((map (make-sparse-keymap)))
          (define-key map (kbd "C-c f <") #'hs-hide-block)
          (define-key map (kbd "C-c f >") #'hs-show-block)
          (define-key map (kbd "C-c f C-<") #'hs-hide-all)
          (define-key map (kbd "C-c f C->") #'hs-show-all)
          (define-key map (kbd "C-c f M->") #'hs-hide-level)
          (define-key map (kbd "C-c f M-<") #'hs-toggle-hiding)
          map))
  :hook (prog-mode . hs-minor-mode))

;; Doom Bar
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-minor-modes t
	doom-modeline-height 20
	doom-modeline-bar-width 3))

;; Which Key
(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

;; Shell Env
(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

;; Minibuffer enhancements
(use-package marginalia
  :ensure t
  :custom
  (marginalia-max-relative-age 0)
  (marginalia-align 'right)
  :hook (after-init . marginalia-mode))

;; Minibuffer completions
(use-package vertico
  :ensure t
  :custom
  (vertico-count 15)
  (vertico-resize t)
  :hook (after-init . vertico-mode))

;; Completion style
(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil)
  :custom
  (orderless-matching-styles
   '(orderless-literal
     orderless-prefixes
     orderless-initialism
     orderless-regexp)))

;; Package for interacting with language servers
(use-package lsp-mode
  :commands lsp
  :config
  (setq lsp-prefer-flymake nil
	lsp-headerline-breadcrumb-mode nil))

;; Completion suggestions
(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
              ("<tab>" . company-complete-selection))
  (:map lsp-mode-map
        ("<tab>" . company-indent-or-complete-common))
  (("C-." . company-complete))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0)
  (company-dabbrev-downcase nil)
  (company-show-numbers t)
  (company-tooltip-limit 10)
  :config
  ;; use numbers 0-9 to select company completion candidates
  (let ((map company-active-map))
    (mapc (lambda (x) (define-key map (format "%d" x)
				  `(lambda () (interactive) (company-complete-number ,x))))
          (number-sequence 0 9))))

;;company front-end and icons
(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package flycheck
  :config
  (add-hook 'prog-mode-hook 'flycheck-mode) ;; lint always-on
  (add-hook 'after-init-hook #'global-flycheck-mode))

;; Better help menus
(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; Better Spellcheck
(use-package jinx
  :hook ((org-mode markdown-mode text-mode gfm-mode rst-mode latex-mode
                   message-mode mu4e-compose-mode mail-mode TeX-mode)
         . jinx-mode)
  :bind (("C-+" . jinx-correct)
         ("C-M-+" . jinx-languages)))

;; Projectile
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode t)
  :custom ((projectile-completion-system 'default))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Development/")
    (setq projectile-project-search-path '("~/Development/")))
  (setq projectile-switch-project-action #'projectile-dired))

;; All the Icons
(when (display-graphic-p)
  (use-package all-the-icons))

(use-package all-the-icons-completion
  :after (marginalia all-the-icons)
  :hook (marginalia-mode . all-the-icons-completion-marginalia-setup)
  :init
  (all-the-icons-completion-mode))

(use-package nerd-icons
  :ensure t)

(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

;; EOF
(provide 'plugins.el)
;;; plugins.el ends here
