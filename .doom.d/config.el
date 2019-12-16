;;; .doom.d/config.el -*- lexical-binding: t; -*-



(setq neo-window-width 18)
(setq neo-window-fixed-size nil)

(setq doom-modeline-height 20)
(setq straight-allow-recipe-inheritance nil)
;; Load .el files
(load! "bindings")


(setq-default hl-todo-mode 't)

(setq dired-listing-switches
      "-alhX --group-directories-first")

(require 'company)
(setq company-idle-delay 0.2
      company-minimum-prefix-length 2)

;; Packages
;; (def-package! haskell-mode)
(setq display-line-numbers-type 'relative
              display-line-numbers-current-absolute t)
;; Place your private configuration here

(defun switch-to-vterm ()
  (when (get-buffer "vterm")
  (switch-to-buffer vterm)))

