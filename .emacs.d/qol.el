
;;; Code:

;;; Description: Quality of life options

;; Fonts:
(set-face-attribute 'default nil :font "Fira Code" :height 180)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Fira Code" :height 180)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Droid Sans" :height 180 :weight 'regular)

(setq inhibit-compacting-font-caches t)

;; GUI
(setq inhibit-startup-message t) ; No startup message
(scroll-bar-mode -1) ; Hide vert. scrollbar
(horizontal-scroll-bar-mode -1) ; Hide horizontal scroll bar
(tool-bar-mode -1) ; Hides the toolbar
(add-to-list 'default-frame-alist '(fullscreen . maximized)) ; Set to full screen ASAP
(set-fringe-mode 10) ; Setting gutters
(global-display-line-numbers-mode t) ; Show line numbers

;; HS Mode Preferences
(setq hs-minor-mode-map
      (let ((map (make-sparse-keymap)))
        ;; These bindings roughly imitate those used by Outline mode.
        (define-key map (kbd "C-c h <") 'hs-hide-block)
        (define-key map (kbd "C-c h >") 'hs-show-block)
        (define-key map (kbd "C-c h M-<") 'hs-hide-all)
        (define-key map (kbd "C-c h M->") 'hs-show-all)
        (define-key map (kbd "C-c h C-l") 'hs-hide-level)
        (define-key map (kbd "C-c h C-c") 'hs-toggle-hiding)
        (define-key map [(shift mouse-2)] 'hs-mouse-toggle-hiding)
        map))

(add-hook 'prog-mode-hook (lambda () (hs-minor-mode t)))

;; Editing
(save-place-mode) ; Save cursor place in file exit
(global-hl-line-mode t) ; Highlights current line
(show-paren-mode t) ; Shows the paired parentheses
(delete-selection-mode t) ; Deletes text on paste. AKA: normal editor behaviour

; Disables lines in several modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(defalias 'yes-or-no-p 'y-or-n-p) ; Cuts down the alias to y or n

;; Custom Key Bindings
(defconst *is-a-mac* (eq system-type 'darwin))

(when *is-a-mac*
  (setq mac-command-modifier 'control))

(provide 'qol)
;;; qol.el ends here
