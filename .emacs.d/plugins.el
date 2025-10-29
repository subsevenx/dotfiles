;;; Code:

;; Store temp files in a cache
(setq user-emacs-directory "~/.cache/emacs")
(use-package no-littering)
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

;; Doom Bar
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-minor-modes t
	doom-modeline-height 20
	doom-modeline-bar-width 3))

;; Shell Env
(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)))

;; Make M-x and other mini-buffers sortable, filterable
(use-package ivy
  :init
  (ivy-mode 1)
  :config
  (setq ivy-height 15
        ivy-use-virtual-buffers t
        ivy-use-selectable-prompt t))

(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :after ivy
  :init
  (counsel-mode 1)
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map ivy-minibuffer-map
	 ("C-r" . 'counsel-minibuffer-history)))

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

;; EOF
(provide 'plugins.el)
;;; plugins.el ends here
