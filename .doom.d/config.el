;;; .doom.d/config.el -*- lexical-binding: t; -*-

(setq centaur-tabs-height 30)
(setq centaur-tabs-set-icons t)
(setq centaur-tabs-gray-out-icons 'buffer)
(setq centaur-tabs-set-bar 'under)
(setq x-underline-at-descent-line t)

(setq doom-font (font-spec :family "Iosevka Term" :size 14 :weight 'light))
(setq doom-variable-pitch-font (font-spec :family "Iosevka Term" :size 14))

(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq highlight-indent-guides-method 'character)
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

(defun switch-to-vterm ()
  (when (get-buffer "vterm")
  (switch-to-buffer vterm)))

(defun ocp ()
  (interactive)
  (lsp-ui-sideline-toggle-symbols-info)
  (lsp-treemacs-symbols)
  (evil-window-left 1)
  ;; (evil-window-right 1)
  (treemacs)
  (evil-window-right 1))

(map! :leader
      (:prefix ("p" . "project")
      :desc "project tools" "P" 'ocp))
