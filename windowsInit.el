(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq enable-recursive-minibuffers t)

(use-package wgrep
  :ensure t)

(set-default 'truncate-lines t)

(use-package pdf-tools)
;; (pdf-tools-install)

(use-package quelpa)
(use-package quelpa-use-package)

(use-package copilot
  :quelpa (copilot :fetcher github
                   :repo "zerolfx/copilot.el"
                   :branch "main"
                   :files ("dist" "*.el" "*.c" "*.rs" "*.h")))

(setq truncate-lines t)

(use-package pomidor
  :config (setq pomidor-sound-tick nil
                pomidor-sound-tack nil)
  :hook (pomidor-mode . (lambda ()
                          (display-line-numbers-mode -1)
                          (setq left-fringe-width 0 right-fringe-width 0)
                          (setq left-margin-width 2 right-margin-width 0)
                          (set-window-buffer nil (current-buffer)))))

(setq pomidor-alert (lambda () (emacs-floating-notification "\n-------Break Time!-------\n\n")))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-set-navigator t)
  (setq dashboard-set-init-info nil)
  (setq dashboard-init-info "Welcome Hell")
  (setq dashboard-footer-messages '("Welcome Hell"))
  (setq dashboard-center-content t))


(defun dashboard-insert-pomidor (list-size)
  "Insert the custom Pomodoro widget into the dashboard."
  (dashboard-insert-heading "Pomodoro" nil "p")  ;; 'p' is the tag for this section
  (widget-create 'push-button
                 :action (lambda (&rest _ignore)
                           (pomidor))
                 :mouse-face 'highlight
                 :follow-link "\C-m"
                 :button-prefix ""
                 :button-suffix ""
                 :format "%[%t%]"
                 "\n     Start Timer")
  (insert "\n"))



(use-package dashboard-hackernews)

(setq dashboard-items '((hackernews . 5)
                        (recents  . 5)
                        (projects . 5)))
(add-to-list 'dashboard-item-generators '(pomidor . dashboard-insert-pomidor))
(add-to-list 'dashboard-items '(pomidor) t)

(use-package tab-jump-out
  :config
  (tab-jump-out-mode))
(electric-pair-mode 1)

(defvar efs/default-font-size 110)
(defvar efs/default-variable-font-size 110)

;; Make frame transparency overridable
(defvar efs/frame-transparency '(90 . 90))

(set-face-attribute 'default nil :family "Iosevka" :height 130)

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))


  ;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Auot package updating
;; (use-package auto-package-update
;;   :custom
;;   (auto-package-update-interval 7)
;;   (auto-package-update-prompt-before-update t)
;;   (auto-package-update-hide-results t)
;;   :config
;;   (auto-package-update-maybe)
;;   (auto-package-update-at-time "09:00"))

;; NOTE: If you want to move everything out of the ~/.emacs.d folder
;; reliably, set `user-emacs-directory` before loading no-littering!
;(setq user-emacs-directory "~/.cache/emacs")

