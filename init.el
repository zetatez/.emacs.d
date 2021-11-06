
;-- initial-scratch-message
(setq-default initial-scratch-message
              (concat ";; Happy hacking! \n"))

;-- no startup, no gui
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)

; (setq default-major-mode 'text-mode)
; (setq default-major-mode 'evil-mode)


;-- sources
(setq package-archives '(("gnu" . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/gnu/")
                         ("melpa" . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/melpa/")))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))                    ; for neotree
(setq package-check-signatures nil)                                                          ; do not check signatures


(require 'package)
(unless (bound-and-true-p package--initialized) (package-initialize))
(unless package-archive-contents (package-refresh-contents))
(unless (package-installed-p 'use-package) (package-refresh-contents) (package-install 'use-package))

(require 'use-package)
(require 'use-package-ensure)
(setq use-package-always-ensure t)
(setq use-package-always-defer t)
(use-package auto-package-update
             :config
             (setq auto-package-update-delete-old-versions t)
             (setq auto-package-update-hide-results t)
             (auto-package-update-maybe))

;-- enhance
(use-package restart-emacs
			 :ensure t)
; EXWM (Emacs X Window Manager) is a full-featured tiling X window manager for Emacs built on top of XELB
(use-package exwm
			 :ensure t)
(use-package smex
             :ensure t)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
; (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

; a collection of ridiculously useful extensions for emacs. crux bundles many useful interactive commands to enhance your overall emacs experience.
(use-package crux
			 :ensure t)


;-- basic tools
(use-package neotree
			 :ensure t)
(defun neotree-startup ()
  (interactive)
  (neotree-show)
  (call-interactively 'other-window))

(if (daemonp)
  (add-hook 'server-switch-hook #'neotree-startup)
  (add-hook 'after-init-hook #'neotree-startup)
  )
(global-set-key [f2] 'neotree-toggle)

(use-package magit
			 :ensure t)
(use-package git-gutter
			 :ensure t)
(use-package adaptive-wrap
			 :ensure t
			 ;; as this package is available only in the gnu archive, this is
			 ;; technically not needed, but it helps to highlight where it
			 ;; comes from
			 :pin gnu)
(use-package expand-region
             :bind ("C-=" . er/expand-region))
(use-package popwin
			 :ensure t)
(popwin-mode 1)
(use-package rainbow-mode
			 :ensure t)

; finder
; (use-package helm
; 			 :ensure t)
(use-package ivy
             :ensure t)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

(use-package find-file-in-project
			 :ensure t)

; searcher
(use-package rg
			 :ensure t)
(use-package ace-jump-mode
			 :ensure t)
;-- completion
(use-package auto-complete
			 :ensure t)
(use-package company
			 :ensure t)
(use-package company-tabnine
             :ensure t)
(setq company-idle-delay 0)             ; trigger completion immediately.
(setq company-show-numbers t)           ; number the candidates (use m-1, m-2 etc to select completions).

;-- snip
(use-package yasnippet
             :ensure t)
(yas-global-mode 1)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))

;-- colorscheme
; (use-package gruvbox-theme
; 			 :ensure t
;            :init (load-theme 'gruvbox-dark-soft t))

(use-package smart-mode-line
			 :ensure t)

;-- lang
; go
(use-package go-guru
			 :ensure t)
; python
(use-package elpy
             :ensure t
             :init
             (elpy-enable))
(use-package pipenv
             :hook (python-mode . pipenv-mode)
             :init)


; js
(use-package js2-mode
			 :ensure t)
; web
(use-package web-mode
			 :ensure t)
; emmet
; (use-package emmet
; 			 :ensure t)

; yaml
(use-package yaml-mode
			 :ensure t)
; json
(use-package json-mode
			 :ensure t)

;-- jump
(use-package rtags
			 :ensure t)
; avy is a emacs package for jumping to visible text using a char-based decision tree
(use-package avy
			 :ensure t)
(global-set-key (kbd "C-:") 'avy-goto-char)

;-- Syntax Check
(use-package flycheck
			 :ensure t)
(use-package flyspell
			 :ensure t)

;-- debug
(use-package realgud
			 :ensure t)


;-- vim for emacs
(use-package evil
			 :ensure t)
(use-package evil-surround
             :ensure t
             :config
             (global-evil-surround-mode 1))
(use-package evil-leader
			 :ensure t)
(use-package evil-matchit
			 :ensure t)
(use-package evil-nerd-commenter
			 :ensure t)

;-- manually: plugins
(require 'quickrun)
(quickrun-set-default "c" "c/clang")

(require 'undo-tree)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(license-snippets yaml-mode web-mode use-package undo-tree smex smart-mode-line selectric-mode scala-mode rtags rg restart-emacs realgud rainbow-mode quickrun popwin pipenv neotree multiple-cursors meghanada magit json-mode js2-mode ivy ht helm gruvbox-theme go-guru git-gutter find-file-in-project exwm expand-region evil-vimish-fold evil-surround evil-nerd-commenter evil-matchit evil-leader elpy crux company-tabnine color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized avy auto-package-update auto-complete auctex adaptive-wrap ace-jump-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
