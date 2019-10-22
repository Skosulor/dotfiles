;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Load .el files
(load! "bindings")

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

