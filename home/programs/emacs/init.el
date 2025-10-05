;;; --------------------
;;; PACKAGE INSTALLATION
;;; --------------------

;;; Startup
;;; PACKAGE LIST
; (setq package-archives
;       '(("melpa" . "https://melpa.org/packages/")
;         ("elpa" . "https://elpa.gnu.org/packages/")))

;;; BOOTSTRAP USE-PACKAGE
; (package-initialize)
; (setq use-package-always-ensure t)
; (unless (package-installed-p 'use-package)
;   (package-refresh-contents)
;   (package-install 'use-package))
; (eval-when-compile (require 'use-package))

;;; -------------
;;; GENERAL SETUP
;;; -------------

;;; Make it open full screen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;; Remove frame decorations
(add-to-list 'default-frame-alist '(undecorated . t))

;;; Font
(add-to-list 'default-frame-alist '(font . "SauceCodePro NFM SemiBold-12"))

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
  :config
  (load-theme 'doom-one-light t))

(setq whitespace-hspace-regexp "\\(^ +\\| +$\\)")

;;; WHITESPACE HIGHLIGHTING
;; Enable for programming modes
(add-hook 'prog-mode-hook #'whitespace-mode)

(setq whitespace-style
      '(
        face               ;; Enable visualization using faces
        tabs               ;; visualize tab chars
        tab-mark           ;; show a printable tab mark
        spaces             ;; visualize space chars
        space-mark         ;; show a printable space mark
        trailing           ;; visualize trailing whitespace
        ))

;; Use · (MID DOT) for spaces and default → for tabs
(setq whitespace-display-mappings
      '((space-mark ?\ [?·] [?.])))

(with-eval-after-load 'whitespace
  ;; Make leading whitespace chars follow current theme's comment colouring
  ;; Using hspace here is dubious but it seems to work
  (set-face-attribute 'whitespace-hspace nil
                      :foreground (face-foreground 'font-lock-comment-face nil t)
                      :background nil)
  ;; Hide the intermediate whitespaces between words
  (set-face-attribute 'whitespace-space nil
                      :foreground (face-background 'default nil t)
                      :background nil)
  ;; Don't chanege anything about trailing whitespaces, just leave it here for reference
  (set-face-attribute 'whitespace-trailing nil
                      :foreground nil
                      :background nil)
  ;; Make leading tab chars follow current theme's comment colouring
  (set-face-attribute 'whitespace-tab nil
                      :foreground (face-foreground 'font-lock-comment-face nil t)
                      :background nil))

;;; UNDO
;; Vim style undo not needed for emacs 28
(use-package undo-fu)

;;; Vim Bindings
(use-package evil
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
  :config
  ;; Optional, enables centered-cursor-mode in all buffers.
  (global-centered-cursor-mode))

;; disable in terminal modes
;; http://stackoverflow.com/a/6849467/519736
;; also disable in Info mode, because it breaks going back with the backspace key
; (define-global-minor-mode my-global-centered-cursor-mode centered-cursor-mode
;   (lambda ()
;     (when (not (memq major-mode
;                      (list 'Info-mode 'term-mode 'eshell-mode 'shell-mode 'erc-mode)))
;       (centered-cursor-mode))))

; (my-global-centered-cursor-mode 1)

;;; --------------------------
;;;          PACKAGES
;;; --------------------------

;;; Syntax highlighting

;;; Nix
(use-package nix-mode
  :mode "\\.nix\\'")

;;; Docker
(use-package dockerfile-mode
  :mode "Dockerfile\\'"
  ;; :config
  ;; (add-hook 'dockerfile-mode 'smartparens-mode)
)

;;; Markdown
(use-package markdown-mode
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

;;; Eat terminal emulator
(use-package eat
  :custom
  (eat-kill-buffer-on-exit t)
  ; :hook ((eshell-load . eat-eshell-mode))
)
; (setenv "TERM" "xterm256-color") ;; needed by eat on MacOS

(global-visual-line-mode t)
(setq org-archive-location "")
