;;; ~/.doom.d/bindings.el -*- lexical-binding: t; -*-

(setq x-meta-keysym 'super)
(map! "s-;" #'counsel-M-x)




(map! :leader
      :desc "Goto Word" "SPC" #'avy-goto-word-0

      ;; M-x
      (:desc "M-x" ";" #'counsel-M-x)
      (:desc "shell command" ":" #'shell-command)
      ;; help
      (:prefix ("h" . "help")
      :desc "Man pages" "m" #'man)

      ;; open
      (:prefix ("o" . "open")
      :desc "vterm" "t" #'switch-to-vterm)

      ;; files
      (:prefix ("f" . "file")
      :desc "write all" "W" #'evil-write-all)

      ;; comments
      (:prefix ("c" . "code/comment")
      :desc "Spellcheck word" "s" #'ispell-word
      :desc "comment box" "b" #'comment-box
      :desc "comment line" "l" #'comment-line
      :desc "comment & copy" "y" #'evilnc-copy-and-comment-lines
      :desc "comment paragraph" "p" #'evilnc-comment-or-uncomment-paragraphs)

      ;; last buffer
      (:prefix ("TAB" . "workspace")
      :desc "last buffer" "TAB" #'evil-switch-to-windows-last-buffer)

      ;;jump
      (:prefix-map ("j" . "jump")
      :desc "imenu" "i" #'imenu
      :desc "counsel-imenu" "j" #'counsel-imenu)

      ;; Avy
      (:prefix-map ("a" . "Avy")
      :desc "Goto Line" "l" #'avy-goto-line
      :desc "Goto Word by char" "w" #'avy-goto-word-1
      :desc "Goto word" "W" #'avy-goto-word-0
      :desc "Goto char " "c" #'avy-goto-char-2))

;; haskell bindings
(map! :map haskell-mode-map
      :localleader
      "m" #'run-haskell
      "s" #'haskell-interactive-switch
      "l" #'haskell-process-load-file
      )





(map! :map dired-mode-map
      :n "<tab>" #'dired-subtree-toggle
      :localleader
      "d" #'dired-create-directory
      "c" #'dired-do-copy
      "D" #'dired-do-delete
      "C" #'dired-diff
      "i" #'image-dired
      "p" #'dired-do-chmod
      "u" #'dired-up-directory
      "X" #'dired-do-flagged-delete
      "z" #'dired-do-compress
      "r" #'dired-do-rename
      )




 ;; (map! :leader
 ;;       :desc "Align" "a" #'align)
