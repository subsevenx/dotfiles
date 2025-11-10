
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

(provide 'qol)
;;; qol.el ends here
