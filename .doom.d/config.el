;;; .doom.d/config.el -*- lexical-binding: t; -*-

;;(setq display-battery-mode t)
;;(setq display-time-mode 1)

;;(setq (unless (string-match-p "^Power N/A" (battery))
;;  (display-battery-mode 1)))


(defun get-syn (&optional b e)
  (interactive)
  (shell-command (concat "syn " (thing-at-point 'word))))

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


(define-globalized-minor-mode my-global-winum-mode winum-mode
  (lambda () (winum-mode 1)))
(my-global-winum-mode 1)


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

(unpin! org-mode)

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

(setq org-indent-indentation-per-level 6)
(setq org-indent-boundary-char ?　)

(setq org-ellipsis " ▼")

(after! org-superstar
  ;; Every non-TODO headline now have no bullet
  (setq org-superstar-headline-bullets-list '("　"))
  (setq org-superstar-leading-bullet ?　)
  ;; Enable custom bullets for TODO items
  (setq org-superstar-special-todo-items t)
  (setq org-superstar-todo-bullet-alist
        '(("TODO" "☐　")
          ("NEXT" "✒　")
          ("PROG" "✰　")
          ("WAIT" "☕　")
          ("FAIL" "✘　")
          ("DONE" "✔　")))
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
