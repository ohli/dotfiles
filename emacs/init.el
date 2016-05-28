;;; init.el --- initalize emacs
;;; Commentary:
;;; Code:


(require 'package)
(add-to-list 'package-archives
	       '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))

(setq use-package-always-ensure t)

(require 'cl)
(require 'diminish)
(require 'bind-key)

(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

(use-package monokai-theme
  :config
  (progn
    (load-theme 'monokai t)
    (custom-set-faces '(org-level-1 ((t (:inherit outline-1 :height 1.0))))
                      '(org-level-2 ((t (:inherit outline-2 :height 1.0))))
                      '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
                      '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
                      '(org-level-5 ((t (:inherit outline-5 :height 1.0)))))))

(use-package powerline :config (powerline-default-theme))
(use-package blink-cursor :ensure f :config (blink-cursor-mode -1))
(use-package size-indication :ensure f :config (size-indication-mode t))

(setq frame-title-format
      '("" invocation-name " - " (:eval (if (buffer-file-name)
                                            (abbreviate-file-name (buffer-file-name))
                                          "%b"))))

(add-to-list 'default-frame-alist '(font . "Meslo LG S for Powerline-8"))
(set-face-attribute 'default t :font "Meslo LG S for Powerline-8")

(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

(defalias 'yes-or-no-p 'y-or-n-p)
(defalias 'eb 'eval-buffer)
(defalias 'er 'eval-region)
(defalias 'ed 'eval-defun)

(use-package workgroups2
  :diminish workgroups-mode
  :config
  (progn
    (workgroups-mode 1)))

;;
;; EDITING
;;

(setq global-mark-ring-max 5000
      mark-ring-max 5000
      mode-require-final-newline t)

;; default to 4 visible spaces to display a tab
(setq-default tab-width 4)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

(setq-default indent-tabs-mode nil)
(delete-selection-mode)

(global-set-key (kbd "RET") 'newline-and-indent)


(setq kill-ring-max 5000
      kill-whole-line t)

(add-hook 'diff-mode-hook (lambda ()
			    (setq-local whitespace-style
					'(face
					  tabs
					  tab-mark
					  spaces
					  space-mark
					  trailing
					  indentation::space
					  indentation::tab
					  newline
					  newline-mark))
			    (whitespace-mode 1)))

;;
;; CONVENIENCE
;;

(global-auto-revert-mode)

; (windmove-default-keybindings)

(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

;; TODO: fix keybindings
(global-set-key (kbd "C-x <left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-x <right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-x <down>") 'shrink-window)
(global-set-key (kbd "C-x <up>") 'enlarge-window)

;;
;; FILES
;;

(setq large-file-warning-threshold 100000000)

(defvar backup-directory "~/.emacs.d/backups")
(if (not (file-exists-p backup-directory))
    (make-directory backup-directory t))

(setq make-backup-files t
      backup-directory-alist `((".*" . ,backup-directory))
      backup-by-copying t
      version-control t
      delete-old-versions t
      kept-old-versions 6
      kept-new-versions 9
      auto-save-default t
      auto-save-timeout 20
      auto-save-interval 200)

;;
;; COMMUNICATION
;;

(add-hook 'prog-mode-hook 'goto-address-mode)
(add-hook 'text-mode-hook 'goto-address-mode)

;;
;; PROGRAMMING
;;

(setq c-default-style "k&r"
      c-basic-offset 4
      gdb-many-windows t
      gdb-show-main t)

(use-package compile
  :bind ("<f5>" . compile)
  :config
  (setq compilation-ask-about-save nil
        compilation-always-kill t
        compilation-scroll-output 'first-error))

;;
;; MAKEFILES
;;

(defun prelude-makefile-mode-defaults ()
  (whitespace-toggle-options '(tabs))
  (setq indent-tabs-mode t))

(setq prelude-makefile-mode-hook 'prelude-makefile-mode-defaults)
(add-hook 'makefile-mode-hook (lambda ()
                                (run-hooks 'prelude-makefile-mode-hook)))

;;
;; DIFF
;;

(setq ediff-diff-options "-w"
      ediff-split-window-function 'split-window-horizontally
      ediff-window-setup-function 'ediff-setup-windows-plain)

(use-package diff-hl
  :config
  (global-diff-hl-mode)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode))

;;
;; SEMANTIC MODE
;;

(use-package semantic
  :config (semantic-mode 1))

;;
;; DEVELOPMENT
;;

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(setq gc-cons-threshold 100000000)

;;
;; ENVIRONMENT
;;

(use-package savehist
  :config
  (setq savehist-additional-variables '(search ring regexp-search-ring)
        savehist-autosave-interval 60))

;;
;; WINNER MODE
;;

(use-package winner
  :disabled t
  :config (winner-mode 1))

;;
;; COLUMN NUMBER MODE
;;

(use-package column-number
  :ensure f
  :config (column-number-mode 1))

;;
;; SAVEPLACE
;;

(use-package saveplace
  :config
  (setq-default save-place t))

;;
;; DIRED
;;

(use-package dired
  :ensure f
  :commands dired
  :init
  (setq dired-dwim-target t
        dired-recursive-copies 'always
        dired-recursive-deletes 'top
        dired-listing-switches "-lha")
  :config
  (add-hook 'dired-mode-hook 'auto-revert-mode)

  (use-package dired+))

;;
;; RECENTF
;;

(use-package recentf
  :init
  (recentf-mode 1)
  :config
  (setq
   recentf-max-saved-items 1000
   recentf-exclude '("/tmp/" "/ssh:"))
  (use-package recentf-ext))

;;
;; DUPLICATE THING
;;

(use-package duplicate-thing
  :bind ("M-c" . duplicate-thing))

;;
;; VOLATILE HIGHLIGHTS
;;

(use-package volatile-highlights
  :config (volatile-highlights-mode t))

;;
;; HIGHLIGHT NUMBERS
;;

(use-package highlight-numbers
  :config (add-hook 'prog-mode-hook 'highlight-numbers-mode))

;;
;; HIGHLIGHT SYMBOL
;;

(use-package highlight-symbol
  :bind (("M-n" . highlight-symbol-next)
         ("M-p" . highlight-symbol-prev))
  :config
  (progn
    (highlight-symbol-nav-mode)

    (add-hook 'prog-mode-hook (lambda () (highlight-symbol-mode)))
    (add-hook 'org-mode-hook (lambda () (highlight-symbol-mode)))

    (setq highlight-symbol-idle-delay 0.2
          highlight-symbol-on-navigation-p t)

    (global-set-key [(control shift mouse-1)]
                    (lambda (event)
                      (interactive "e")
                      (goto-char (posn-point (event-start event)))
                      (highlight-symbol-at-point)))))
;;
;; SMARTPARENS
;;

(use-package smartparens
  :config
  (progn
    (require 'smartparens-config)
    (setq sp-base-key-bindings 'paredit)
    (setq sp-autoskip-closing-pair 'always)
    (setq sp-hybrid-kill-entire-symbol nil)
    (sp-use-paredit-bindings)))

;;
;; CLEAN AINDENT MODE
;;

(use-package clean-aindent-mode
  :config
  (add-hook 'prog-mode-hook 'clean-aindent-mode))

;;
;; UNDO TREE
;;

(use-package undo-tree
  :diminish undo-tree-mode
  :init (global-undo-tree-mode))

;;
;; YASNIPPED
;;

(use-package yasnippet
  :diminish yas-minor-mode
  :config
  (progn
    (require 'yasnippet)
    (yas-global-mode 1)))

;;
;; HIPPIE-EXPAND
;;

(use-package hippie-expand
  :ensure f
  :bind ("M-/" . hippie-expand)
  :init
  (setq hippie-expand-try-functions-list
        '(try-expand-dabbrev
          try-expand-dabbrev-all-buffers
          try-expand-dabbrev-from-kill
          try-complete-file-name-partially
          try-complete-file-name
          try-expand-all-abbrevs
          try-expand-list
          try-expand-line
          try-complete-lisp-symbol-partially
          try-complete-lisp-symbol)))

;;
;; COMANY MODE
;;

(use-package company
  :diminish company-mode
  :init (global-company-mode 1)
  :config
  (progn
    (setq company-backends (delete 'company-semantic company-backends))
    ; (define-key c-mode-map  [(tab)] 'company-complete)
    ; (define-key c++-mode-map  [(tab)] 'company-complete))
  )
  (use-package company-c-headers
    :config
    (add-to-list 'company-backends 'company-c-headers))


  )

;;
;; EXPAND REGION
;;

(use-package expand-region
  :bind ("M-m" . er/expand-region))

;;
;; PROJECTILE
;;

(use-package projectile
  :diminish projectile-mode
  :commands projectile-global-mode
  :bind-keymap ("C-c p" . projectile-command-map)
  :defer 5
  :config
  (progn
    (use-package helm-projectile
      :config
      (helm-projectile-on)

      (setq projectile-completion-system 'helm)
      ; (setq projectile-indexing-method 'alien)

      (setq projectile-switch-project-action 'helm-projectile)

      )

    (projectile-global-mode)))

(use-package helm-config
  :ensure helm
  :demand t
  :bind (("C-x C-f" . helm-find-files)
         ("C-c h o" . helm-occur)
         ("C-c h m" . helm-man-woman)
         ("C-c h i" . helm-semantic-or-imenu)
         ("C-c h l" . helm-locate)
         ("C-c h x" . helm-register)
         ("C-c h a" . helm-apropos)
         ("C-c h r" . helm-regexp)
         ("C-c h g" . helm-google-suggest)
         ("C-c h t" . helm-top)
         ("C-c h /" . helm-find)
         ("C-h SPC" . helm-all-mark-rings)
         ("C-x b" . helm-mini)
         ("M-x" . helm-M-x)
         ("M-y" . helm-show-kill-ring))
  :config

  ;; change helm command prefix to "C-c h"
  (global-set-key (kbd "C-c h") 'helm-command-prefix)
  (global-unset-key (kbd "C-x c"))

  (use-package helm
    :diminish helm-mode)

  (use-package helm-ag)
  
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z") 'helm-select-action)

  (helm-autoresize-mode 1)

  ;; use curl for helm google suggest
  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))

  ;; settings
  (setq helm-split-window-in-side-p t)
  (setq helm-move-to-line-cycle-in-source t)
  (setq helm-ff-search-library-in-sexp t)
  (setq helm-scroll-amount 8)
  (setq helm-ff-file-name-history-use-recentf t)

  ;; fuzzy matching
  (setq helm-completion-in-region-fuzzy-match t)
  (setq helm-mode-fuzzy-match t)

  ;; live grep
  (when (executable-find "ack-grep")
    (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f")
    (setq helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))

  ;; helm man
  (add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)

  (use-package helm-descbinds
    :config
    (helm-descbinds-mode))

  (use-package helm-gtags
    :diminish helm-gtags-mode
    :bind (:map helm-gtags-mode-map
                ("C-c g a" . helm-gtags-tags-in-this-function)
                ("C-c g s" . helm-gtags-find-symbol)
                ("C-c g r" . helm-gtags-find-rtag)
                ("C-j" . helm-gtags-select)
                ("M-." . helm-gtags-dwim)
                ("M-," . helm-gtags-pop-stack)
                ("C-c <" . helm-gtags-previous-history)
                ("C-c >" . helm-gtags-next-history))
    :config
    (progn
      (setq helm-gtags-ignore-case t
            helm-gtags-auto-update t
            helm-gtags-use-input-at-cursor t
            helm-gtags-pulse-at-cursor t
            helm-gtags-prefix-key "\C-cg"
            helm-gtags-suggested-key-mapping t))))

(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'java-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;;
;; MAGIT
;;

(use-package magit
  :bind (("C-x g h" . magit-log-all)
         ("C-x g b" . magit-blame-mode)
         ("C-x g m" . magit-branch-popup)
         ("C-x g c" . magit-branch-and-checkout)
         ("C-x g s" . magit-status)
         ("C-x g r" . magit-reflog)
         ("C-x g t" . magit-tag-popup))
  :config
  (progn
    (set-default 'magit-stage-all-confirm nil)
    (add-hook 'magit-mode-hook 'magit-load-config-extensions)

    (defadvice magit-status (around magit-fullscreen activate)
      (window-configuration-to-register :magit-fullscreen)
      ad-do-it
        (delete-other-windows))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   (quote
    ((company-clang-arguments "/home/nico.wagner/code/pace/")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit outline-1 :height 1.0))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.0))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.0)))))
