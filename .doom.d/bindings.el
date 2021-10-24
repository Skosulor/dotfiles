;;; ~/.doom.d/bindings.el -*- lexical-binding: t; -*-


(setq x-meta-keysym 'super)
(map! "s-;" #'counsel-M-x)
(map! "s-j" 'evil-window-down)
(map! "s-k" 'evil-window-up)
(map! "s-h" 'evil-window-left)
(map! "s-l" 'evil-window-right)

;(global-set-key (kbd "C-x n") #'centaur-tabs-forward)
;(global-set-key (kbd "C-b n") #'centaur-tabs-backward)

(with-eval-after-load 'evil-maps
  (define-key evil-normal-state-map (kbd "C-S-n") nil)
  (define-key evil-normal-state-map (kbd "C-S-b") nil)
  (define-key evil-normal-state-map (kbd "C-j") nil)
  (define-key evil-normal-state-map (kbd "C-k") nil))

(require 'evil-snipe)
  (define-key evil-snipe-parent-transient-map (kbd "s") 'evil-snipe-repeat)
  (define-key evil-snipe-parent-transient-map (kbd "f") 'evil-snipe-repeat)
  (define-key evil-snipe-parent-transient-map (kbd "S") 'evil-snipe-repeat-reverse)
  (define-key evil-snipe-parent-transient-map (kbd "F") 'evil-snipe-repeat-reverse)



(map! :map general-override-mode-map "C-h" #'c-end-expression)
(map! :map general-override-mode-map :n "C-h" #'c-end-expression)

(map! :leader
      (:prefix ("t" . "toggle")
       :desc "dark mode" "d" #'toggle-theme
       :desc "vterm" "t" #'+vterm/toggle))

;; (map! :leader
;;       (:prefix ("p" . "project")
;;        :desc "List project TODOs" "t" #'ivy-magit-todos))

(map! :leader
      :desc "Goto Word" "SPC" #'avy-goto-word-0
      :desc "window 0" "0" #'treemacs-select-window
      :desc "window 1" "1" #'winum-select-window-1
      :desc "window 2" "2" #'winum-select-window-2
      :desc "window 3" "3" #'winum-select-window-3
      :desc "window 4" "4" #'winum-select-window-4

      ;; M-x
      (:desc "M-x" ";" #'counsel-M-x)
      (:desc "shell command" ":" #'shell-command)

      ;; help
      (:prefix ("h" . "help")
      :desc "Man pages" "m" #'man)

      ;; op
      (:prefix ("o" . "open")
      :desc "Calender" "c" #'cfw:open-org-calendar)

      ;; files
      (:prefix ("f" . "file")
      :desc "write all" "W" #'evil-write-all)

      ;; comments
      (:prefix ("c" . "code/comment")
      :desc "Spellcheck word" "s" #'ispell-word
      :desc "find synonym" "S" #'get-syn
      :desc "comment box" "b" #'comment-box
      :desc "comment line" "l" #'comment-line
      :desc "comment & copy" "y" #'evilnc-copy-and-comment-lines
      :desc "comment paragraph" "p" #'evilnc-comment-or-uncomment-paragraphs
      :desc "rtags jump to definition" "D" #'rtags-find-symbol-at-point
      :desc "multiedit" "m" #'evil-multiedit-match-all
      :desc "narrow buffer" "n" #'doom/toggle-narrow-buffer
      :desc "correct word at point" "s" #'flyspell-correct-at-point)

      ;; last buffer
      (:prefix ("TAB" . "workspace")
        :desc "last buffer" "TAB" #'evil-switch-to-windows-last-buffer
        :desc "buffers" "SPC" #'switch-to-buffer)

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

;; ;; haskell bindings
;; (map! :map haskell-mode-map
;;       :localleader
;;       "m" #'run-haskell
;;       "s" #'haskell-interactive-switch
;;       "l" #'haskell-process-load-file
;;       )






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
(require 'org)
(define-key org-mode-map (kbd "C-S-k") 'centaur-tabs-forward)
(define-key org-mode-map (kbd "C-S-j") 'centaur-tabs-backward)
(map! :map org-mode-map
      :localleader
      "T" #'evil-org-org-insert-todo-heading-respect-content-below
      "h" #'evil-org-org-insert-heading-respect-content-below
      )

;; ;; sane defaults for GDB
;; (map! :map c++-mode-map
;;       :n "C-N" 'gud-next
;;       :n "C-S" 'gud-step
;;       :n "C-B" 'gud-break
;;       :n "C-R" 'gud-run
;;       :n "C-C" 'gud-cont)
