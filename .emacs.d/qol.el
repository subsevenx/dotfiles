
;;; Code:

;; Quality of life options
(set-face-attribute 'default nil :height 220)

(setq inhibit-startup-message t) ; No startup message

(scroll-bar-mode -1) ; Hide vert. scrollbar
(horizontal-scroll-bar-mode -1) ; Hide horizontal scroll bar
(add-to-list 'default-frame-alist '(fullscreen . maximized)) ; Set to full screen ASAP
(global-display-line-numbers-mode t) ; Show line numbers
(save-place-mode) ; Save cursor place in file exit
(global-hl-line-mode t) ; Highlights current line
(show-paren-mode t) ; Shows the paired parentheses
(delete-selection-mode t) ; Deletes text on paste. AKA: normal editor behaviour

; Disables lines in several modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(defalias 'yes-or-no-p 'y-or-n-p)

(provide 'qol)
;;; qol.el ends here