(use-package no-littering)

  ;; no-littering doesn't set this by default so we must place
  ;; auto save files in the same path as it uses for sessions
  (setq auto-save-file-name-transforms
        `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

  (setq inhibit-startup-message t)

  (scroll-bar-mode -1)        ; Disable visible scrollbar
  (tool-bar-mode -1)          ; Disable the toolbar
  (tooltip-mode -1)           ; Disable tooltips
  (set-fringe-mode 10)        ; Give some breathing room

  (menu-bar-mode -1)            ; Disable the menu bar

  ;; (column-number-mode)
  (setq display-line-numbers-type 'relative)
    (add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                vterm-mode-hook
                treemacs-mode-hook
                pdf-view-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package magit
  :commands magit-status
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package forge
  :after magit)

;; (use-package vterm
;;   :ensure t)

;; (use-package vterm-toggle)
;; (setq vterm-toggle-fullscreen-p nil)
;; (add-to-list 'display-buffer-alist
;;              '((lambda (buffer-or-name _)
;;                  (let ((buffer (get-buffer buffer-or-name)))
;;                    (with-current-buffer buffer
;;                      (or (equal major-mode 'vterm-mode)
;;                          (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
;;                (display-buffer-reuse-window display-buffer-at-bottom)
;;                ;;(display-buffer-reuse-window display-buffer-in-direction)
;;                ;;display-buffer-in-direction/direction/dedicated is added in emacs27
;;                ;;(direction . bottom)
;;                ;;(dedicated . t) ;dedicated is supported in emacs27
;;                (reusable-frames . visible)
;;                (window-height . 0.3)))

(use-package projectile
  :hook
  (after-init . projectile-global-mode)
  :init
  (setq-default
   projectile-cache-file (expand-file-name ".projectile-cache" user-emacs-directory)
   projectile-known-projects-file (expand-file-name ".projectile-bookmarks" user-emacs-directory))
  :custom
  (setq projectile-projects-cache (make-hash-table))
  (projectile-enable-caching t))

(use-package evil-nerd-commenter
  :ensure t
  :bind (:map evil-normal-state-map
              ("gc" . evilnc-comment-operator)))

(use-package hl-todo
    :ensure t
    :init
    (global-hl-todo-mode))

  (use-package flycheck
    :ensure t
    :init
    (global-flycheck-mode 1))

  (use-package flycheck-hl-todo
    :ensure t
    :defer 5 ; Need to be initialized after the rest of checkers
    :config
    (flycheck-hl-todo-setup))

(use-package magit-todos
  :after magit
  :config (magit-todos-mode 1))

(use-package tabspaces
  :hook (after-init . tabspaces-mode) ;; use this only if you want the minor-mode loaded at startup. 
  :commands (tabspaces-switch-or-create-workspace
             tabspaces-open-or-create-project-and-workspace)
  :custom
  (tabspaces-use-filtered-buffers-as-default t)
  (tabspaces-default-tab "Default")
  (tabspaces-remove-to-default t)
  (tabspaces-include-buffers '("*scratch*"))
  (tabspaces-initialize-project-with-todo t)
  ;; sessions
  (tabspaces-session t)
  (tabspaces-session-auto-restore nil))

(with-eval-after-load 'consult
;; hide full buffer list (still available with "b" prefix)
(consult-customize consult--source-buffer :hidden t :default nil)
;; set consult-workspace buffer list
(defvar consult--source-workspace
  (list :name     "Workspace Buffers"
        :narrow   ?w
        :history  'buffer-name-history
        :category 'buffer
        :state    #'consult--buffer-state
        :default  t
        :items    (lambda () (consult--buffer-query
                         :predicate #'tabspaces--local-buffer-p
                         :sort 'visibility
                         :as #'buffer-name)))

  "Set workspace buffer list for consult-buffer.")
(add-to-list 'consult-buffer-sources 'consult--source-workspace))

(use-package flycheck-posframe
  :ensure t
  :after flycheck
  :config (add-hook 'flycheck-mode-hook #'flycheck-posframe-mode))

(use-package posframe
    :ensure t)

(defun emacs-floating-notification (message)
  "Display a floating window notification in Emacs."
  (interactive "sEnter notification message: ")
  (posframe-show "*emacs-notification*"
                 :string message
                 :timeout 5
                 :position (point)))

(use-package page-break-lines
  :config
  (set-fontset-font "fontset-default"
                    (cons page-break-lines-char page-break-lines-char)
                    (face-attribute 'default :family))
  (global-page-break-lines-mode))

(use-package nerd-icons)

(use-package nerd-icons-completion
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))        (use-package nerd-icons-corfu)

;; (use-package doom-modeline
;;   ;; :init (doom-modeline-mode 1)
;;   :custom ((doom-modeline-height 15)))

(setq-default mode-line-format nil) 

(use-package nano-modeline)
(nano-modeline-text-mode t)
(add-hook 'prog-mode-hook            #'nano-modeline-prog-mode)
(add-hook 'text-mode-hook            #'nano-modeline-text-mode)
(add-hook 'org-mode-hook             #'nano-modeline-org-mode)
(add-hook 'pdf-view-mode-hook        #'nano-modeline-pdf-mode)
(add-hook 'mu4e-headers-mode-hook    #'nano-modeline-mu4e-headers-mode)
(add-hook 'mu4e-view-mode-hook       #'nano-modeline-mu4e-message-mode)
(add-hook 'elfeed-show-mode-hook     #'nano-modeline-elfeed-entry-mode)
(add-hook 'elfeed-search-mode-hook   #'nano-modeline-elfeed-search-mode)
(add-hook 'term-mode-hook            #'nano-modeline-term-mode)
(add-hook 'xwidget-webkit-mode-hook  #'nano-modeline-xwidget-mode)
(add-hook 'messages-buffer-mode-hook #'nano-modeline-message-mode)
(add-hook 'org-capture-mode-hook     #'nano-modeline-org-capture-mode)
(add-hook 'org-agenda-mode-hook      #'nano-modeline-org-agenda-mode)

(use-package hydra
  :defer t)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" decrease-font-size "out")
  ("k" increase-font-size "out")
  ("f" nil "finished" :exit t))

;; (use-package doom-themes)
      ;; (load-theme 'doom-everforest t)

      (use-package nano-theme
        :ensure nil
        :defer t
        :quelpa (nano-theme
                 :fetcher github
                 :repo "rougier/nano-theme"))

      (use-package nano
        :ensure nil
        :defer t
        :quelpa (nano-theme
                 :fetcher github
                 :repo "rougier/nano-emacs"))

  (straight-use-package
    '(nano :type git :host github :repo "rougier/nano-emacs"))

  (straight-use-package
    '(nano-minibuffer :type git :host github :repo "rougier/nano-minibuffer"))

   (use-package svg-lib)

  (straight-use-package
    '(org-margin :type git :host github :repo "rougier/org-margin"))

  ;; (require 'nano)
  (load-theme 'nano-dark t)
  (load-theme 'doom-one t)
  (require 'nano-minibuffer)

;; (with-eval-after-load 'vertico
;;   (set-face-attribute 'vertico-current nil :background "dark grey"))

;; (require 'treesit)
;; (setq treesit-extra-load-path (list  (expand-file-name "tree-sitter-module/dist/" user-emacs-directory)))

;; (use-package treesit-auto
;;   :config
;;   (global-treesit-auto-mode))

;; (use-package highlight-symbol
;;   :ensure t
;;   :init
;;   (setq highlight-symbol-idle-delay 0)
;;   (add-hook 'prog-mode-hook 'highlight-symbol-mode))

(use-package treemacs)
(treemacs-resize-icons 15)

(use-package writeroom-mode)

(use-package fancy-narrow)

(use-package general
  :after evil
  :config
  (general-create-definer global/leader-key
    :keymaps '(normal insert visual emacs dashboard-mode-map)
    :prefix "SPC"
    :global-prefix "M-SPC")
  (general-create-definer normal/g
    :keymaps '(normal)
    :prefix "g"))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  ;; (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  ;; (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-numbers)

(evil-set-undo-system 'undo-redo)

(modify-syntax-entry ?_ "w")

(with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol)
    ;; make evil-search-word look for symbol rather than word boundaries
    (setq-default evil-symbol-word-search t))

(use-package evil-snipe)
(evil-snipe-mode 1)
(evil-snipe-override-mode 1)
(setq evil-snipe-scope 'whole-visible)

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(setq evil-want-integration t) ;; This is optional since it's already set to t by default.
(setq evil-want-keybinding nil)
(require 'evil)
(when (require 'evil-collection nil t)
  (evil-collection-init))

(use-package evil-org)

(use-package which-key
      :defer 0
      :diminish which-key-mode
      :config
      (which-key-mode)
      (setq which-key-idle-delay 0.1)
      (which-key-setup-side-window-bottom))

(setq which-key-popup-type 'side-window)
(setq which-key-min-display-lines 5)

(use-package xwwp
  :load-path "~/.config/emacs/xwwp"
  :bind (:map xwidget-webkit-mode-map
              ("v" . xwwp-follow-link)
              ("t" . xwwp-ace-toggle)))

(use-package evil-goggles
  :ensure t
  :config
  (setq evil-goggles-duration 0.1) 
  (evil-goggles-mode))

(use-package vertico
  :bind (:map vertico-map
         ("C-j" . vertico-next)
         ("C-k" . vertico-previous)
         ("C-f" . vertico-exit)
         :map minibuffer-local-map
         ("M-h" . dw/minibuffer-backward-kill))
  :custom
  (vertico-cycle t)
  :custom-face
  (vertico-current ((t (:background "#3a3f5a"))))
  :init
  (vertico-mode))

(use-package corfu
  :after vertico
  :bind (:map corfu-map
	      ("C-j" . corfu-next)
	      ("C-k" . corfu-previous)
	      ("C-f" . corfu-insert))
  :custom
  (corfu-cycle t)
  (corfu-auto t)                 ;; Enable auto completion
  :init
  (global-corfu-mode))

(use-package orderless
      :init
      (setq completion-styles '(orderless)
            completion-category-defaults nil
            completion-category-overrides '((file (styles . (partial-completion))))))

(defun dw/get-project-root ()
  (when (fboundp 'projectile-project-root)
    (projectile-project-root)))

(use-package consult
  :demand t
  :bind (("C-s" . consult-line)
         ("C-M-l" . consult-imenu)
         ("C-M-j" . persp-switch-to-buffer*)
         :map minibuffer-local-map
         ("C-r" . consult-history))
  :config
  (setq consult-async-min-input 0)
  :custom
  (consult-project-root-function #'dw/get-project-root)
  (completion-in-region-function #'consult-completion-in-region))

(setq xref-show-xrefs-function #'consult-xref
      xref-show-definitions-function #'consult-xref)
(setq consult-async-input-threshold 0)
(use-package consult-dir)
(use-package consult-org-roam)
(use-package consult-projectile)

(use-package marginalia
  :after vertico
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package embark-consult)
    (use-package embark
      :bind (("C-." . embark-act)
             :map minibuffer-local-map
             ("C-." . embark-act))
      :init

      ;; Show Embark actions via which-key
      (setq embark-action-indicator
            (lambda (map)
              (which-key--show-keymap "Embark" map nil nil 'no-paging)
              #'which-key--hide-popup-ignore-command)
            embark-become-indicator embark-action-indicator))

(defun my/embark-act-show-help (&rest _args)
  "Automatically show Embark action help after invoking `embark-act'."
  (embark-help-key))

(advice-add 'embark-act :after #'my/embark-act-show-help)

(use-package quickrun)

(use-package rust-mode)

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l"))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

