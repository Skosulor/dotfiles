;;; .doom.d/config.el -*- lexical-binding: t; -*-


;; custom functions ----

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

;; Toggle between two themes
(defun toggle-theme ()
  (interactive)
  (if (string-equal doom-theme "doom-one")
      (load-theme 'doom-zenburn t)
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
 (setq doom-font (font-spec :family "Iosevka Term" :size 14 :weight 'light))
 (setq doom-variable-pitch-font (font-spec :family "Iosevka Term" :size 14))



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

;; (require 'org)
;;  (setq org-todo-keywords
;;   '((sequence "TODO"
;;       "OBS!"
;;       "MAYBE"
;;       "NOTE"
;;       "REVIEW"
;;       "WAITING"
;;       "DONE")))

;; (setq org-todo-keyword-faces
;;       '(("TODO" . org-warning) ("STARTED" . "yellow")
;;         ("NOTE" . (:foreground "orange" :weight bold))
;;         ("REVIEW" . (:foreground "pink" :weight bold))
;;         ("OBS!" . (:foreground "red" :weight bold))))

;; (setq hl-todo-keyword-faces
;;       '(("TODO"   . "#FF0000")
;;         ("FIXME"  . "#FF0000")
;;         ("OBS!" . (:foreground "red" :weight bold)))
;;         ("DEBUG"  . "#A020F0")
;;         ("REVIEW"  . "#A020F0")
;;         ("GOTCHA" . "#FF4500")
;;         ("NOTE"   . "#1E90FF")))

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


