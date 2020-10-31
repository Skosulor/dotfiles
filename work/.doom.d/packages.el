;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

(unpin! doom-themes)
(package! haskell-mode)
(package! vterm)
(package! evil-nerd-commenter)
(package! dired-hacks)
(package! winum)
(package! highlight-indent-guides)
(package! lsp-treemacs)
(package! minimap)
(package! org-jira)
(package! grammarly)
(package! typit)
(package! gdscript-mode
          :recipe (:host github
                   :repo "GDQuest/emacs-gdscript-mode"))


;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)
