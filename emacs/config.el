;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Disable the deletion of trailing whitespaces on save
(ws-butler-mode -1)

;; Autosave
(setq auto-save-visited-interval 0.1) ;; in seconds
(auto-save-visited-mode t)

;; Enable whitespaces
;; (setq whitespace-space-regexp "\\(^ +\\|  +\\| +$\\)") ; visualize only leading and/or trailing SPACEs.
;; (setq whitespace-space-regexp "\\(?<=\\S\\)\\s\\(?=\\S\\)") ; visualize only leading and/or trailing SPACEs.
(setq whitespace-style '(face spaces space-mark))

;; (setq space-face (make-face 'space-face))
;; (set-face-foreground 'space-face "#282c34")
;; (set-face-background 'space-face "#282c34")
;; (setq whitespace-space 'space-face)

;; (setq space-face-leading (make-face 'space-face-leading))
;; (set-face-foreground 'space-face-leading "red")
;; (setq whitespace-indentation 'space-face-leading)
       ;; (set-face-foreground 'space-face (face-attribute 'default :background))

(global-whitespace-mode 1)

;; (set-face-attribute 'whitespace-space nil
;;     :background "#282c34"
;;     :foreground "#282c34")

;; (setq
;;   whitespace-style '(face tabs tab-mark spaces space-mark trailing lines-tail)
;;   whitespace-display-mappings '(
;;     (space-mark   ?\     [?\u00B7]     [?.])
;;     (space-mark   ?\xA0  [?\u00A4]     [?_])
;;     (tab-mark     ?\t    [?\u00BB ?\t] [?\\ ?\t])))

;; Centered cursor mode
;; https://emacs.stackexchange.com/a/3685/36755
(global-centered-cursor-mode 1)

;; RETURN will follow links in org-mode files
(setq org-return-follows-link  t)

;; Tree sitter global mode for all supported languages
(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

;; Remove the hook to avoid https://github.com/doomemacs/doomemacs/issues/6041
(remove-hook 'doom-first-input-hook #'evil-snipe-override-mode)

;; Treat _ as part of the word when navigating in vim
;; https://emacs.stackexchange.com/a/20717/36755
(with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol)
    ;; make evil-search-word look for symbol rather than word boundaries
    (setq-default evil-symbol-word-search t))

;; Org-mode
(after! org
        (setq org-roam-directory "~/org/roam/")
        (setq org-roam-index-file "~/org/roam/index.org")
        (setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$"))
        (setq org-agenda-span 10
                org-agenda-start-on-weekday nil
                org-agenda-start-day "-0d")
        (setq org-agenda-custom-commands
        '(("v" "Agenda view"
                ((tags-todo "PRIORITY={A}"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                (org-agenda-overriding-header "High:")))
                (tags-todo "PRIORITY={B}"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                (org-agenda-overriding-header "Medium:")))
                (tags-todo "PRIORITY={C}"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                (org-agenda-overriding-header "Low:")))
                (agenda "")
                (tags-todo "PRIORITY={D}"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done 'nottodo '("TODO")))
                (org-agenda-overriding-header "No-priority:")))))))

        (setq
        org-fancy-priorities-list '("🟥" "🟧" "🟨" "🟦")
        org-default-priority ?D
        org-lowest-priority ?D))

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;; (setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one-light)
(setq doom-font (font-spec :size 28))
(setq calendar-week-start-day 1)

;; Inline LaTex rendering
(add-hook 'org-mode-hook 'org-fragtog-mode)

;; Inline images display toggle
(setq org-startup-with-inline-images t)

;; (after! doom-theme
;;         (setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;               doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13)))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-default-notes-file (concat org-directory "/notes.org"))

(after! org
    ;; Set bold and italic markers off in org mode
    (setq org-hide-emphasis-markers t)

    ;; Make LaTex inline formulas larger
    (plist-put org-format-latex-options :scale 3.0)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
