;;; --------------------
;;; PACKAGE INSTALLATION
;;; --------------------

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

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;;; -------------
;;; GENERAL SETUP
;;; -------------

;;; Make it open full screen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;; Remove frame decorations
(add-to-list 'default-frame-alist '(undecorated . t))

;;; Font
(add-to-list 'default-frame-alist '(font . "Source Code Pro Medium-14"))

;;; Remove all the extra visual elements
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;;; Get rid of the startup screen
(setq inhibit-startup-message t)

;;; Turn off the sound when hitting buffer's beginning or end
(setq ring-bell-function 'ignore)

;;; THEME
(use-package doom-themes
  ; :custom
  ;; Global settings (defaults)
  ; (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
  ; (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; for treemacs users
  :ensure t
  :config
  (load-theme 'doom-one-light t))

;;; UNDO
;; Vim style undo not needed for emacs 28
(use-package undo-fu
  :ensure t)

;;; Vim Bindings
(use-package evil
  :ensure t
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  ;; allows for using cgn
  (setq evil-search-module 'evil-search)
  (setq evil-want-keybinding nil)
  ;; no vim insert bindings
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode 1))

;;; Vim Bindings Everywhere else
(use-package evil-collection
  :ensure t
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))

;; Enable buffer tabs
(global-tab-line-mode 1)

;; Treat _ as part of the word when navigating in vim
;; https://emacs.stackexchange.com/a/20717/36755
(with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol)
    ;; make evil-search-word look for symbol rather than word boundaries
    (setq-default evil-symbol-word-search t))

;; Autosave
(setq auto-save-visited-interval 0.4) ;; in seconds; a lower value results in status bar flickering
(auto-save-visited-mode t)


;; Save sessions
(desktop-save-mode 1)

;; Line numbers in programming modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;;; REMAP SOME KEYBINDINGS
;; Unbind C-h from help (optional, if you want to override it)
(global-set-key (kbd "C-h") nil)

;; Use windmove with Ctrl-h/j/k/l in Evil normal mode
(define-key evil-normal-state-map (kbd "C-h") 'windmove-left)
(define-key evil-normal-state-map (kbd "C-l") 'windmove-right)
(define-key evil-normal-state-map (kbd "C-j") 'windmove-down)
(define-key evil-normal-state-map (kbd "C-k") 'windmove-up)

;; Move between buffers
(define-key evil-normal-state-map (kbd "<right>") 'evil-next-buffer)
(define-key evil-normal-state-map (kbd "<left>") 'evil-prev-buffer)

;; Kill buffer
(define-key evil-normal-state-map (kbd "C-q")
    (lambda ()
    (interactive)
    (kill-buffer (current-buffer))))

;; Resize windows
(global-set-key (kbd "S-<left>")  'shrink-window-horizontally)
(global-set-key (kbd "S-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-<down>")  'enlarge-window)
(global-set-key (kbd "S-<up>")    'shrink-window)

;; keep the cursor centered to avoid sudden scroll jumps
(use-package centered-cursor-mode
  :ensure t
  :config
  ;; Optional, enables centered-cursor-mode in all buffers.
  (global-centered-cursor-mode))


;;; --------------------------
;;;          PACKAGES
;;; --------------------------

;;; Syntax highlighting

;;; Nix
(use-package nix-mode
  :ensure t
  :mode "\\.nix\\'")

;;; Docker
(use-package dockerfile-mode
  :ensure t
  :mode "Dockerfile\\'"
  ;; :config
  ;; (add-hook 'dockerfile-mode 'smartparens-mode)
)

;;; Markdown
(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . gfm-mode)
  ; :init (setq markdown-command "multimarkdown")
)

;;; Tree-sitter
(dolist (mapping
         '((python-mode     . python-ts-mode)
           (tsx-mode        . tsx-ts-mode)
           (json-mode       . json-ts-mode)
           (css-mode        . css-ts-mode)
           (rust-mode       . rust-ts-mode)
           (bash-mode       . bash-ts-mode)
           (cmake-mode      . cmake-ts-mode)
           (yaml-mode       . yaml-ts-mode)
           (toml-mode       . toml-ts-mode)
           (dockerfile-mode . dockerfile-ts-mode)
           (markdown-mode   . markdown-ts-mode)
           (sql-mode        . sql-ts-mode)
           (makefile-mode   . makefile-ts-mode)
           (nix-mode        . nix-ts-mode)))
  (add-to-list 'major-mode-remap-alist mapping))
(setopt treesit-font-lock-level 4)

(global-visual-line-mode t)

(use-package org
  :ensure t
  :config
  (require 'org-tempo)
  (setq org-hide-emphasis-markers t
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 0
        org-startup-folded t
        org-yank-dnd-method 'file-link ; So images can be pasted from clipboard
        org-yank-image-save-method "~/org/images"
        org-archive-location "~/org/archive.org_archive::" ; Another stupid gotcha with the `::` in the end.
        org-image-actual-width nil ; So images can be resized
        org-return-follows-link t  ; Open links on Enter
        org-pretty-entities t)  ; Can insert LaTeX characters with \
  (setq org-todo-keywords
        '((sequence
           "IDEA(i!)" "TODO(t!)" "IN-PROGRESS(p!)" "ON-HOLD(h@/!)"
           "|"
           "DONE(d!)" "CANCELLED(c@/!)")))

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (shell . t)))
  (add-hook 'org-insert-heading-hook
  (lambda()
  (save-excursion
            (org-back-to-heading)
            (org-set-property "CREATED" (format-time-string "[%Y-%m-%d %T]")))))
  :hook
  ((org-mode . org-indent-mode))
  ((org-mode . org-toggle-pretty-entities)))

(use-package evil-org
  :ensure t
  :after (evil org)
  :hook
  (org-mode . evil-org-mode)
  :config
  (require 'evil-org-agenda)
  (evil-org-set-key-theme '(navigation todo insert textobjects additional))
  (evil-org-agenda-set-keys))

(use-package org-appear
  :ensure t
  :after (evil org)
  :custom
  (org-appear-autolinks t)
  :hook
  (org-mode . org-appear-mode))
