;;; Startup
;;; PACKAGE LIST
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("elpa" . "https://elpa.gnu.org/packages/")))

;;; BOOTSTRAP USE-PACKAGE
(package-initialize)
(setq use-package-always-ensure t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;;; GENERAL SETUP
;;; Remove all the extra visual elements
(menu-bar-mode -1)
(scroll-bar-mode -1) 
(tool-bar-mode -1) 

;;; Get rid of the startup screen
(setq inhibit-startup-message t) 

;;; Turn off the sound when hitting buffer's beginning or end
(setq ring-bell-function 'ignore)

;;; Make it open full screen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;; Remove frame decorations
(add-to-list 'default-frame-alist '(undecorated . t))

;;; THEME
(use-package catppuccin-theme)
(load-theme 'catppuccin :no-confirm)
(setq catppuccin-flavor 'mocha) ;; or 'latte, 'macchiato, or 'mocha
(catppuccin-reload)

;;; FONT
(add-to-list 'default-frame-alist '(font . "SauceCodePro Nerd Font"))

;;; UNDO
;; Vim style undo not needed for emacs 28
(use-package undo-fu)

;;; Vim Bindings
(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  ;; allows for using cgn
  ;; (setq evil-search-module 'evil-search)
  (setq evil-want-keybinding nil)
  ;; no vim insert bindings
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode 1))

;;; Vim Bindings Everywhere else
(use-package evil-collection
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(evil-collection treemacs treemacs-evil treemacs-icons-dired
		     treemacs-magit treemacs-persp treemacs-projectile
		     treemacs-tab-bar undo-fu)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Treat _ as part of the word when navigating in vim
;; https://emacs.stackexchange.com/a/20717/36755
(with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol)
    ;; make evil-search-word look for symbol rather than word boundaries
    (setq-default evil-symbol-word-search t))

;;; REMAP SOME KEYBINDINGS
;; Unbind C-h from help (optional, if you want to override it)
(global-set-key (kbd "C-h") nil)

;; Use windmove with Ctrl-h/j/k/l in Evil normal mode
(define-key evil-normal-state-map (kbd "C-h") 'windmove-left)
(define-key evil-normal-state-map (kbd "C-l") 'windmove-right)
(define-key evil-normal-state-map (kbd "C-j") 'windmove-down)
(define-key evil-normal-state-map (kbd "C-k") 'windmove-up)


;;; --------------------------
;;;          PACKAGES
;;; --------------------------

;;; TREEMACS
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    (treemacs-resize-icons 16)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
  :after (treemacs)
  :ensure t
  :config (treemacs-set-scope-type 'Tabs))

(treemacs-start-on-boot)

(with-eval-after-load 'treemacs
  (define-key treemacs-mode-map (kbd "C-h") 'windmove-left)
  (define-key treemacs-mode-map (kbd "C-l") 'windmove-right)
  (define-key treemacs-mode-map (kbd "C-j") 'windmove-down)
  (define-key treemacs-mode-map (kbd "C-k") 'windmove-up))