;; (use-package dumb-jump)
  ;; (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
  ;; (setq xref-show-definitions-function #'xref-show-definitions-completing-read)

(use-package dumb-jump
  :ensure t
  :demand t
  :custom
  (xref-show-definitions-function #'consult-xref)
  (setq dumb-jump-force-searcher 'rg)
  :init
  (setq dumb-jump-force-searcher 'rg)
  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))




  (defhydra dumb-jump-hydra (:color blue :columns 3)
    "Dumb Jump"
    ("j" dumb-jump-go "Go")
    ("o" dumb-jump-go-other-window "Other window")
    ("e" dumb-jump-go-prefer-external "Go external")
    ("x" dumb-jump-go-prefer-external-other-window "Go external other window")
    ("i" dumb-jump-go-prompt "Prompt")
    ("l" dumb-jump-quick-look "Quick look")
    ("b" dumb-jump-back "Back"))

(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; set faces for heading levels
  (dolist (face '((org-level-1 . 1.10)
                  (org-level-2 . 1.05)
                  (org-level-3 . 1.00)
                  (org-level-4 . 1.00)
                  (org-level-5 . 1.00)
                  (org-level-6 . 1.00)
                  (org-level-7 . 1.00)
                  (org-level-8 . 1.00)))
    (set-face-attribute (car face) nil  :weight 'semi-bold :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
   ;; (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
   ;; (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
   ;; (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
   ;; (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
   ;; (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
   ;; (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
   ;; (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
   ;; (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
   ;; (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
   ;; (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
   ;; (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch)
   )

(defun efs/org-mode-setup ()
  (visual-line-mode 1))

(use-package org
  :pin org
  :commands (org-capture org-agenda)
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
      (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-refile-targets
    '(("Archive.org" :maxlevel . 1)
      ("Tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (efs/org-font-setup))

(use-package org-bullets
:hook (org-mode . org-bullets-mode)
:custom
(org-bullets-bullet-list '(" " " " " " " " " " " " " ")))

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

;; (use-package visual-fill-column
;;   :hook (org-mode . efs/org-mode-visual-fill))

(with-eval-after-load 'org
   (org-babel-do-load-languages
       'org-babel-load-languages
       '((emacs-lisp . t)
       (python . t)))

   (push '("conf-unix" . conf-unix) org-src-lang-modes))

(with-eval-after-load 'org
  ;; This is needed as of Org 9.2
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python")))

(use-package org-roam)
(add-to-list 'display-buffer-alist
             '("\\*org-roam\\*"
               (display-buffer-in-direction)
               (direction . right)
               (window-width . 0.33)
               (window-height . fit-window-to-buffer)))

(setq org-hide-emphasis-markers t)
(setq org-insert-heading-respect-content nil)
(setq org-roam-directory "~/org/roam")

(defun hell/generate-init-el ()
  "Automatically tangle our Emacs Org config when we save the Org file."
  (let ((org-file (expand-file-name "init.org" user-emacs-directory))
        (el-file (expand-file-name "init.el" user-emacs-directory)))
    (when (string-equal (buffer-file-name) org-file)
      (org-babel-tangle-file org-file el-file))))

(add-hook 'org-mode-hook
          (lambda ()
            (add-hook 'after-save-hook #'hell/generate-init-el nil 'make-it-local)))

(set-face-attribute 'variable-pitch nil :family "Deja Vu Sans" :height 130)
(set-face-attribute 'org-block nil :inherit 'default)

(defun hell/grep-edit()
  (interactive)
  (when (cl-search "Ripgrep" (buffer-string))
    (run-at-time 0 nil #'embark-export)
    (run-at-time 0 nil #'wgrep-change-to-wgrep-mode)))

(defun hell/load-my-init-file ()
  "Load the new init file."
  (interactive)
  (let ((init-file (expand-file-name "init.el" user-emacs-directory)))
    (if (file-readable-p init-file)
        (load-file init-file)
      (message "Init file not found: %s" init-file))))

(defun hell/open-init-org ()
  "Open the org file of which the init file is generated from"
  (interactive)
  (find-file (expand-file-name "init.org" user-emacs-directory)))

(defun hell/yank-file-path ()
  "Yank the path to the current file"
  (interactive)
  (kill-new default-directory))

(unless (package-installed-p 'vc-use-package)
  (package-vc-install "https://github.com/slotThe/vc-use-package"))

(cl-defun slot/vc-install (&key (fetcher "github") repo name rev backend)
  "Install a package from a remote if it's not already installed.
This is a thin wrapper around `package-vc-install' in order to
make non-interactive usage more ergonomic.  Takes the following
named arguments:

- FETCHER the remote where to get the package (e.g., \"gitlab\").
  If omitted, this defaults to \"github\".

- REPO should be the name of the repository (e.g.,
  \"slotThe/arXiv-citation\".

- NAME, REV, and BACKEND are as in `package-vc-install' (which
  see)."
  (let* ((url (format "https://www.%s.com/%s" fetcher repo))
         (iname (when name (intern name)))
         (pac-name (or iname (intern (file-name-base repo)))))
    (unless (package-installed-p pac-name)
      (package-vc-install url iname rev backend))))

(defun hell/browse-package-files ()
  "Browse files of an installed package using Consult."
  (interactive)
  (let* ((pkg-list (mapcar #'car package-alist))
         (pkg-name (completing-read "Select package: " (mapcar #'symbol-name pkg-list) nil t))
         (pkg-desc-list (cdr (assoc (intern pkg-name) package-alist)))
         (pkg-desc (if (listp pkg-desc-list) (car pkg-desc-list) pkg-desc-list))
         (pkg-dir (if (package-desc-p pkg-desc) (package-desc-dir pkg-desc) nil)))
    (when pkg-dir
      (consult-fd pkg-dir))))

(defun hell/toggle-relative-line-numbers ()
  "Toggle relative line numbers."
  (interactive)
  (if display-line-numbers-mode
      (progn
        (setq display-line-numbers nil)
        (display-line-numbers-mode -1))
    (progn
      (setq display-line-numbers 'relative)
      (display-line-numbers-mode 1))))

(defmacro map-key (&rest key-command-pairs)
  "Define keybindings under the global leader key.
  KEY-COMMAND-PAIRS should be a sequence of (key command description) tuples."
  `(progn
     ,@(mapcar (lambda (pair)
                 `(global/leader-key
                    ,(car pair) '(,(cadr pair) :which-key ,(caddr pair))))
               key-command-pairs)))

;; Example 
;; (map-key("zz" eglot))
;; or
;; (map-key("zz" eglot "Start LSP"))

(defun hell/toggle-org-src-mode ()
  "Toggle between Org mode and Org source edit mode."
  (interactive)
  (if (bound-and-true-p org-src-mode)
      (org-edit-src-exit)
    (org-edit-special)))

(defun hell/search-cursor-word ()
  "Search for the word under the cursor using consult-ripgrep."
  (interactive)
  (consult-ripgrep nil (thing-at-point 'symbol t)))

(defun increase-font-size ()
  "Increase global font size."
  (interactive)
  (set-face-attribute 'default nil
                      :height (+ (face-attribute 'default :height) 5)))

(defun decrease-font-size ()
  "Decrease global font size."
  (interactive)
  (set-face-attribute 'default nil
                      :height (- (face-attribute 'default :height) 10)))

(defvar hell/line-numbers-were-on nil
  "Flag to remember if line numbers were on before toggling zen mode.")

(defun hell/zen-mode ()
  "Toggle writeroom-mode and relative line numbers."
  (interactive)
  ;; Toggle writeroom-mode
  (if (bound-and-true-p writeroom-mode)
      (progn
        (writeroom-mode -1)
        ;; Re-enable line numbers only if they were on
        (when hell/line-numbers-were-on
          (global-display-line-numbers-mode 1)))
    (progn
      ;; Store the current state of line numbers
      (setq hell/line-numbers-were-on (bound-and-true-p display-line-numbers-mode))
      (writeroom-mode 1)
      ;; Disable line numbers
      (global-display-line-numbers-mode -1))))

(defun hell/toggle-fancy-narrow ()
  "Toggle fancy-narrow on the selected region, or widen if already narrowed."
  (interactive)
  (if (fancy-narrow-active-p)
      (fancy-widen)
    (when (use-region-p)
      (fancy-narrow-to-region (region-beginning) (region-end)))))

(defun find-symbol-references ()
  "Find references of the symbol under the cursor."
  (interactive)
  (xref-find-references (thing-at-point 'symbol)))

(defun hell/open-project()
  "Open a new project using Projectile. If in dashboard, just switch project; otherwise, open in a new tab."
  (interactive)
  (let ((current-buffer (current-buffer))
        (in-dashboard (eq major-mode 'dashboard-mode)))
    ;; Create a new tab if not in the dashboard
    (unless in-dashboard
      (tab-new)
      (tabspaces-remove-selected-buffer current-buffer))
    ;; Try to switch to a new project using Projectile
    (condition-case nil
        (consult-projectile-switch-project)
      (quit
       ;; If project selection is aborted and a new tab was created, close it
       (unless in-dashboard
         (tab-close))))
    ;; Rename the tab to the name of the selected project
    (let ((project-name (projectile-project-name)))
      (when (and project-name (not (equal project-name "-")))
        (unless in-dashboard
          (tab-rename project-name))))))

  (setq tab-bar-new-button-show nil)
  (setq tab-bar-close-button-show nil)
  (setq tab-bar-auto-width-max '(110 10))

(defun hell/what-face (pos)
  (interactive "d")
  (let ((face (or (get-char-property pos 'read-face-name)
                  (get-char-property pos 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

(defun artist-mode-toggle-emacs-state ()
(interactive)
  (if artist-mode
      (evil-emacs-state)
    (evil-exit-emacs-state)))

(defun convert-hex-to-binary (hex-str)
  "Convert a hexadecimal string to a binary string."
  (let ((hex-map '("0000" "0001" "0010" "0011" "0100" "0101" "0110" "0111"
                   "1000" "1001" "1010" "1011" "1100" "1101" "1110" "1111"))
        binary-str)
    (dolist (char (append hex-str nil) binary-str)
      (setq binary-str (concat binary-str (nth (string-to-number (char-to-string char) 16) hex-map))))))

(defun convert-number-at-point ()
  "Toggle the number at point between decimal, hexadecimal, and binary."
  (interactive)
  (let* ((bounds (bounds-of-thing-at-point 'symbol))
         (num-str (buffer-substring-no-properties (car bounds) (cdr bounds)))
         (is-hex (string-match-p "^0x" num-str))
         (is-bin (string-match-p "^0b" num-str))
         (num (cond
               (is-hex (string-to-number (substring num-str 2) 16))
               (is-bin (string-to-number (substring num-str 2) 2))
               (t (string-to-number num-str)))))
    (cond
     (is-hex
      ;; Hexadecimal to binary
      (replace-regexp num-str (format "0b%s" (convert-hex-to-binary (substring num-str 2))) nil (car bounds) (cdr bounds)))
     (is-bin
      ;; Binary to decimal
      (replace-regexp num-str (format "%d" num) nil (car bounds) (cdr bounds)))
     (t
      ;; Decimal to hexadecimal
      (replace-regexp num-str (format "0x%X" num) nil (car bounds) (cdr bounds))))))

(defun my/org-mode-no-electric-pair-less-than ()
  "Prevent electric pair mode from pairing '<' in org-mode."
  (setq-local electric-pair-inhibit-predicate
              `(lambda (c)
                 (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c)))))

(add-hook 'org-mode-hook #'my/org-mode-no-electric-pair-less-than)

(with-eval-after-load 'consult
  (define-key minibuffer-mode-map (kbd "C-c C-e") #'hell/grep-edit))
  (define-key minibuffer-local-map (kbd "C-w") 'backward-kill-word)

(general-define-key
   :keymaps 'transient-base-map
   "<escape>" 'transient-quit-one)

(evil-define-key '(normal visual) 'global (kbd "C-a")
  'evil-numbers/inc-at-pt)
(evil-define-key '(normal visual) 'global (kbd "C-x")
  'evil-numbers/dec-at-pt)
(normal/g "r" 'find-symbol-references
  "d" 'xref-find-definitions
  "l" 'flycheck-)

(define-key evil-normal-state-map (kbd "C-b") #'convert-number-at-point)

(with-eval-after-load 'vertico
  (define-key vertico-map (kbd "C-h") (lambda () (interactive) (call-interactively 'backward-kill-word)))
  (define-key vertico-map (kbd "C-l") #'vertico-insert))

(define-key copilot-completion-map (kbd "C-j") 'copilot-accept-completion)

(global/leader-key
  "<tab>"  '(:ignore t :which-key "workspace")
  "w"  '(:ignore t :which-key "window")
  "g"  '(:ignore t :which-key "Git")
  "t"  '(:ignore t :which-key "toggles")
  "f"  '(:ignore t :which-key "file")
  "b"  '(:ignore t :which-key "buffer")
  "p"  '(:ignore t :which-key "project")
  "h"  '(:ignore t :which-key "help")
  "a"  '(:ignore t :which-key "align")
  "c"  '(:ignore t :which-key "code")
     "s"  '(:ignore t :which-key "search")
  "n"  '(:ignore t :which-key "Notes/Org")
  "o"  '(:ignore t :which-key "open")
  )

(global/leader-key
  "j" 'consult-imenu
  "J" 'consult-imenu-multi
  "I" #'hell/load-my-init-file
  ";" 'execute-extended-command)
(map-key ("*" hell/search-cursor-word "Search for symbol"))
(map-key ("/" consult-line "Search in file"))
(map-key ("P" consult-yank-pop "Paste from kill-ring"))
(map-key ("SPC" consult-buffer "switch buffer"))

(map-key ("gg" magit "Git-status"))
(map-key ("gb" magit-blame-addition "blame"))
(map-key ("gl" magit-log-all "log"))
(map-key ("gr" magit-reflog-head "reflog"))

(global/leader-key
  "ts" '(hydra-text-scale/body :which-key "scale text")
  "tt" 'vterm-toggle
  "tl" 'hell/toggle-relative-line-numbers)
(map-key ("tf" treemacs "File-tree"))
(map-key ("tc" flyspell-mode "spell correction"))
(map-key ("tz" hell/zen-mode "Zen mode"))
(map-key ("tn" hell/toggle-fancy-narrow "Narrow region"))

(global/leader-key
  "aa" 'align
  "ae" 'align-entire
  "ar" 'align-regexp)

(global/leader-key
  "ff" 'find-file
  "fr" 'recentf
  "fi" 'hell/open-init-org
  "fp" 'hell/yank-file-path
  )
(map-key ("fP" hell/browse-package-files "open Package file"))
(map-key ("ft" treemacs))
(map-key ("fs" consult-projectile-find-file "Find project file"))
(map-key ("fw" evil-write "write file"))

(global/leader-key
  "be" 'eval-buffer)

(map-key ("bp" previous-buffer "previous buffer"))
(map-key ("bn" next-buffer "next buffer"))
(map-key ("bb" consult-buffer "switch buffer"))
(map-key ("bd" kill-this-buffer "kill buffer"))
(map-key ("bD" tabspaces-clear-buffers "Kill other buffers"))

(global/leader-key
  "wl" 'evil-window-right
  "wh" 'evil-window-left
  "wj" 'evil-window-down
  "wk" 'evil-window-up
  "wv" 'evil-window-vsplit
  "ws" 'evil-window-split
  "wq" 'evil-quit
  "wL" 'evil-window-move-far-right
  "wH" 'evil-window-move-far-left
  "wJ" 'evil-window-move-very-bottom
  "wK" 'evil-window-move-very-top
  )

(map-key ("ww" tabspaces-switch-or-create-workspace "Switch workspace"))
(map-key ("wS" tabspaces-save-session "Save session"))
(map-key ("wr" tabspaces-restore-session "Restore session"))
(map-key ("wn" tab-next "next workspace"))
(map-key ("wp" tab-previous "previous workspace"))
(map-key ("w<tab>" evil-switch-to-windows-last-buffer "last buffer"))

(global/leader-key
  "hb" 'embark-bindings
  "hf" 'describe-function
  "hk" 'describe-keymap
  "hi" 'info
  "hv" 'describe-variable
  "hp" 'describe-package)
(map-key ("hm" describe-mode))
(map-key ("hM" man "Man pages"))

(global/leader-key
  "nf" 'org-roam-node-find
  "ni" 'org-roam-node-insert
  "nb" 'org-roam-buffer-toggle
  "nc" 'org-roam-capture)
(map-key ("ne" hell/toggle-org-src-mode "Edit source block"))

(global/leader-key
  "cx" '(consult-flymake :which-key "Errors/diagnostics")
  "ca" 'eglot-code-action
  "cc" 'evilnc-comment-or-uncomment-lines
  "cC" 'compile
  "cp" '(evilnc-comment-or-uncomment-paragraphs :which-key "comment paragraph")
  "cy" '(evilnc-copy-and-comment-lines :which-key "Yank and comment")
  "ce" '(quickrun :which-key "Evaluate code")
  "cE" '(quickrun :which-key "Evaluate code on save")
  "cu" 'lsp-ui-mode
  "cd" '(xref-find-definitions :which-key "Find definition")
  "cr" '(xref-find-references :which-key "Find references"))

(map-key ("pp" hell/open-project "Open Project"))
(map-key ("pf" consult-projectile-find-file "Find project file"))
(map-key ("pr" consult-projectile-recent "Recent project file"))
(map-key ("pa" projectile-add-known-project "add project"))

(map-key ("ss" consult-ripgrep "Search (ripgrep)"))
(map-key ("sf" consult-fd "Search for file"))
(map-key ("sb" consult-line "Search in buffer"))
(map-key ("sd" consult-dir "Search file in dir"))

(map-key ("op" pomidor "Pomidor"))
(map-key ("od" dashboard-open "dashboard"))
(map-key ("ot" projectile-run-vterm "dashboard"))


(defun my/org-mode-setup ()
  "Custom setup for org-mode, avoiding recursive activation."
  (unless (bound-and-true-p org-margin-mode)
    (org-margin-mode))
  (unless (bound-and-true-p nano-mode)
    (nano-mode)))

(add-hook 'org-mode-hook 'my/org-mode-setup)

(use-package jenkinsfile-mode)

(setq ring-bell-function 'ignore)

(add-to-list 'auto-mode-alist
             '("\\.jenkins\\'" . (lambda ()
                               (jenkinsfile-mode)
                               (insert "OK")
                               (turn-on-orgtbl))))

(use-package org-jira)
(setq jiralib-url "https://sdlc.electrolux.com/")
(window-divider-mode -1)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                vterm-mode-hook
                treemacs-mode-hook
                pdf-view-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package magit
  :commands magit-status
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package forge
  :after magit)

;; (use-package vterm
;;   :ensure t)

;; (use-package vterm-toggle)
;; (setq vterm-toggle-fullscreen-p nil)
;; (add-to-list 'display-buffer-alist
;;              '((lambda (buffer-or-name _)
;;                  (let ((buffer (get-buffer buffer-or-name)))
;;                    (with-current-buffer buffer
;;                      (or (equal major-mode 'vterm-mode)
;;                          (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
;;                (display-buffer-reuse-window display-buffer-at-bottom)
;;                ;;(display-buffer-reuse-window display-buffer-in-direction)
;;                ;;display-buffer-in-direction/direction/dedicated is added in emacs27
;;                ;;(direction . bottom)
;;                ;;(dedicated . t) ;dedicated is supported in emacs27
;;                (reusable-frames . visible)
;;                (window-height . 0.3)))

(use-package projectile
  :hook
  (after-init . projectile-global-mode)
  :init
  (setq-default
   projectile-cache-file (expand-file-name ".projectile-cache" user-emacs-directory)
   projectile-known-projects-file (expand-file-name ".projectile-bookmarks" user-emacs-directory))
  :custom
  (setq projectile-projects-cache (make-hash-table))
  (projectile-enable-caching t))

(use-package evil-nerd-commenter
  :ensure t
  :bind (:map evil-normal-state-map
              ("gc" . evilnc-comment-operator)))

(use-package hl-todo
    :ensure t
    :init
    (global-hl-todo-mode))

  (use-package flycheck
    :ensure t
    :init
    (global-flycheck-mode 1))

  (use-package flycheck-hl-todo
    :ensure t
    :defer 5 ; Need to be initialized after the rest of checkers
    :config
    (flycheck-hl-todo-setup))

(use-package magit-todos
  :after magit
  :config (magit-todos-mode 1))

(use-package tabspaces
  :hook (after-init . tabspaces-mode) ;; use this only if you want the minor-mode loaded at startup. 
  :commands (tabspaces-switch-or-create-workspace
             tabspaces-open-or-create-project-and-workspace)
  :custom
  (tabspaces-use-filtered-buffers-as-default t)
  (tabspaces-default-tab "Default")
  (tabspaces-remove-to-default t)
  (tabspaces-include-buffers '("*scratch*"))
  (tabspaces-initialize-project-with-todo t)
  ;; sessions
  (tabspaces-session t)
  (tabspaces-session-auto-restore nil))

(with-eval-after-load 'consult
;; hide full buffer list (still available with "b" prefix)
(consult-customize consult--source-buffer :hidden t :default nil)
;; set consult-workspace buffer list
(defvar consult--source-workspace
  (list :name     "Workspace Buffers"
        :narrow   ?w
        :history  'buffer-name-history
        :category 'buffer
        :state    #'consult--buffer-state
        :default  t
        :items    (lambda () (consult--buffer-query
                         :predicate #'tabspaces--local-buffer-p
                         :sort 'visibility
                         :as #'buffer-name)))

  "Set workspace buffer list for consult-buffer.")
(add-to-list 'consult-buffer-sources 'consult--source-workspace))

(use-package flycheck-posframe
  :ensure t
  :after flycheck
  :config (add-hook 'flycheck-mode-hook #'flycheck-posframe-mode))

(use-package posframe
    :ensure t)

(defun emacs-floating-notification (message)
  "Display a floating window notification in Emacs."
  (interactive "sEnter notification message: ")
  (posframe-show "*emacs-notification*"
                 :string message
                 :timeout 5
                 :position (point)))

(use-package page-break-lines
  :config
  (set-fontset-font "fontset-default"
                    (cons page-break-lines-char page-break-lines-char)
                    (face-attribute 'default :family))
  (global-page-break-lines-mode))

(use-package nerd-icons)

(use-package nerd-icons-completion
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))        (use-package nerd-icons-corfu)

;; (use-package doom-modeline
;;   ;; :init (doom-modeline-mode 1)
;;   :custom ((doom-modeline-height 15)))

(setq-default mode-line-format nil) 

(use-package nano-modeline)
(nano-modeline-text-mode t)
(add-hook 'prog-mode-hook            #'nano-modeline-prog-mode)
(add-hook 'text-mode-hook            #'nano-modeline-text-mode)
(add-hook 'org-mode-hook             #'nano-modeline-org-mode)
(add-hook 'pdf-view-mode-hook        #'nano-modeline-pdf-mode)
(add-hook 'mu4e-headers-mode-hook    #'nano-modeline-mu4e-headers-mode)
(add-hook 'mu4e-view-mode-hook       #'nano-modeline-mu4e-message-mode)
(add-hook 'elfeed-show-mode-hook     #'nano-modeline-elfeed-entry-mode)
(add-hook 'elfeed-search-mode-hook   #'nano-modeline-elfeed-search-mode)
(add-hook 'term-mode-hook            #'nano-modeline-term-mode)
(add-hook 'xwidget-webkit-mode-hook  #'nano-modeline-xwidget-mode)
(add-hook 'messages-buffer-mode-hook #'nano-modeline-message-mode)
(add-hook 'org-capture-mode-hook     #'nano-modeline-org-capture-mode)
(add-hook 'org-agenda-mode-hook      #'nano-modeline-org-agenda-mode)

(use-package hydra
  :defer t)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" decrease-font-size "out")
  ("k" increase-font-size "out")
  ("f" nil "finished" :exit t))

;; (use-package doom-themes)
      ;; (load-theme 'doom-everforest t)

      (use-package nano-theme
        :ensure nil
        :defer t
        :quelpa (nano-theme
                 :fetcher github
                 :repo "rougier/nano-theme"))

      (use-package nano
        :ensure nil
        :defer t
        :quelpa (nano-theme
                 :fetcher github
                 :repo "rougier/nano-emacs"))

  (straight-use-package
    '(nano :type git :host github :repo "rougier/nano-emacs"))

  (straight-use-package
    '(nano-minibuffer :type git :host github :repo "rougier/nano-minibuffer"))

   (use-package svg-lib)

  (straight-use-package
    '(org-margin :type git :host github :repo "rougier/org-margin"))

  ;; (require 'nano)
  (load-theme 'nano-dark t)
  (load-theme 'doom-one t)
  (require 'nano-minibuffer)

;; (with-eval-after-load 'vertico
;;   (set-face-attribute 'vertico-current nil :background "dark grey"))

;; (require 'treesit)
;; (setq treesit-extra-load-path (list  (expand-file-name "tree-sitter-module/dist/" user-emacs-directory)))

;; (use-package treesit-auto
;;   :config
;;   (global-treesit-auto-mode))

;; (use-package highlight-symbol
;;   :ensure t
;;   :init
;;   (setq highlight-symbol-idle-delay 0)
;;   (add-hook 'prog-mode-hook 'highlight-symbol-mode))

(use-package treemacs)
(treemacs-resize-icons 15)

(use-package writeroom-mode)

(use-package fancy-narrow)

(use-package general
  :after evil
  :config
  (general-create-definer global/leader-key
    :keymaps '(normal insert visual emacs dashboard-mode-map)
    :prefix "SPC"
    :global-prefix "M-SPC")
  (general-create-definer normal/g
    :keymaps '(normal)
    :prefix "g"))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  ;; (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  ;; (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-numbers)

(evil-set-undo-system 'undo-redo)

(modify-syntax-entry ?_ "w")

(with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol)
    ;; make evil-search-word look for symbol rather than word boundaries
    (setq-default evil-symbol-word-search t))

(use-package evil-snipe)
(evil-snipe-mode 1)
(evil-snipe-override-mode 1)
(setq evil-snipe-scope 'whole-visible)

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(setq evil-want-integration t) ;; This is optional since it's already set to t by default.
(setq evil-want-keybinding nil)
(require 'evil)
(when (require 'evil-collection nil t)
  (evil-collection-init))

(use-package evil-org)

(use-package which-key
      :defer 0
      :diminish which-key-mode
      :config
      (which-key-mode)
      (setq which-key-idle-delay 0.1)
      (which-key-setup-side-window-bottom))

(setq which-key-popup-type 'side-window)
(setq which-key-min-display-lines 5)

(use-package xwwp
  :load-path "~/.config/emacs/xwwp"
  :bind (:map xwidget-webkit-mode-map
              ("v" . xwwp-follow-link)
              ("t" . xwwp-ace-toggle)))

(use-package evil-goggles
  :ensure t
  :config
  (setq evil-goggles-duration 0.1) 
  (evil-goggles-mode))

(use-package vertico
  :bind (:map vertico-map
         ("C-j" . vertico-next)
         ("C-k" . vertico-previous)
         ("C-f" . vertico-exit)
         :map minibuffer-local-map
         ("M-h" . dw/minibuffer-backward-kill))
  :custom
  (vertico-cycle t)
  :custom-face
  (vertico-current ((t (:background "#3a3f5a"))))
  :init
  (vertico-mode))

(use-package corfu
  :after vertico
  :bind (:map corfu-map
	      ("C-j" . corfu-next)
	      ("C-k" . corfu-previous)
	      ("C-f" . corfu-insert))
  :custom
  (corfu-cycle t)
  (corfu-auto t)                 ;; Enable auto completion
  :init
  (global-corfu-mode))

(use-package orderless
      :init
      (setq completion-styles '(orderless)
            completion-category-defaults nil
            completion-category-overrides '((file (styles . (partial-completion))))))

(defun dw/get-project-root ()
  (when (fboundp 'projectile-project-root)
    (projectile-project-root)))

(use-package consult
  :demand t
  :bind (("C-s" . consult-line)
         ("C-M-l" . consult-imenu)
         ("C-M-j" . persp-switch-to-buffer*)
         :map minibuffer-local-map
         ("C-r" . consult-history))
  :config
  (setq consult-async-min-input 0)
  :custom
  (consult-project-root-function #'dw/get-project-root)
  (completion-in-region-function #'consult-completion-in-region))

(setq xref-show-xrefs-function #'consult-xref
      xref-show-definitions-function #'consult-xref)
(setq consult-async-input-threshold 0)
(use-package consult-dir)
(use-package consult-org-roam)
(use-package consult-projectile)

(use-package marginalia
  :after vertico
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package embark-consult)
    (use-package embark
      :bind (("C-." . embark-act)
             :map minibuffer-local-map
             ("C-." . embark-act))
      :init

      ;; Show Embark actions via which-key
      (setq embark-action-indicator
            (lambda (map)
              (which-key--show-keymap "Embark" map nil nil 'no-paging)
              #'which-key--hide-popup-ignore-command)
            embark-become-indicator embark-action-indicator))

(defun my/embark-act-show-help (&rest _args)
  "Automatically show Embark action help after invoking `embark-act'."
  (embark-help-key))

(advice-add 'embark-act :after #'my/embark-act-show-help)

(use-package quickrun)

(use-package rust-mode)

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l"))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

;; (use-package dumb-jump)
  ;; (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
  ;; (setq xref-show-definitions-function #'xref-show-definitions-completing-read)

(use-package dumb-jump
  :ensure t
  :demand t
  :custom
  (xref-show-definitions-function #'consult-xref)
  (setq dumb-jump-force-searcher 'rg)
  :init
  (setq dumb-jump-force-searcher 'rg)
  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))




  (defhydra dumb-jump-hydra (:color blue :columns 3)
    "Dumb Jump"
    ("j" dumb-jump-go "Go")
    ("o" dumb-jump-go-other-window "Other window")
    ("e" dumb-jump-go-prefer-external "Go external")
    ("x" dumb-jump-go-prefer-external-other-window "Go external other window")
    ("i" dumb-jump-go-prompt "Prompt")
    ("l" dumb-jump-quick-look "Quick look")
    ("b" dumb-jump-back "Back"))

(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; set faces for heading levels
  (dolist (face '((org-level-1 . 1.10)
                  (org-level-2 . 1.05)
                  (org-level-3 . 1.00)
                  (org-level-4 . 1.00)
                  (org-level-5 . 1.00)
                  (org-level-6 . 1.00)
                  (org-level-7 . 1.00)
                  (org-level-8 . 1.00)))
    (set-face-attribute (car face) nil  :weight 'semi-bold :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
   ;; (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
   ;; (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
   ;; (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
   ;; (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
   ;; (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
   ;; (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
   ;; (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
   ;; (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
   ;; (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
   ;; (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
   ;; (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch)
   )

(defun efs/org-mode-setup ()
  (visual-line-mode 1))

(use-package org
  :pin org
  :commands (org-capture org-agenda)
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
      (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-refile-targets
    '(("Archive.org" :maxlevel . 1)
      ("Tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (efs/org-font-setup))

(use-package org-bullets
:hook (org-mode . org-bullets-mode)
:custom
(org-bullets-bullet-list '(" " " " " " " " " " " " " ")))

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

;; (use-package visual-fill-column
;;   :hook (org-mode . efs/org-mode-visual-fill))

(with-eval-after-load 'org
   (org-babel-do-load-languages
       'org-babel-load-languages
       '((emacs-lisp . t)
       (python . t)))

   (push '("conf-unix" . conf-unix) org-src-lang-modes))

(with-eval-after-load 'org
  ;; This is needed as of Org 9.2
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python")))

(use-package org-roam)
(add-to-list 'display-buffer-alist
             '("\\*org-roam\\*"
               (display-buffer-in-direction)
               (direction . right)
               (window-width . 0.33)
               (window-height . fit-window-to-buffer)))

(setq org-hide-emphasis-markers t)
(setq org-insert-heading-respect-content nil)
(setq org-roam-directory "~/org/roam")

(defun hell/generate-init-el ()
  "Automatically tangle our Emacs Org config when we save the Org file."
  (let ((org-file (expand-file-name "init.org" user-emacs-directory))
        (el-file (expand-file-name "init.el" user-emacs-directory)))
    (when (string-equal (buffer-file-name) org-file)
      (org-babel-tangle-file org-file el-file))))

(add-hook 'org-mode-hook
          (lambda ()
            (add-hook 'after-save-hook #'hell/generate-init-el nil 'make-it-local)))

(set-face-attribute 'variable-pitch nil :family "Deja Vu Sans" :height 130)
(set-face-attribute 'org-block nil :inherit 'default)

(defun hell/grep-edit()
  (interactive)
  (when (cl-search "Ripgrep" (buffer-string))
    (run-at-time 0 nil #'embark-export)
    (run-at-time 0 nil #'wgrep-change-to-wgrep-mode)))

(defun hell/load-my-init-file ()
  "Load the new init file."
  (interactive)
  (let ((init-file (expand-file-name "init.el" user-emacs-directory)))
    (if (file-readable-p init-file)
        (load-file init-file)
      (message "Init file not found: %s" init-file))))

(defun hell/open-init-org ()
  "Open the org file of which the init file is generated from"
  (interactive)
  (find-file (expand-file-name "init.org" user-emacs-directory)))

(defun hell/yank-file-path ()
  "Yank the path to the current file"
  (interactive)
  (kill-new default-directory))

(unless (package-installed-p 'vc-use-package)
  (package-vc-install "https://github.com/slotThe/vc-use-package"))

(cl-defun slot/vc-install (&key (fetcher "github") repo name rev backend)
  "Install a package from a remote if it's not already installed.
This is a thin wrapper around `package-vc-install' in order to
make non-interactive usage more ergonomic.  Takes the following
named arguments:

- FETCHER the remote where to get the package (e.g., \"gitlab\").
  If omitted, this defaults to \"github\".

- REPO should be the name of the repository (e.g.,
  \"slotThe/arXiv-citation\".

- NAME, REV, and BACKEND are as in `package-vc-install' (which
  see)."
  (let* ((url (format "https://www.%s.com/%s" fetcher repo))
         (iname (when name (intern name)))
         (pac-name (or iname (intern (file-name-base repo)))))
    (unless (package-installed-p pac-name)
      (package-vc-install url iname rev backend))))

(defun hell/browse-package-files ()
  "Browse files of an installed package using Consult."
  (interactive)
  (let* ((pkg-list (mapcar #'car package-alist))
         (pkg-name (completing-read "Select package: " (mapcar #'symbol-name pkg-list) nil t))
         (pkg-desc-list (cdr (assoc (intern pkg-name) package-alist)))
         (pkg-desc (if (listp pkg-desc-list) (car pkg-desc-list) pkg-desc-list))
         (pkg-dir (if (package-desc-p pkg-desc) (package-desc-dir pkg-desc) nil)))
    (when pkg-dir
      (consult-fd pkg-dir))))

(defun hell/toggle-relative-line-numbers ()
  "Toggle relative line numbers."
  (interactive)
  (if display-line-numbers-mode
      (progn
        (setq display-line-numbers nil)
        (display-line-numbers-mode -1))
    (progn
      (setq display-line-numbers 'relative)
      (display-line-numbers-mode 1))))

(defmacro map-key (&rest key-command-pairs)
  "Define keybindings under the global leader key.
  KEY-COMMAND-PAIRS should be a sequence of (key command description) tuples."
  `(progn
     ,@(mapcar (lambda (pair)
                 `(global/leader-key
                    ,(car pair) '(,(cadr pair) :which-key ,(caddr pair))))
               key-command-pairs)))

;; Example 
;; (map-key("zz" eglot))
;; or
;; (map-key("zz" eglot "Start LSP"))

(defun hell/toggle-org-src-mode ()
  "Toggle between Org mode and Org source edit mode."
  (interactive)
  (if (bound-and-true-p org-src-mode)
      (org-edit-src-exit)
    (org-edit-special)))

(defun hell/search-cursor-word ()
  "Search for the word under the cursor using consult-ripgrep."
  (interactive)
  (consult-ripgrep nil (thing-at-point 'symbol t)))

(defun increase-font-size ()
  "Increase global font size."
  (interactive)
  (set-face-attribute 'default nil
                      :height (+ (face-attribute 'default :height) 5)))

(defun decrease-font-size ()
  "Decrease global font size."
  (interactive)
  (set-face-attribute 'default nil
                      :height (- (face-attribute 'default :height) 10)))

(defvar hell/line-numbers-were-on nil
  "Flag to remember if line numbers were on before toggling zen mode.")

(defun hell/zen-mode ()
  "Toggle writeroom-mode and relative line numbers."
  (interactive)
  ;; Toggle writeroom-mode
  (if (bound-and-true-p writeroom-mode)
      (progn
        (writeroom-mode -1)
        ;; Re-enable line numbers only if they were on
        (when hell/line-numbers-were-on
          (global-display-line-numbers-mode 1)))
    (progn
      ;; Store the current state of line numbers
      (setq hell/line-numbers-were-on (bound-and-true-p display-line-numbers-mode))
      (writeroom-mode 1)
      ;; Disable line numbers
      (global-display-line-numbers-mode -1))))

(defun hell/toggle-fancy-narrow ()
  "Toggle fancy-narrow on the selected region, or widen if already narrowed."
  (interactive)
  (if (fancy-narrow-active-p)
      (fancy-widen)
    (when (use-region-p)
      (fancy-narrow-to-region (region-beginning) (region-end)))))

(defun find-symbol-references ()
  "Find references of the symbol under the cursor."
  (interactive)
  (xref-find-references (thing-at-point 'symbol)))

(defun hell/open-project()
  "Open a new project using Projectile. If in dashboard, just switch project; otherwise, open in a new tab."
  (interactive)
  (let ((current-buffer (current-buffer))
        (in-dashboard (eq major-mode 'dashboard-mode)))
    ;; Create a new tab if not in the dashboard
    (unless in-dashboard
      (tab-new)
      (tabspaces-remove-selected-buffer current-buffer))
    ;; Try to switch to a new project using Projectile
    (condition-case nil
        (consult-projectile-switch-project)
      (quit
       ;; If project selection is aborted and a new tab was created, close it
       (unless in-dashboard
         (tab-close))))
    ;; Rename the tab to the name of the selected project
    (let ((project-name (projectile-project-name)))
      (when (and project-name (not (equal project-name "-")))
        (unless in-dashboard
          (tab-rename project-name))))))

  (setq tab-bar-new-button-show nil)
  (setq tab-bar-close-button-show nil)
  (setq tab-bar-auto-width-max '(110 10))

(defun hell/what-face (pos)
  (interactive "d")
  (let ((face (or (get-char-property pos 'read-face-name)
                  (get-char-property pos 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

(defun artist-mode-toggle-emacs-state ()
(interactive)
  (if artist-mode
      (evil-emacs-state)
    (evil-exit-emacs-state)))

(defun convert-hex-to-binary (hex-str)
  "Convert a hexadecimal string to a binary string."
  (let ((hex-map '("0000" "0001" "0010" "0011" "0100" "0101" "0110" "0111"
                   "1000" "1001" "1010" "1011" "1100" "1101" "1110" "1111"))
        binary-str)
    (dolist (char (append hex-str nil) binary-str)
      (setq binary-str (concat binary-str (nth (string-to-number (char-to-string char) 16) hex-map))))))

(defun convert-number-at-point ()
  "Toggle the number at point between decimal, hexadecimal, and binary."
  (interactive)
  (let* ((bounds (bounds-of-thing-at-point 'symbol))
         (num-str (buffer-substring-no-properties (car bounds) (cdr bounds)))
         (is-hex (string-match-p "^0x" num-str))
         (is-bin (string-match-p "^0b" num-str))
         (num (cond
               (is-hex (string-to-number (substring num-str 2) 16))
               (is-bin (string-to-number (substring num-str 2) 2))
               (t (string-to-number num-str)))))
    (cond
     (is-hex
      ;; Hexadecimal to binary
      (replace-regexp num-str (format "0b%s" (convert-hex-to-binary (substring num-str 2))) nil (car bounds) (cdr bounds)))
     (is-bin
      ;; Binary to decimal
      (replace-regexp num-str (format "%d" num) nil (car bounds) (cdr bounds)))
     (t
      ;; Decimal to hexadecimal
      (replace-regexp num-str (format "0x%X" num) nil (car bounds) (cdr bounds))))))

(defun my/org-mode-no-electric-pair-less-than ()
  "Prevent electric pair mode from pairing '<' in org-mode."
  (setq-local electric-pair-inhibit-predicate
              `(lambda (c)
                 (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c)))))

(add-hook 'org-mode-hook #'my/org-mode-no-electric-pair-less-than)

(with-eval-after-load 'consult
  (define-key minibuffer-mode-map (kbd "C-c C-e") #'hell/grep-edit))
  (define-key minibuffer-local-map (kbd "C-w") 'backward-kill-word)

(general-define-key
   :keymaps 'transient-base-map
   "<escape>" 'transient-quit-one)

(evil-define-key '(normal visual) 'global (kbd "C-a")
  'evil-numbers/inc-at-pt)
(evil-define-key '(normal visual) 'global (kbd "C-x")
  'evil-numbers/dec-at-pt)
(normal/g "r" 'find-symbol-references
  "d" 'xref-find-definitions
  "l" 'flycheck-)

(define-key evil-normal-state-map (kbd "C-b") #'convert-number-at-point)

(with-eval-after-load 'vertico
  (define-key vertico-map (kbd "C-h") (lambda () (interactive) (call-interactively 'backward-kill-word)))
  (define-key vertico-map (kbd "C-l") #'vertico-insert))

(define-key copilot-completion-map (kbd "C-j") 'copilot-accept-completion)

(global/leader-key
  "<tab>"  '(:ignore t :which-key "workspace")
  "w"  '(:ignore t :which-key "window")
  "g"  '(:ignore t :which-key "Git")
  "t"  '(:ignore t :which-key "toggles")
  "f"  '(:ignore t :which-key "file")
  "b"  '(:ignore t :which-key "buffer")
  "p"  '(:ignore t :which-key "project")
  "h"  '(:ignore t :which-key "help")
  "a"  '(:ignore t :which-key "align")
  "c"  '(:ignore t :which-key "code")
     "s"  '(:ignore t :which-key "search")
  "n"  '(:ignore t :which-key "Notes/Org")
  "o"  '(:ignore t :which-key "open")
  )

(global/leader-key
  "j" 'consult-imenu
  "J" 'consult-imenu-multi
  "I" #'hell/load-my-init-file
  ";" 'execute-extended-command)
(map-key ("*" hell/search-cursor-word "Search for symbol"))
(map-key ("/" consult-line "Search in file"))
(map-key ("P" consult-yank-pop "Paste from kill-ring"))
(map-key ("SPC" consult-buffer "switch buffer"))

(map-key ("gg" magit "Git-status"))
(map-key ("gb" magit-blame-addition "blame"))
(map-key ("gl" magit-log-all "log"))
(map-key ("gr" magit-reflog-head "reflog"))

(global/leader-key
  "ts" '(hydra-text-scale/body :which-key "scale text")
  "tt" 'vterm-toggle
  "tl" 'hell/toggle-relative-line-numbers)
(map-key ("tf" treemacs "File-tree"))
(map-key ("tc" flyspell-mode "spell correction"))
(map-key ("tz" hell/zen-mode "Zen mode"))
(map-key ("tn" hell/toggle-fancy-narrow "Narrow region"))

(global/leader-key
  "aa" 'align
  "ae" 'align-entire
  "ar" 'align-regexp)

(global/leader-key
  "ff" 'find-file
  "fr" 'recentf
  "fi" 'hell/open-init-org
  "fp" 'hell/yank-file-path
  )
(map-key ("fP" hell/browse-package-files "open Package file"))
(map-key ("ft" treemacs))
(map-key ("fs" consult-projectile-find-file "Find project file"))
(map-key ("fw" evil-write "write file"))

(global/leader-key
  "be" 'eval-buffer)

(map-key ("bp" previous-buffer "previous buffer"))
(map-key ("bn" next-buffer "next buffer"))
(map-key ("bb" consult-buffer "switch buffer"))
(map-key ("bd" kill-this-buffer "kill buffer"))
(map-key ("bD" tabspaces-clear-buffers "Kill other buffers"))

(global/leader-key
  "wl" 'evil-window-right
  "wh" 'evil-window-left
  "wj" 'evil-window-down
  "wk" 'evil-window-up
  "wv" 'evil-window-vsplit
  "ws" 'evil-window-split
  "wq" 'evil-quit
  "wL" 'evil-window-move-far-right
  "wH" 'evil-window-move-far-left
  "wJ" 'evil-window-move-very-bottom
  "wK" 'evil-window-move-very-top
  )

(map-key ("ww" tabspaces-switch-or-create-workspace "Switch workspace"))
(map-key ("wS" tabspaces-save-session "Save session"))
(map-key ("wr" tabspaces-restore-session "Restore session"))
(map-key ("wn" tab-next "next workspace"))
(map-key ("wp" tab-previous "previous workspace"))
(map-key ("w<tab>" evil-switch-to-windows-last-buffer "last buffer"))

(global/leader-key
  "hb" 'embark-bindings
  "hf" 'describe-function
  "hk" 'describe-keymap
  "hi" 'info
  "hv" 'describe-variable
  "hp" 'describe-package)
(map-key ("hm" describe-mode))
(map-key ("hM" man "Man pages"))

(global/leader-key
  "nf" 'org-roam-node-find
  "ni" 'org-roam-node-insert
  "nb" 'org-roam-buffer-toggle
  "nc" 'org-roam-capture)
(map-key ("ne" hell/toggle-org-src-mode "Edit source block"))

(global/leader-key
  "cx" '(consult-flymake :which-key "Errors/diagnostics")
  "ca" 'eglot-code-action
  "cc" 'evilnc-comment-or-uncomment-lines
  "cC" 'compile
  "cp" '(evilnc-comment-or-uncomment-paragraphs :which-key "comment paragraph")
  "cy" '(evilnc-copy-and-comment-lines :which-key "Yank and comment")
  "ce" '(quickrun :which-key "Evaluate code")
  "cE" '(quickrun :which-key "Evaluate code on save")
  "cu" 'lsp-ui-mode
  "cd" '(xref-find-definitions :which-key "Find definition")
  "cr" '(xref-find-references :which-key "Find references"))

(map-key ("pp" hell/open-project "Open Project"))
(map-key ("pf" consult-projectile-find-file "Find project file"))
(map-key ("pr" consult-projectile-recent "Recent project file"))
(map-key ("pa" projectile-add-known-project "add project"))

(map-key ("ss" consult-ripgrep "Search (ripgrep)"))
(map-key ("sf" consult-fd "Search for file"))
(map-key ("sb" consult-line "Search in buffer"))
(map-key ("sd" consult-dir "Search file in dir"))

(map-key ("op" pomidor "Pomidor"))
(map-key ("od" dashboard-open "dashboard"))
(map-key ("ot" projectile-run-vterm "dashboard"))


(defun my/org-mode-setup ()
  "Custom setup for org-mode, avoiding recursive activation."
  (unless (bound-and-true-p org-margin-mode)
    (org-margin-mode))
  (unless (bound-and-true-p nano-mode)
    (nano-mode)))

(add-hook 'org-mode-hook 'my/org-mode-setup)

(use-package jenkinsfile-mode)

(setq ring-bell-function 'ignore)

(add-to-list 'auto-mode-alist
             '("\\.jenkins\\'" . (lambda ()
                               (jenkinsfile-mode)
                               (insert "OK")
                               (turn-on-orgtbl))))

(use-package org-jira)
(setq jiralib-url "https://sdlc.electrolux.com/")
(window-divider-mode -1)

(org-roam-db-autosync-enable)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("81f53ee9ddd3f8559f94c127c9327d578e264c574cda7c6d9daddaec226f87bb" "7964b513f8a2bb14803e717e0ac0123f100fb92160dcf4a467f530868ebaae3e" "d6b934330450d9de1112cbb7617eaf929244d192c4ffb1b9e6b63ad574784aad" "88f7ee5594021c60a4a6a1c275614103de8c1435d6d08cc58882f920e0cec65e" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

