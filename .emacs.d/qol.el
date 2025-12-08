
;;; Code:

;;; Description: Quality of life options

;; Fonts:
(set-face-attribute 'default nil :font "Fira Code" :height 165)

;; Set font "Fira Code" :height 165)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Droid Sans" :height 165 :weight 'regular)

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
(electric-pair-mode t)
(setq backup-directory-alist `(("." . "~/.cache/saves")))

;; Auto indents code that was yanked.
(dolist (command '(yank yank-pop))
   (eval `(defadvice ,command (after indent-region activate)
            (and (not current-prefix-arg)
                 (member major-mode '(emacs-lisp-mode lisp-mode
                                                      clojure-mode    scheme-mode    markdown-mode
                                                      haskell-mode    ruby-mode
                                                      rspec-mode      python-mode
                                                      c-mode          c++-mode
                                                      objc-mode       latex-mode
                                                      plain-tex-mode))
                 (let ((mark-even-if-inactive transient-mark-mode))
                   (indent-region (region-beginning) (region-end) nil))))))

;; Taken from Prot
(defun prot/keyboard-quit-dwim ()
  "Do-What-I-Mean behaviour for a general `keyboard-quit'.

The generic `keyboard-quit' does not do the expected thing when
the minibuffer is open.  Whereas we want it to close the
minibuffer, even without explicitly focusing it.

The DWIM behaviour of this command is as follows:

- When the region is active, disable it.
- When a minibuffer is open, but not focused, close the minibuffer.
- When the Completions buffer is selected, close it.
- In every other case use the regular `keyboard-quit'."
  (interactive)
  (cond
   ((region-active-p)
    (keyboard-quit))
   ((derived-mode-p 'completion-list-mode)
    (delete-completion-window))
   ((> (minibuffer-depth) 0)
    (abort-recursive-edit))
   (t
    (keyboard-quit))))

(define-key global-map (kbd "C-g") #'prot/keyboard-quit-dwim)


; Disables lines in several modes
(dolist (mode '(org-mode-hook
		term-mode-hook
                shell-mode-hook
                eshell-mode-hook
		dired-mode-hook
		markdown-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(defalias 'yes-or-no-p 'y-or-n-p) ; Cuts down the alias to y or n

;; Program Overwrites
(setq grep-command "rg -nS --no-heading "
      grep-use-null-device nil)

;; Custom Key Bindings
(global-set-key (kbd "<escape>") #'prot/keyboard-quit-dwi)

(defconst *is-a-mac* (eq system-type 'darwin)) ;; Detecting OS to make keybinding checks.
(defconst *is-a-linux* (eq system-type 'gnu/linux))

(when *is-a-mac*
  (setq mac-command-modifier 'control)) ;; Using Command as CTRL

(define-key global-map (kbd "RET") 'newline-and-indent)

(provide 'qol)
;;; qol.el ends here
