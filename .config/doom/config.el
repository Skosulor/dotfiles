;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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



(setq lsp-lens-enable nil)

;; (after! ccls
;;   (setq ccls-initialization-options '(:index (:comments 2) :completion (:detailedLabel t)))
;;   (set-lsp-priority! 'ccls 2)) ; optional as ccls is the default in Doom


(defun ocp ()
  (interactive)
  (lsp-ui-sideline-toggle-symbols-info)
  (lsp-treemacs-symbols)
  (evil-window-left 1)
  ;; (evil-window-right 1)
  (treemacs)
  (evil-window-right 1))

;; Fix the most common misstake among c-programmers
(defun c-end-expression ()
  (interactive)
  (evil-normal-state)
  (evil-append-line 1)
  (insert ";")
  (evil-normal-state))

;; Toggle between two themes
(defun toggle-theme ()
  (interactive)
  (if (string-equal doom-theme "doom-one")
      (load-theme 'doom-gruvbox-light t)
    (load-theme 'doom-one t)))


;; set scope of evil snipe
(setq evil-snipe-scope 'visible)

;; auto update pdf's
(add-hook 'doc-view-mode-hook 'auto-revert-mode)

;; (setq python-indent 4)
(add-hook 'python-mode-hook
  (lambda ()
    (setq-default indent-tabs-mode t)
    (setq-default tab-width 4)
    (setq-default py-indent-tabs-mode t)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace)))

;; Opacity
(set-frame-parameter (selected-frame) 'alpha '(100 100))
(add-to-list 'default-frame-alist '(alpha 100 100))

;; ;; Tabs
;; (setq centaur-tabs-height 30)
;; (setq centaur-tabs-set-icons t)
;; (setq centaur-tabs-gray-out-icons 'buffer)
;; (setq centaur-tabs-set-bar 'under)
;; (setq x-underline-at-descent-line t)

;; Fonts

(setq doom-font (font-spec :family "Iosevka" :size 13))
(setq doom-font (font-spec :family "Iosevka" :size 13))
(setq doom-variable-pitch-font (font-spec :family "Iosevka" :size 13))
(setq doom-font (font-spec :family "Iosevka" :size 13))
(setq doom-variable-pitch-font (font-spec :family "Iosevka" :size 13))


;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
;; (setq highlight-indent-guides-method 'character)

(setq neo-window-width 18)
(setq neo-window-fixed-size nil)

(setq lsp-treemacs-sync-mode 1)
(setq lsp-treemacs-symbols-position-params '((side . right) (slot . 2) (window-width . 35)))
(setq treemacs-space-between-root-nodes nil)
;; (setq lsp-ui-sideline-show-symbol 't)


;; (define-globalized-minor-mode my-global-winum-mode winum-mode
;;   (lambda () (winum-mode 1)))
;; (my-global-winum-mode 1)


(setq doom-modeline-height 20)
(setq straight-allow-recipe-inheritance nil)
;; Load .el files
(load! "bindings")


(setq hl-todo-mode 't)

(setq dired-listing-switches
      "-alhX --group-directories-first")

(require 'company)
(setq company-idle-delay 0.2
      company-minimum-prefix-length 2)

(setq display-line-numbers-type 'relative
              display-line-numbers-current-absolute t)


(map! :leader
      (:prefix ("p" . "project")
      :desc "project tools" "P" 'ocp))


(setq hl-todo-keyword-faces
      '(("TODO" warning bold)
        ("FIXME" error bold)
        ("HACK" font-lock-constant-face bold)
        ("MAYBE" success bold)
        ("REVIEW" . (:foreground "pink" :weight bold))
        ("NOTE" font-lock-keyword-face bold)
        ("DEPRECATED" font-lock-doc-face bold)
        ("OBS" . (:foreground "red" :weight bold))))

(yas-global-mode 1)
(add-hook 'yas-minor-mode-hook (lambda ()
                                 (yas-activate-extra-mode 'fundamental-mode)))


(set 'haskell-interactive-popup-errors nil)

(eval-after-load "flyspell"
  '(defun flyspell-mode (&optional arg)))



;;;;;;;;;;;;;;
;; ORG MODE ;;
;;;;;;;;;;;;;;

(setq deft-directory "~/org"
      deft-extensions '("org")
      deft-recursive t)

;; (unpin! org-mode)

(after! org (setq org-hide-emphasis-markers t))

(after! org (setq org-insert-heading-respect-content nil))

(after! org
  (setq org-log-done t)
  (setq org-log-into-drawer t))

(after! org
  (setq org-special-ctrl-a/e t)
  (setq org-special-ctrl-k t))

;;Enable Speed Keys, which allows quick single-key commands when the cursor is placed on a heading. Usually the cursor needs to be at the beginning of a headline line, but defining it with this function makes them active on any of the asterisks at the beginning of the line.

(after! org
  (setq org-use-speed-commands
        (lambda ()
          (and (looking-at org-outline-regexp)
               (looking-back "^\**")))))

(add-hook! org-mode (electric-indent-local-mode -1))

;; Turn of completion for org mode
(defun zz/adjust-org-company-backends ()
  (remove-hook 'after-change-major-mode-hook '+company-init-backends-h)
  (setq-local company-backends nil))
(add-hook! org-mode (zz/adjust-org-company-backends))

(add-hook! org-mode :append
           #'visual-line-mode
           #'variable-pitch-mode)



(add-hook! org-mode :append #'org-appear-mode)

(setq org-indent-indentation-per-level 1)
(setq org-indent-boundary-char ? )

(setq org-ellipsis " ▼")

(after! org-superstar
  ;; Every non-TODO headline now have no bullet
  (setq org-superstar-headline-bullets-list '(" "))
  (setq org-superstar-leading-bullet ? )
  ;; Enable custom bullets for TODO items
  (setq org-superstar-special-todo-items t)
  (setq org-superstar-todo-bullet-alist
        '(("TODO" "☐ ")
          ("NEXT" "✒ ")
          ("PROG" "✰ ")
          ("WAIT" "☕ ")
          ("FAIL" "✘ ")
          ("DONE" "✔ ")))
  (org-superstar-restart))

(add-hook! 'org-mode-hook #'doom-disable-line-numbers-h)

(custom-set-faces
 '( org-level-1 ((t (:height 1.4))) )
 '( org-level-2 ((t (:height 1.3))) )
 '( org-level-3 ((t (:height 1.2))) )
 '( org-level-4 ((t (:height 1.1))) )
 )

;; set default shell for vterm
(setq vterm-shell "/opt/homebrew/bin/fish")

;; (set-face-attribute 'org-level-1 :height "1.4")
;; (set-face-attribute 'org-level-2 :height "1.3")
;; (set-face-attribute 'org-level-3 :height "1.2")
;; (set-face-attribute 'org-level-4 :height "1.1")

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))
