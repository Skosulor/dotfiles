    (setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

  (setq evil-want-keybinding nil)
  (setq evil-want-integration t)
  (setq evil-want-C-u-delete t)
  (setq evil-undo-system 'undo-tree)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-w-delete t)
  (setq evil-want-Y-yank-to-eol t)
  (setq evil-want-C-i-jump nil)


(defmacro with-system (type &rest body)
        "Evaluate BODY if `system-type' equals TYPE."
        (declare (indent defun))
        `(when (eq system-type ',type)
           ,@body))

  (defmacro with-system-not (types &rest body)
    "Evaluate BODY if `system-type' is not one of the TYPES."
    (declare (indent defun))
    `(unless (member system-type ',types)
       ,@body))

(with-system-not (ms-dos windows-nt cygwin)
  (message "Not windows"))


  (with-system gnu/linux
        (message "On linux"))

    (with-system darwin
      (setq native-comp-async-report-warnings-errors nil)
      (message "On mac"))

    (with-system cygwin
      (message "On windows"))

    (with-system windows-nt
      (message "On windows"))

    (with-system ms-dos
      (message "On windows"))

(require 'package)

(setq package-archives '(("elpa" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("org" . "https://orgmode.org/elpa/")))

(package-refresh-contents)

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))


  ;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Auto package updating
(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

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

(use-package jenkinsfile-mode)
(use-package lua-mode)

(add-to-list 'auto-mode-alist
             '("\\.jenkins\\'" . (lambda ()
                                   (jenkinsfile-mode)
                                   (insert "OK")
                                   (turn-on-orgtbl))))

(require 'rcirc)
    (require 'erc)

    ;; Server configuration with explicit TLS for Libera Chat
    (setq rcirc-server-alist
          '(("irc.libera.chat" :port 6697 :encryption tls :nick "TripleO" :channels ("#c" "#emacs" "#linux"))))

  
(setq erc-server "irc.libera.chat"
      erc-nick "DoubleTrouble"
      erc-autojoin-channels-alist '(("libera.chat" "#emacs" "#c" "#linux"))
      erc-interpret-mirc-color t
      erc-hide-list '("JOIN" "PART" "QUIT"))

(setq ispell-program-name "aspell")
(setq ispell-dictionary "english") ;; Set the default dictionary
(setq ispell-extra-args '("--sug-mode=ultra" "--run-together" "--run-together-limit=9" "--run-together-min=2"))

(use-package ement)

(use-package ialign)

(use-package undo-tree)
  (global-undo-tree-mode)
  (setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist
      `(("." . ,(expand-file-name "undo" user-emacs-directory))))

(use-package dtrt-indent
  :ensure t
  :config
  (dtrt-indent-global-mode 1))

(setq ring-bell-function 'ignore)


(setq enable-recursive-minibuffers t)

(use-package wgrep
  :ensure t)

(with-system-not (ms-dos windows-nt cygwin)
  (use-package pdf-tools)
  (pdf-tools-install))


(use-package quelpa)
;(use-package quelpa-use-package)
;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package))

(setq truncate-lines t)
(set-default 'truncate-lines t)


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


(setq dashboard-items '((recents  . 10)
                        (projects . 10)))

(setq dashboard-startup-banner 'logo)


(use-package tab-jump-out
  :config
  (tab-jump-out-mode))
(electric-pair-mode 1)

(defvar efs/default-font-size 90)
(defvar efs/default-variable-font-size 110)

;; Make frame transparency overridable
(defvar efs/frame-transparency '(90 . 90))

(set-face-attribute 'default nil :family "Victor Mono" :height 110)

(use-package magit
  :commands magit-status
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package forge
  :after magit)

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))


(with-system-not (ms-dos windows-nt cygwin)
  (use-package vterm
    :ensure t)

  (with-system-not (ms-dos windows-nt cygwin)
    (use-package vterm-toggle)
    (setq vterm-toggle-fullscreen-p nil)
    (add-to-list 'display-buffer-alist
                 '((lambda (buffer-or-name _)
                     (let ((buffer (get-buffer buffer-or-name)))
                       (with-current-buffer buffer
                         (or (equal major-mode 'vterm-mode)
                             (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                   (display-buffer-reuse-window display-buffer-at-bottom)
                   ;;(display-buffer-reuse-window display-buffer-in-direction)
                   ;;display-buffer-in-direction/direction/dedicated is added in emacs27
                   ;;(direction . bottom)
                   ;;(dedicated . t) ;dedicated is supported in emacs27
                   (reusable-frames . visible)
                   (window-height . 0.3)))))

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
  :demand t
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

(use-package consult-flycheck)

  (use-package flycheck-hl-todo
    :ensure t
    :defer 5 ; Need to be initialized after the rest of checkers
    :config
    (flycheck-hl-todo-setup))

(use-package magit-todos
  :after magit
  :config (magit-todos-mode 1))

(use-package solaire-mode)
(solaire-global-mode 1)

(use-package devdocs)

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

(setq consult-grep-command "rg --null --line-buffered --color=never --max-columns=1000 --path-separator /   --smart-case --no-heading --line-number . -e ARG OPTS")

(use-package topsy)
(add-hook 'prog-mode-hook #'topsy-mode)

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

(setq-default mode-line-format nil) 
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package hydra
    :defer t)

  (defhydra hydra-text-scale (:timeout 4)
    "scale text"
    ("j" decrease-font-size "out")
    ("k" increase-font-size "out")
    ("f" nil "finished" :exit t))

(defhydra hydra-window-resize (:color red)
  "Resize window"
  ("h" (shrink-window-horizontally 2) "shrink horizontally")
  ("l" (enlarge-window-horizontally 2) "enlarge horizontally")
  ("j" (enlarge-window 2) "enlarge vertically")
  ("k" (shrink-window 2) "shrink vertically")
  ("q" nil "quit" :color blue))

(unless (package-installed-p 'emacs-themes)
  (package-vc-install '(emacs-themes :url "https://github.com/skosulor/emacs-themes")))

(use-package everforest-theme
  :straight (:host github :type git :repo "Theory-of-Everything/everforest-emacs" ))

(use-package catppuccin-theme)
(setq catppuccin-flavor 'frappe) ;; or 'latte, 'macchiato, or 'mocha

;; (load-theme 'everforest-hard-dark t)
;; (load-theme 'catppuccin t)
(load-theme 'modus-vivendi t)
(setq nerd-icons-font-family "JetBrainsMono Nerd Font")

(set-frame-parameter nil 'alpha-background 90)
(add-to-list 'default-frame-alist '(alpha-background . 90))

(use-package treemacs)
(treemacs-resize-icons 15)

(use-package writeroom-mode)

;(use-package fancy-narrow)

(use-package beacon
:init
(beacon-mode 1))

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
    (setq-default evil-kill-on-visual-paste t)
    :config
    (evil-select-search-module 'evil-search-module 'evil-search)
    (evil-mode 1)
    (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
    (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
;
    ;; Use visual line motions even outside of visual-line-mode buffers
    ;; (evil-global-set-key 'motion "j" 'evil-next-visual-line)
    ;; (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

    (evil-set-initial-state 'messages-buffer-mode 'normal)
    (evil-set-initial-state 'dashboard-mode 'normal))

  (setq evil-want-keybinding nil)
  (use-package evil-collection
    :after evil
    :config
    (evil-collection-init))

  (use-package evil-numbers)

(use-package evil-lion
  :ensure t
  :config
  (evil-lion-mode))

(evil-set-undo-system 'undo-redo)

(modify-syntax-entry ?_ "w")

(with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol)
    ;; make evil-search-word look for symbol rather than word boundaries
    (setq-default evil-symbol-word-search t))

(setq avy-timeout-seconds 0.3)
(setq avy-keys '(?a ?r ?s ?s ?t ?n ?e ?i ?o))

;; Using avy-goto-char-timer instead of evil-snipe
(use-package evil-snipe)
(evil-snipe-mode 1)
(evil-snipe-override-mode 1)
(setq evil-snipe-scope 'whole-visible)

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 0))

(setq evil-want-integration t) ;; This is optional since it's already set to t by default.
(setq evil-want-keybinding nil)
(require 'evil)
(when (require 'evil-collection nil t)
  (evil-collection-init))

(use-package evil-org
    :ensure t)
(evil-org-set-key-theme '(navigation insert textobjects additional calendar))

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

(window-divider-mode -1)

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

(setq vertico-count 20)
(use-package vertico-posframe)
(vertico-posframe-mode 1)
;; (setq vertico-posframe-poshandler #'posframe-poshandler-frame-bottom-center)
(setq vertico-posframe-poshandler #'posframe-poshandler-frame-center)

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

(add-hook 'eshell-mode-hook
          (lambda ()
            (setq-local corfu-auto nil)
            (corfu-mode)))

(use-package cape
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  ;;(add-to-list 'completion-at-point-functions #'cape-history)
  ;;(add-to-list 'completion-at-point-functions #'cape-keyword)
  ;;(add-to-list 'completion-at-point-functions #'cape-tex)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
  ;;(add-to-list 'completion-at-point-functions #'cape-dict)
  ;;(add-to-list 'completion-at-point-functions #'cape-elisp-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-line)
)

(use-package orderless
        :init
        (setq completion-styles '(orderless)
              completion-category-defaults nil
              completion-category-overrides '((file (styles . (partial-completion))))))

  (defun dw/get-project-root ()
    (when (fboundp 'projectile-project-root)
      (projectile-project-root)))

;; (setq lsp-completion-provider :none)
;; (defun corfu-lsp-setup ()
;;   (setq-local completion-styles '(orderless)
;;               completion-category-defaults nil))
;; (add-hook 'lsp-mode-hook #'corfu-lsp-setup)

(use-package eglot
  :hook ((rust-mode nix-mode) . eglot-ensure)
  :config (add-to-list 'eglot-server-programs
                       `(rust-mode . ("rust-analyzer" :initializationOptions
                                     ( :procMacro (:enable t)
                                       :cargo ( :buildScripts (:enable t)
                                                :features "all"))))))

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
  (setq vertico-count 15)
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

(setq embark-prompter 'embark-completing-read-prompter)

(use-package quickrun)

(use-package rust-mode)

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l"))

;; (setq lsp-clients-clangd-args '("--header-insertion=never"))

;; load the pathnames to custom lisp files
(add-to-list 'load-path "~/.emacs.d/lisp/")
(load "ob-C.el")
(require 'ob-C)



;; (require 'lsp)
;(require 'lsp-haskell)
;; Hooks so haskell and literate haskell major modes trigger LSP setup
;; (add-hook 'haskell-mode-hook #'lsp)
;; (add-hook 'haskell-literate-mode-hook #'lsp)



(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'at-point))


(setq lsp-headerline-breadcrumb-enable nil)

(use-package dap-mode
  :ensure t)

(setq dap-auto-configure-features '(sessions locals controls tooltip))

(require 'dap-lldb)
(require 'dap-gdb-lldb)

(use-package realgud)
(use-package realgud-lldb)

(defhydra hydra-realgud (:color blue :hint nil)
  "
^Stepping^          ^Breakpoints^        ^Evaluate^
^^^^^^^^--------------------------------------------------
_n_: Next           _b_: Set             _e_: Evaluate
_s_: Step           _B_: Clear           _r_: Re-eval
_f_: Finish         _t_: Toggle          
_c_: Continue       _a_: Show All        
"
  ("n" realgud:cmd-next :exit nil)
  ("s" realgud:cmd-step :exit nil)
  ("f" realgud:cmd-finish :exit nil)
  ("c" realgud:cmd-continue :exit nil)
  ("b" realgud:cmd-break :exit nil)
  ("B" realgud:cmd-clear :exit nil)
  ("t" realgud:cmd-toggle-breakpoint :exit nil)
  ("a" realgud:cmd-breakpoints :exit nil)
  ("e" realgud:cmd-eval :exit nil)
  ("r" realgud:cmd-reval :exit nil))

(global-set-key (kbd "C-c d") 'hydra-realgud/body)

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

  ;; Set faces for heading levels
(dolist (face '((org-level-1 . 1.12)
                (org-level-2 . 1.07)
                (org-level-3 . 1.03)
                (org-level-4 . 1.00)
                (org-level-5 . 1.00)
                (org-level-6 . 1.00)
                (org-level-7 . 1.00)
                (org-level-8 . 1.00)))
  (set-face-attribute (car face) nil :foreground "#a9a1e1" :weight 'semi-bold :height (cdr face))))

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
   ;; (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))


(setq org-hide-leading-stars t)
(defun hell/org-mode-evil-enter ()
  (interactive)
  "Custom setup for org-mode."
  (local-set-key (kbd "RET") 'evil-org-return))

(add-hook 'org-mode-hook 'org-indent-mode)

(add-hook 'org-mode-hook (lambda ()
  (push '("[ ]" . "□") prettify-symbols-alist)
  (push '("[X]" . "■") prettify-symbols-alist)
  (prettify-symbols-mode 1)))

(add-hook 'org-mode-hook 'hell/org-mode-evil-enter)
(setq org-src-fontify-natively t
	  org-src-tab-acts-natively t
      org-edit-src-content-indentation 0)

;; (defun hell/org-mode-setup ()
;;   (hell/org-mode-evil-enter)
;;   (org-margin-mode 1)
;;   (org-evil-mode 1)
;;   (visual-line-mode 1))

(defun org-margin-mode ())
(use-package org
  :pin org
  :commands (org-capture org-agenda)
  :hook (org-mode . visual-line-mode)
  :hook (org-mode . evil-org-mode)
  :config
  (setq org-ellipsis " ▾")

  (setq org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
      (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (efs/org-font-setup))

;; (use-package org-bullets
;; :hook (org-mode . org-bullets-mode)
;; :custom
;; (org-bullets-bullet-list '(" " " " " " " " " " " " " ")))

;; (defun efs/org-mode-visual-fill ()
;;   (setq visual-fill-column-width 100
;;         visual-fill-column-center-text t)
;;   (visual-fill-column-mode 1))

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

(setq org-roam-directory "~/org/roam")
  (use-package org-roam)
  (add-to-list 'display-buffer-alist
               '("\\*org-roam\\*"
                 (display-buffer-in-direction)
                 (direction . right)
                 (window-width . 0.33)
                 (window-height . fit-window-to-buffer)))

(org-roam-db-autosync-enable)

(setq org-hide-emphasis-markers t)
(setq org-insert-heading-respect-content nil)

(defun hell/generate-init-el ()
  (interactive)
  "Automatically tangle our Emacs Org config when we save the Org file."
  (let ((org-file (expand-file-name "init.org" user-emacs-directory))
        (el-file (expand-file-name "init.el" user-emacs-directory)))
    (when (string-equal (file-name-nondirectory (buffer-file-name)) "init.org")
      (org-babel-tangle-file org-file el-file)
      ;; Ensure the file is named 'init.el'
      (when (file-exists-p (expand-file-name "Init.el" user-emacs-directory))
        (rename-file (expand-file-name "Init.el" user-emacs-directory) el-file t)))))

(add-hook 'org-mode-hook
	  (lambda ()
	    (add-hook 'after-save-hook #'hell/generate-init-el nil 'make-it-local)))

(set-face-attribute 'variable-pitch nil :family "Deja Vu Sans" :height 130)
;; (set-face-attribute 'org-block nil :family "Iosevka" :height 130)

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


(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))



(use-package c-ts-mode
  :ensure nil
  :init
  (add-hook 'c-ts-mode-hook
            (lambda ()
              (setq-local c-ts-mode-indent-style 'linux)
              (setq-local c-ts-mode-indent-offset 4)
              (c-ts-mode-toggle-comment-style 1))))


(use-package evil-textobj-tree-sitter :ensure t)
(define-key evil-outer-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.outer"))
(define-key evil-inner-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.inner"))
(define-key evil-outer-text-objects-map "v" (evil-textobj-tree-sitter-get-textobj "parameter.outer"))
(define-key evil-outer-text-objects-map "a" (evil-textobj-tree-sitter-get-textobj "parameter.outer"))
(define-key evil-inner-text-objects-map "a" (evil-textobj-tree-sitter-get-textobj "parameter.inner"))
(define-key evil-outer-text-objects-map "l" (evil-textobj-tree-sitter-get-textobj "loop.outer"))
(define-key evil-inner-text-objects-map "l" (evil-textobj-tree-sitter-get-textobj "loop.inner"))
(define-key evil-inner-text-objects-map "c" (evil-textobj-tree-sitter-get-textobj "conditional.inner"))
(define-key evil-outer-text-objects-map "c" (evil-textobj-tree-sitter-get-textobj "conditional.outer"))

(use-package treesitter-context
  :straight (:host github :type git :repo "zbelial/treesitter-context.el" )
  :init
  (use-package posframe-plus
    :straight (:host github :type git :repo "zbelial/posframe-plus" ))
  :config
  (treesitter-context-mode nil)
  (setq treesitter-context-background-color (face-attribute 'default :background))
  (setq treesitter-context-border-color "#FFFFFF")
  (setq treesitter-context-border-width 1)
  (setq treesitter-context-show-line-number nil)
  (setq treesitter-context-show-context-always t)
  (setq treesitter-context-idle-time 0.3)
  )

(with-eval-after-load 'consult
  (define-key minibuffer-mode-map (kbd "C-c C-e") #'hell/grep-edit))
  (define-key minibuffer-local-map (kbd "C-w") 'backward-kill-word)


(with-eval-after-load 'markdown-mode
  (define-key markdown-mode-map (kbd "<C-return>") 'markdown-insert-list-item))

(add-hook 'markdown-mdoe #'visual-line-mode)


(push '("[ ]" . "☐") prettify-symbols-alist)
(push '("[X]" . "☒") prettify-symbols-alist)
(push '("[x]" . "☒") prettify-symbols-alist)
(push '("[-]" . "▣") prettify-symbols-alist)
(prettify-symbols-mode 1)

(add-hook 'markdown-mode-hook (lambda ()
  (push '("[ ]" . "□") prettify-symbols-alist)
  (push '("[x]" . "☒") prettify-symbols-alist)
  (push '("[X]" . "■") prettify-symbols-alist)
  (prettify-symbols-mode 1)))

(use-package gptel)
(gptel-make-ollama "Ollama"             ;Any name of your choosing
  :host "localhost:11434"               ;Where it's running
  :stream t                             ;Stream responses
  :models '(deepseek-r1:7b
            deepseek-r1:1.5b
            deepseek-coder:6.7b))          ;List of models

(defun my-markdown-mode-hook ()
  "Enable visual line wrapping in Markdown mode."
  (visual-line-mode 1))

(add-hook 'markdown-mode-hook #'my-markdown-mode-hook)



(defun hell/toggle-catppuccin ()
  "Toggle Catppuccin themes."
  (interactive)
  (if (equal catppuccin-flavor 'frappe)
      (progn
        (setq catppuccin-flavor 'latte)
        (catppuccin-reload))
    (progn
      (setq catppuccin-flavor 'frappe)
      (catppuccin-reload))))

(setq vterm-max-scrollback 30000)

(use-package multi-vterm)

(setq vterm-timer-delay 0.01)

(defun hell/new-tab-vterm ()
  "Create a new tab and open a new vterm using multi-vterm."
  (interactive)
  (tab-new)  ; Create a new tab
  (multi-vterm))  ; Open a new vterm


;; Mappings

(general-define-key
   :keymaps 'transient-base-map
   "<escape>" 'transient-quit-one)

(define-key evil-normal-state-map "u" 'undo-tree-undo)

(define-key evil-normal-state-map "s" 'avy-goto-char-timer)
(define-key evil-normal-state-map (kbd "C-r") 'undo-tree-redo)

(define-key evil-normal-state-map (kbd "C-t") 'hell/new-tab-vterm)

(define-key evil-operator-state-map "s" nil)
(evil-define-key 'operator evil-operator-state-map
  "s" 'evil-avy-goto-char-timer)

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

;(define-key copilot-completion-map (kbd "C-j") 'copilot-accept-completion)

(define-key evil-insert-state-map (kbd "M-h") #'tab-previous)
(define-key evil-insert-state-map (kbd "M-n") #'tab-new)
(define-key evil-insert-state-map (kbd "M-l") #'tab-next)

(define-key evil-normal-state-map (kbd "M-h") #'tab-previous)
(define-key evil-normal-state-map (kbd "M-n") #'tab-new)
(define-key evil-normal-state-map (kbd "M-l") #'tab-next)

(define-key evil-normal-state-map (kbd "C-i") #'evil-jump-forward)

(define-key evil-visual-state-map (kbd "ga") #'evil-lion-left)

(define-key evil-normal-state-map (kbd "J") #'lsp-describe-thing-at-point)

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
  "d" 'hell/toggle-ca
  "J" 'consult-imenu-multi
  "I" #'hell/load-my-init-file
  ";" 'execute-extended-command)
(map-key ("*" hell/search-cursor-word "Search for symbol"))
(map-key ("e" eval-region "Eval region"))
(map-key ("<TAB>" vterm-toggle "Toggle terminal"))
(map-key ("/" consult-line "Search in file"))
(map-key ("P" consult-yank-pop "Paste from kill-ring"))
(map-key ("u" undo-tree-visualize "Undo tree"))
(map-key ("SPC" consult-buffer "switch buffer"))

(map-key ("gg" magit "Git-status"))
(map-key ("gB" vc-annotate "blame"))
(map-key ("gb" magit-branch "branch"))
(map-key ("gv" magit-find-file-other-window "visit file across branches"))
(map-key ("gl" magit-log-all "log"))
(map-key ("gr" magit-reflog-head "reflog"))
(map-key ("gd" magit-file-dispatch "dispatch file"))
(map-key ("gp" magit-push "push"))
(map-key ("gP" magit-pull-or-fetch "pull"))
(map-key ("gt" magit-log-trace-definition "trace (log) function at point"))
(map-key ("gf" magit-log-buffer-file "Git buffer log"))

;Switch to next vterm buffer
;(define-key vterm-mode-map (kbd "C-n")   'vterm-toggle-forward)
;Switch to previous vterm buffer
;(define-key vterm-mode-map (kbd "C-p")   'vterm-toggle-backward)

(global/leader-key
  "ts" '(hydra-text-scale/body :which-key "scale text")
  "tt" 'eshell-toggle
  "tl" 'hell/toggle-relative-line-numbers)
(map-key ("tf" treemacs "File-tree"))
(map-key ("tw" hydra-window-resize/body "Window resize"))
(map-key ("tc" flyspell-mode "spell correction"))
(with-system-not (ms-dos windows-nt cygwin)
  (map-key ("tt" vterm-toggle-cd "Toggle terminal")))
(map-key ("tz" hell/zen-mode "Zen mode"))
(map-key ("tn" hell/toggle-fancy-narrow "Narrow region"))

(global/leader-key
  "aa" 'align
  "am" 'gptel-menu
  "ac" 'gptel
  "ae" 'align-entire
  "ar" 'ialign)

(global/leader-key
  "ff" 'find-file
  "fr" 'recentf
  "fi" 'hell/open-init-org
  "fp" 'hell/yank-file-path
  )
(map-key ("fP" hell/browse-package-files "open Package file"))
(map-key ("ft" treemacs))
(map-key ("fl" consult-projectile-find-file "Find project file"))
(map-key ("fw" evil-write "write file"))

(global/leader-key
  "be" 'eval-buffer)

(map-key ("bp" previous-buffer "previous buffer"))
(map-key ("bn" next-buffer "next buffer"))
(map-key ("bb" consult-buffer "switch buffer"))
(map-key ("bd" kill-current-buffer "kill buffer"))
(map-key ("bD" tabspaces-clear-buffers "Kill other buffers"))

(global/leader-key
  "wl" 'evil-window-right
  "wh" 'evil-window-left
  "wj" 'evil-window-down
  "wk" 'evil-window-up
  "wv" 'evil-window-vsplit
  "ws" 'evil-window-split
  "wq" 'evil-quit
  "wt" 'tab-bar-move-window-to-tab
  "wL" 'evil-window-move-far-right
  "wH" 'evil-window-move-far-left
  "wJ" 'evil-window-move-very-bottom
  "wK" 'evil-window-move-very-top
  )

(map-key ("ww" tabspaces-switch-or-create-workspace "Switch workspace"))
(map-key ("wS" tabspaces-save-session "Save session"))
(map-key ("wr" tabspaces-restore-session "Restore session"))
(map-key ("wp" tab-previous "previous workspace"))
(map-key ("w<tab>" evil-switch-to-windows-last-buffer "last buffer"))

(global/leader-key
  "hb" 'embark-bindings
  "hf" 'describe-function
  "hK" 'describe-key
  "hk" 'describe-keymap
  "hi" 'info
  "hv" 'describe-variable
  "hp" 'describe-package)
(map-key ("hm" describe-mode))
(map-key ("hd" devdocs-lookup))
(map-key ("hM" man "Man pages"))
(map-key ("hV" set-variable "set Variable"))

(global/leader-key
  "nf" 'org-roam-node-find
  "ni" 'org-roam-node-insert
  "nb" 'org-roam-buffer-toggle
  "nc" 'org-roam-capture)
(map-key ("ne" hell/toggle-org-src-mode "Edit source block"))

(global/leader-key
  "cx" '(consult-flycheck :which-key "Errors/diagnostics")
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
(map-key ("ot" eshell "eshell"))

(set-frame-font "Iosevka 12" nil t)


(use-package gptel)

(defun load-if-exists (f)
  (if (file-exists-p (expand-file-name f))
      (load-file (expand-file-name f))))

(load-if-exists "~/.api_key.el")

(message "Enable colemak")



(defun hell/enable-colemak ()
  "Enable Colemak remappings in Evil mode."
  (interactive)
  ;; Normal state remaps
  (define-key evil-normal-state-map "n" 'evil-next-line)
  (define-key evil-normal-state-map "e" 'evil-previous-line)
  (define-key evil-normal-state-map "i" 'evil-forward-char)
  (define-key evil-normal-state-map "h" 'evil-backward-char)
  (define-key evil-normal-state-map "l" 'evil-insert)
  (define-key evil-normal-state-map "k" 'evil-ex-search-next)
  (define-key evil-normal-state-map "K" 'evil-ex-search-previous)
  (define-key evil-normal-state-map "j" 'evil-forward-word-end)

  (define-key evil-operator-state-map "l" evil-inner-text-objects-map)

  ;; Visual state remaps
  (define-key evil-visual-state-map "n" 'evil-next-line)
  (define-key evil-visual-state-map "e" 'evil-previous-line)
  (define-key evil-visual-state-map "i" 'evil-forward-char)
  (define-key evil-visual-state-map "h" 'evil-backward-char)
  (define-key evil-visual-state-map "l" evil-inner-text-objects-map)
  (define-key evil-visual-state-map "k" 'evil-ex-search-next)
  (define-key evil-visual-state-map "K" 'evil-ex-search-previous)
  (define-key evil-visual-state-map "j" 'evil-forward-word-end)
  ;; Motion state remaps (for text objects)
  (define-key evil-motion-state-map "n" 'evil-next-line)
  (define-key evil-motion-state-map "e" 'evil-previous-line)
  (define-key evil-motion-state-map "i" 'evil-forward-char)
  (define-key evil-motion-state-map "h" 'evil-backward-char)
  (define-key evil-motion-state-map "k" 'evil-ex-search-next)
  (define-key evil-motion-state-map "K" 'evil-ex-search-previous)

  (define-key evil-motion-state-map "j" 'evil-forward-word-end)

  (evil-define-key 'normal magit-mode-map
    "h" 'magit-section-backward
    "n" 'magit-next-line
    "e" 'magit-previous-line
    "i" 'magit-section-forward
    "j" 'magit-gitignore)

  (global/leader-key
    "wi" 'evil-window-right
    "wh" 'evil-window-left
    "wn" 'evil-window-down
    "we" 'evil-window-up
    "wv" 'evil-window-vsplit
    "ws" 'evil-window-split
    "wq" 'evil-quit
    "wt" 'tab-bar-move-window-to-tab
    "wI" 'evil-window-move-far-right
    "wH" 'evil-window-move-far-left
    "wN" 'evil-window-move-very-bottom
    "wE" 'evil-window-move-very-top
    )

(with-eval-after-load 'evil
  (with-eval-after-load 'dired
    ;; Define the remapping for 'normal' state in Dired mode
    (evil-define-key 'normal dired-mode-map
      (kbd "h") 'left-char
      (kbd "i") 'right-char
      (kbd "n") 'dired-next-line
      (kbd "e") 'dired-previous-line)))

  ;; Operator state remaps
  (define-key evil-operator-state-map "n" 'evil-next-line)
  (define-key evil-operator-state-map "e" 'evil-previous-line)
  (define-key evil-operator-state-map "i" 'evil-forward-char)
  (define-key evil-operator-state-map "h" 'evil-backward-char)

  (define-key evil-normal-state-map (kbd "M-i") #'tab-next)
  (define-key evil-insert-state-map (kbd "M-i") #'tab-next))

(defun hell/disable-colemak ()
  "Disable Colemak remappings and restore default Evil bindings."
  (interactive)
  ;; Normal state restore
  (define-key evil-normal-state-map "j" 'evil-next-line)
  (define-key evil-normal-state-map "k" 'evil-previous-line)
  (define-key evil-normal-state-map "l" 'evil-forward-char)
  (define-key evil-normal-state-map "h" 'evil-backward-char)
  (define-key evil-normal-state-map "i" 'evil-insert)
  (define-key evil-normal-state-map "n" 'evil-ex-search-next)
  (define-key evil-normal-state-map "N" 'evil-ex-search-previous)
  (define-key evil-normal-state-map "e" 'evil-forward-word-end)

  (define-key evil-operator-state-map "i" evil-inner-text-objects-map)
  (define-key evil-visual-state-map "l" evil-inner-text-objects-map)

  ;; Visual state remaps
  (define-key evil-visual-state-map "j" 'evil-next-line)
  (define-key evil-visual-state-map "k" 'evil-previous-line)
  (define-key evil-visual-state-map "l" 'evil-forward-char)
  (define-key evil-visual-state-map "h" 'evil-backward-char)
  (define-key evil-visual-state-map "i" 'evil-insert)
  (define-key evil-visual-state-map "n" 'evil-ex-search-next)
  (define-key evil-visual-state-map "N" 'evil-ex-search-previous)
  (define-key evil-visual-state-map "e" 'evil-forward-word-end)
  ;; Motion state remaps (for text objects)
  (define-key evil-motion-state-map "j" 'evil-next-line)
  (define-key evil-motion-state-map "k" 'evil-previous-line)
  (define-key evil-motion-state-map "l" 'evil-forward-char)
  (define-key evil-motion-state-map "h" 'evil-backward-char)
  (define-key evil-motion-state-map "n" 'evil-ex-search-next)
  (define-key evil-motion-state-map "N" 'evil-ex-search-previous)

  (define-key evil-motion-state-map "e" 'evil-forward-word-end)

  (evil-define-key 'normal magit-mode-map
    "h" 'magit-section-backward
    "j" 'magit-next-line
    "k" 'magit-previous-line
    "l" 'magit-section-forward)

  (global/leader-key
    "wl" 'evil-window-right
    "wh" 'evil-window-left
    "wj" 'evil-window-down
    "wk" 'evil-window-up
    "wv" 'evil-window-vsplit
    "ws" 'evil-window-split
    "wq" 'evil-quit
    "wt" 'tab-bar-move-window-to-tab
    "wL" 'evil-window-move-far-right
    "wH" 'evil-window-move-far-left
    "wJ" 'evil-window-move-very-bottom
    "wK" 'evil-window-move-very-top
    )

(with-eval-after-load 'evil
  (with-eval-after-load 'dired
    ;; Define the remapping for 'normal' state in Dired mode
    (evil-define-key 'normal dired-mode-map
      (kbd "h") 'left-char
      (kbd "j") 'right-char
      (kbd "k") 'dired-next-line
      (kbd "l") 'dired-previous-line)))

  ;; Operator state remaps
  (define-key evil-operator-state-map "j" 'evil-next-line)
  (define-key evil-operator-state-map "k" 'evil-previous-line)
  (define-key evil-operator-state-map "k" 'evil-forward-char)
  (define-key evil-operator-state-map "h" 'evil-backward-char)
  (define-key evil-normal-state-map (kbd "M-l") #'tab-next)
  (define-key evil-insert-state-map (kbd "M-l") #'tab-next))


(message "Custom-set-variables")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("57be445bbd705240c10b49915783b44ac05ae7ad1f710d241b9fb6a4a89dfc02" "9f1c593abc996917c24f563e68f44bb4175d4419925577014757f6ba2dfe2850" "7faf118c5f84a233f63dfafddfe04cd1cfb011728589192f29ced2bdc465b527" "e3daa8f18440301f3e54f2093fe15f4fe951986a8628e98dcd781efbec7a46f2" "87adaa6ee5799b9116c2bbdcf2109efe44d9102d23ebc0ec1c3d75b95ffa50b5" "23ee873f9287867e371f4215536e3a83436c732db44e271ab51c9333c2add543" "d2ab3d4f005a9ad4fb789a8f65606c72f30ce9d281a9e42da55f7f4b9ef5bfc6" "c20728f5c0cb50972b50c929b004a7496d3f2e2ded387bf870f89da25793bb44" "daa27dcbe26a280a9425ee90dc7458d85bd540482b93e9fa94d4f43327128077" default))
 '(package-vc-selected-packages
   '((everforest-theme :vc-backend Git :url "https://git.sr.ht/~theorytoe/everforest-theme")
     (vc-use-package :vc-backend Git :url "https://github.com/slotThe/vc-use-package")
     (emacs-themes :url "https://github.com/skosulor/emacs-themes"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
