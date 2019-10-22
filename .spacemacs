;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation t
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
     (c-c++ :variables c-c++-enable-clang-support t)
     python
     themes-megapack
     gtags
     haskell
     helm
     rust
     latex
     nlinum
     (evil-snipe :variables evil-snipe-enable-alternate-f-and-t-behaviors t)
     ;; better-defaults
     emacs-lisp
     theming
     git
     slack
     (syntax-checking :variables syntax-checking-enable-by-default nil)
     (auto-completion :variables
                      auto-completion-return-key-behavior 'complete
                      auto-completion-tab-key-behavior 'cycle
                      auto-completion-complete-with-key-sequence nil
                      auto-completion-complete-with-key-sequence-delay 0.2
                      auto-completion-private-snippets-directory nil)

     org
     semantic
     ;; markdown
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     ;; spell-checking
     ;; syntax-checking
     ;; version-control
     )

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '()
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(vi-tilde-fringe)
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))
(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update t
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   dotspacemacs-startup-buffer-responsive t
   dotspacemacs-scratch-mode 'text-mode

   ; Theme
   dotspacemacs-themes '(zenburn
                         darktooth
                         spacemacs-light
                         )
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("Hack"
                               :size 12
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-ex-command-key ":"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-remap-Y-to-y$ nil
   dotspacemacs-retain-visual-state-on-shift t
   dotspacemacs-visual-line-move-text nil
   dotspacemacs-ex-substitute-global nil
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 95
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 95
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; (default nil)
   dotspacemacs-line-numbers '(:relative t :disabled-for-modes org-mode)


   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."

  ;; (setq org-directory  "~/org")
  ;; (setq org-default-notes-file ( concat org-directory "/notes.org"))
  ;; (setq org-agenda-files '("~/org"))


  )

(defun dotspacemacs/user-config ()

  ;; ------------------------------------------------------------------------------------
  ;;Theming

  (setq theming-modifications '(
                                (darktooth
                                 (org-level-1 :foreground "DarkSlateGray3" )
                                 (font-lock-face :foreground "DarkSalmon" )
                                 (font-lock-function-name-face :foreground "PaleVioletRed2")
                                 (font-lock-string-face :foreground "light salmon")
                                 (font-lock-preprocessor-face :foreground "light coral")
                                 (font-lock-keyword-face :foreground "DarkSalmon")
                                 (font-lock-variable-name-face :foreground "NavajoWhite")
                                 (spacemacs-insert :foreground "#3E3D31")
                                 (spaceline-evil-insert :foreground "DarkGoldenrod2")
                                 (spacemacs-insert-face :foreground "DarkGoldenrod2")
                                 (default :background "#363333") ;;252222
                                 (fringe :background "#363333")  ;;252222
                                 (default :foreground "AntiqueWhite3")
                                                      ;; :background "#272222"))
                                 ;; (defult :background "#272222")

                                 (org-level-1 :foreground "wheat" :height 1.6 :family "EtBembo" :slant normal
                                              :Underline nil :weight normal)
                                 (org-level-2 :foreground "NavajoWhite" :height 1.4 :family "EtBembo" :slant normal
                                              :Underline nil :weight normal)
                                 (org-level-3 :foreground "NavajoWhite" :height 1.3 :family "EtBembo" :slant normal
                                              :underline nil :weight normal)
                                 (org-level-4 :foreground "NavajoWhite" :height 1.2 :family "EtBembo" :slant normal
                                              :underline nil :weight normal)
                                 (org-level-5 :foreground "NavajoWhite" :height 1.1 :family "EtBembo" :slant normal
                                              :underline nil :weight normal)
                                 (org-level-6 :foreground "NavajoWhite" :height 1.0 :family "EtBembo" :slant normal
                                              :underline nil :weight normal)
                                 (org-level-7 :foreground "NavajoWhite" :height 1.0 :family "EtBembo" :slant normal
                                              :underline nil :weight normal)
                                 (org-level-8 :foreground "NavajoWhite" :height 1.0 :family "EtBembo" :slant normal
                                              :underline nil :weight normal)
                                 (org-table :foreground "NavajoWhite" :height 1.0)
                                 (org-document-title :height 1.8 :weight normal :foreground "wheat" :family "EtBembo")
                                 (org-document-info :height 1.8 :weight normal :foreground "gray" :family "EtBembo")
                                 (org-headline-done :strike-through t :family "EtBembo")
                                 (org-table :family "serif-mono-font" :background "#252222" :height 0.9 :foreground "bg-white")
                                 (org-ellipsis :foreground "doc" :underline nil)
                                 (org-tag :foreground "doc")
                                 (org-agenda-done :strike-through t :foreground "doc")
                                 (org-scheduled-previously :foreground "slate")
                                 (org-scheduled-today :foreground "fg-white")
                                 (org-scheduled :foreground "wheat")
                                 (org-upcoming-deadline :foreground "keyword")
                                 (org-agenda-structure :height 1.3 :foreground "doc" :weight normal)
                                 (org-agenda-date :foreground "doc" :height 1.1)
                                 (org-agenda-date-today :foreground "keyword" :height 1.5)
                                 (org-agenda-date-weekend :inherit org-agenda-date)
                                  (org-latex-overlay :height 1.1)
                                  (org-default :family "EtBembo" :height 2.3)
                                  (default :background "#363333")
                                  (default :foreground "AntiqueWhite3")
                                  (font-lock-comment-face :foreground "tomato3")
                                  ;; (org-level-1 :foreground "DarkSlateGray3" )
                                  ;; (org-level-2 :foreground "salmon" :height 1.0)
                                  ;; (org-level-3 :foreground "plum3")
                                  ;; (org-table :foreground "light gray")
                                  )))

  ;; CHEAT-SH.el

    ;; ------------------------------------------------------------------------------------
    ;; ------------------------------------------------------------------------------------
    ;; ------------------------------------------------------------------------------------

  ;;; Code:

  (require 'url-vars)

  (defgroup cheat-sh nil
    "Interact with cheat.sh."
    :group 'docs)

  (defface cheat-sh-section
    '((t :inherit (bold font-lock-doc-face)))
    "Face used on sections in a cheat-sh output window."
    :group 'cheat-sh)

  (defface cheat-sh-caption
    '((t :inherit (bold font-lock-function-name-face)))
    "Face used on captions in the cheat-sh output window."
  :group 'cheat-sh)

(defcustom cheat-sh-list-timeout (* 60 60 4)
  "Seconds to wait before deciding the cached sheet list is \"stale\"."
  :type 'integer
  :group 'cheat-sh)

(defconst cheat-sh-url "http://cheat.sh/%s?T"
  "URL for cheat.sh.")

(defconst cheat-sh-user-agent "cheat-sh.el (curl)"
  "User agent to send to cheat.sh.
Note that \"curl\" should ideally be included in the user agent
string because of the way cheat.sh works.
cheat.sh looks for a specific set of clients in the user
agent (see https://goo.gl/8gh95X for this) to decide if it should
deliver plain text rather than HTML. cheat-sh.el requires plain
text.")

(defun cheat-sh-get (thing)
  "Get THING from cheat.sh."
  (let* ((url-request-extra-headers `(("User-Agent" . ,cheat-sh-user-agent)))
         (buffer (url-retrieve-synchronously (format cheat-sh-url (url-hexify-string thing)) t t)))
    (when buffer
      (with-current-buffer buffer
        (set-buffer-multibyte t)
        (setf (point) (point-min))
        (when (search-forward-regexp "^$" nil t)
          (buffer-substring (1+ (point)) (point-max)))))))

(defvar cheat-sh-sheet-list nil
  "List of all available sheets.")

(defvar cheat-sh-sheet-list-acquired nil
  "The time when variable `cheat-sh-sheet-list' was populated.")

(defun cheat-sh-sheet-list-cache ()
  "Return the list of sheets.
The list is cached in memory, and is considered \"stale\" and is
refreshed after `cheat-sh-list-timeout' seconds."
  (when (and cheat-sh-sheet-list-acquired
             (> (- (time-to-seconds) cheat-sh-sheet-list-acquired) cheat-sh-list-timeout))
    (setq cheat-sh-sheet-list nil))
  (or cheat-sh-sheet-list
      (let ((list (cheat-sh-get ":list")))
        (when list
          (setq cheat-sh-sheet-list-acquired (time-to-seconds))
          (setq cheat-sh-sheet-list (split-string list "\n"))))))

(defun cheat-sh-read (prompt)
  "Read input from the user, showing PROMPT to prompt them.
This function is used by some `interactive' functions in
cheat-sh.el to get the item to look up. It provides completion
based of the sheets that are available on cheat.sh."
  (completing-read prompt (cheat-sh-sheet-list-cache)))

(defun cheat-sh-decorate-all (buffer regexp face)
  "Decorate BUFFER, finding REGEXP and setting face to FACE."
  (with-current-buffer buffer
    (save-excursion
      (setf (point) (point-min))
      (while (search-forward-regexp regexp nil t)
        (replace-match (propertize (match-string 1) 'font-lock-face face) nil t)))))

(defun cheat-sh-decorate-results (buffer)
  "Decorate BUFFER with properties to highlight results."
  ;; "[Search section]"
  (cheat-sh-decorate-all buffer "^\\(\\[.*\\]\\)$"        'cheat-sh-section)
  ;; "# Result caption"
  (cheat-sh-decorate-all buffer "^\\(#.*\\)$"             'cheat-sh-caption)
  ;; "cheat-sh help caption:"
  (cheat-sh-decorate-all buffer "^\\([^[:space:]].*:\\)$" 'cheat-sh-caption))

;;;###autoload
(defun cheat-sh (thing)
  "Look up THING on cheat.sh and display the result."
  (interactive (list (cheat-sh-read "Lookup: ")))
  (let ((result (cheat-sh-get thing)))
    (if result
        (with-help-window "*cheat.sh*"
          (princ result)
          (cheat-sh-decorate-results standard-output))
      (error "Can't find anything for %s on cheat.sh" thing))))

;;;###autoload
(defun cheat-sh-region (start end)
  "Look up the text between START and END on cheat.sh."
  (interactive "r")
  (deactivate-mark)
  (cheat-sh (buffer-substring-no-properties start end)))

;;;###autoload
(defun cheat-sh-maybe-region ()
  "If region is active lookup content of region, otherwise prompt."
  (interactive)
  (call-interactively (if mark-active #'cheat-sh-region #'cheat-sh)))

;;;###autoload
(defun cheat-sh-help ()
  "Get help on using cheat.sh."
  (interactive)
> (cheat-sh ":help"))

;;;###autoload
(defun cheat-sh-list (thing)
  "Get a list of topics available on cheat.sh.
Either gets a topic list for subject THING, or simply gets a list
of all available topics on cheat.sh if THING is supplied as an
empty string."
  (interactive (list (cheat-sh-read "List sheets for: ")))
  (cheat-sh (format "%s/:list" thing)))

;;;###autoload
(defun cheat-sh-search (thing)
  "Search for THING on cheat.sh and display the result."
  (interactive "sSearch: ")
  (cheat-sh (concat "~" thing)))

;;;###autoload
(defun cheat-sh-search-topic (topic thing)
  "Search TOPIC for THING on cheat.sh and display the result."
  (interactive
   (list (cheat-sh-read "Topic: ")
         (read-string "Search: ")))
  (cheat-sh (concat topic "/~" thing)))

(provide 'cheat-sh)


(spacemacs/set-leader-keys "as" 'cheat-sh)

  ;; ------------------------------------------------------------------------------------
  ;; ------------------------------------------------------------------------------------
  ;; ------------------------------------------------------------------------------------
  ;; ------------------------------------------------------------------------------------



;;(setq internal-border-width 3)
  ;; bg 272222
  ;; foreground NavajoWhite

  ;; (default :background "#665140" :foreground "#fdf4c1")

  ;; ((darktooth (org-level-1 :foreground "DarkSlateGray3" )))

  ;; '(font-lock-keyword-face ((t (:foreground "sandy brown"))))
  ;; '(font-lock-preprocessor-face ((t (:inherit font-lock-builtin-face :foreground "light coral"))))
  ;; '(font-lock-string-face ((t (:foreground "light salmon"))))
  ;; '(org-level-1 ((t (:foreground "DarkSlateGray3" :height 89))))
  ;; '(org-level-2 ((t (:inherit bold :foreground "salmon" :height 1.0))))
  ;; '(org-level-3 ((t (:foreground "plum3"))))
  ;; '(org-table ((t (:foreground "light gray")))))

  ;; ------------------------------------------------------------------------------------
  ;; Optimizations.. kinda
  (setq helm-ag-base-command "ag nocolor -Q --nogroup")
  (setq dotspacemacs-mode-line-unicode-symbols nil)
  ;; ------------------------------------------------------------------------------------
  ;; Set aggresive indent mode
  (setq global-aggresive-indent-mode t)

  ;; ------------------------------------------------------------------------------------
  ;; switch to last buffer *terminal fix | non-working fix atm
  (setq persp-add-buffer-on-after-change-major-mode 'free)
  ;; ------------------------------------------------------------------------------------
  ;; Autocomplete-settings
  ;; (require 'auto-completion)
  (setq auto-completion-tab-behavior 'complete)
  (setq auto-completion-tab-key-behavior 'complete)

  ;; ;; ------------------------------------------------------------------------------------
  (require 'org-tempo)
  ;; ;; ------------------------------------------------------------------------------------

  (defun openTermInSplit ()
    "Open terminal in split window below"
    (interactive)
    (split-window-below)
    (evil-window-move-very-bottom)
     (term "/bin/bash"))

  ;; Custom keybindings
  (spacemacs/set-leader-keys "at" 'openTermInSplit)
  ;; ------------------------------------------------------------------------------------
  ;; ;;org

  ;; Use monospaced font faces in current buffer
  (defun my-buffer-face-mode-org ()
    "Sets a fixed width (monospace) font in current buffer"
    (interactive)
    ;; (setq buffer-face-mode-face '(:family "EtBembo" :height 100))
    (setq buffer-face-mode-face '(:family "monospace" :height 100))
    (setq left-margin-width 15)
    (setq right-margin-width 15)
    (buffer-face-mode))


  (require 'org)
  (setq org-directory "~/org"
        org-log-into-drawer 1
        org-default-notes-file (concat org-directory "/notes.org")
        org-agenda-files (list org-directory
                               (concat org-directory "/org"))
        org-startup-indented t
        org-hide-emphasis-markers t
        org-pretty-entities t
        org-ellipsis "  " ;; folding symbol
        org-agenda-block-separator ""
        org-fontify-whole-heading-line t
        org-fontify-done-headline t
        org-startup-with-latex-preview t
        org-hide-leading-stars t
        org-fontify-quote-and-verse-blocks t)

  ;; (setq org-bullets-bullet-list '("■" "◆" "▲" "▶"))
  (setq org-bullets-bullet-list '("•" "◆" "▲" "▶"))
  ;; (setq org-bullets-bullet-list '(""))

  (add-hook 'org-mode-hook 'my-buffer-face-mode-org)

  ;; ------------------------------------------------------------------------------------
  ;;padding
  (setq header-line-format " ")
  (setq-default left-margin-width 0 right-margin-width 0)
  (set-window-buffer nil (current-buffer))
  ;; (lambda () (progn
  ;;              (setq left-margin-width 2)
  ;;              (setq right-margin-width 2)
  ;;              (setq internal-border-width 5)
  ;;              (set-window-buffer nil (current-buffer))))

  ;; ------------------------------------------------------------------------------------
  ;; motion keys
  (setq avy-keys '(?a ?s ?d ?j ?k ?i ?w ?l ))

  ;; ------------------------------------------------------------------------------------
  ;; Golden-Ratio on
  (require 'golden-ratio)
  (spacemacs/toggle-golden-ratio-on)

  ;; ------------------------------------------------------------------------------------
  ;; set transparency
  (spacemacs/enable-transparency)

  ;; ------------------------------------------------------------------------------------
  ;; Mappings
  (define-key evil-normal-state-map "s" 'avy-goto-word-1)
  (define-key evil-normal-state-map (kbd "C-i") 'evil-jump-forward)
  (define-key evil-normal-state-map (kbd "C-s") 'evil-toggle-fold)
  (define-key evil-normal-state-map (kbd "C-k") 'evil-backward-section-begin)
  (define-key evil-normal-state-map (kbd "C-j") 'evil-forward-section-begin)
  (define-key evil-normal-state-map (kbd "SPC TAB") 'evil-switch-to-windows-last-buffer)
  (c-add-style "twos"
               '((c-basic-offset . 2)))

  (push '(other . "twos") c-default-style)
  ;;-------------------------------------------------------------------------------------
)
;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-safe-themes
   (quote
    ("88049c35e4a6cedd4437ff6b093230b687d8a1fb65408ef17bfcf9b7338734f6" default)))
 '(evil-want-Y-yank-to-eol nil)
 '(fci-rule-color "#383838" t)
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(org-agenda-files
   (quote
    ("~/progStuff/esp/ws8213b/main/notes.org" "/home/ohman/org/mySpacemacs.org" "/home/ohman/org/notes.org")))
 '(package-selected-packages
   (quote
    (intero hlint-refactor hindent helm-hoogle haskell-snippets flycheck-haskell company-ghci company-ghc ghc haskell-mode company-cabal cmm-mode company-auctex auctex-latexmk auctex toml-mode racer flycheck-rust cargo markdown-mode rust-mode flycheck-pos-tip pos-tip flycheck nlinum-relative nlinum evil-snipe stickyfunc-enhance srefactor slack emojify circe oauth2 websocket ht org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-mime org-download htmlize gnuplot spotify helm-spotify-plus multi hz-zenburn-theme stekene-theme material-theme-theme zenburn-theme zen-and-art-theme white-sand-theme underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme toxi-theme tao-theme tangotango-theme tango-plus-theme tango-2-theme sunny-day-theme sublime-themes subatomic256-theme subatomic-theme spacegray-theme soothe-theme solarized-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme seti-theme reverse-theme rebecca-theme railscasts-theme purple-haze-theme professional-theme planet-theme phoenix-dark-pink-theme phoenix-dark-mono-theme organic-green-theme omtose-phellack-theme oldlace-theme occidental-theme obsidian-theme noctilux-theme naquadah-theme mustang-theme monokai-theme monochrome-theme molokai-theme moe-theme minimal-theme material-theme majapahit-theme madhat2r-theme lush-theme light-soap-theme jbeans-theme jazz-theme ir-black-theme inkpot-theme heroku-theme hemisu-theme helm-gtags hc-zenburn-theme gruber-darker-theme grandshell-theme gotham-theme ggtags gandalf-theme flatui-theme flatland-theme farmhouse-theme exotica-theme espresso-theme dracula-theme django-theme darktooth-theme darkokai-theme darkmine-theme darkburn-theme dakrone-theme cyberpunk-theme color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized clues-theme cherry-blossom-theme busybee-theme bubbleberry-theme birds-of-paradise-plus-theme badwolf-theme apropospriate-theme anti-zenburn-theme ample-zen-theme ample-theme alect-themes afternoon-theme smeargle orgit magit-gitflow magit-popup helm-gitignore gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link evil-magit magit transient git-commit with-editor helm-company helm-c-yasnippet fuzzy company-statistics company auto-yasnippet yasnippet ac-ispell auto-complete yapfify pyvenv pytest pyenv-mode py-isort pip-requirements live-py-mode hy-mode dash-functional helm-pydoc cython-mode company-anaconda anaconda-mode pythonic disaster company-c-headers cmake-mode clang-format ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint indent-guide hydra lv hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation helm-themes helm-swoop helm-projectile projectile pkg-info epl helm-mode-manager helm-make helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist highlight evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu elisp-slime-nav dumb-jump f dash s diminish define-word column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core popup async)))
 '(pdf-view-midnight-colors (quote ("#FDF4C1" . "#282828")))
 '(pos-tip-background-color "#36473A")
 '(pos-tip-foreground-color "#FFFFC8")
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "#DCDCCC" :background "#3F3F3F" :family "Droid Sans Mono" :foundry "1ASC" :slant normal :weight normal :height 90 :width normal))))
 '(font-lock-comment-face ((t (:foreground "DodgerBlue1"))))
 '(font-lock-face ((t (:foreground "DarkSalmon"))))
 '(font-lock-function-name-face ((t (:foreground "PaleVioletRed2"))))
 '(font-lock-keyword-face ((t (:foreground "DarkSalmon"))))
 '(font-lock-preprocessor-face ((t (:foreground "light coral"))))
 '(font-lock-string-face ((t (:foreground "light salmon"))))
 '(font-lock-variable-name-face ((t (:foreground "NavajoWhite"))))
 '(fringe ((t (:background "#252222"))))
 '(org-agenda-date ((t (:foreground "doc" :height 1.1))))
 '(org-agenda-date-today ((t (:foreground "keyword" :height 1.5))) t)
 '(org-agenda-date-weekend ((t (:inherit org-agenda-date))))
 '(org-agenda-done ((t (:strike-through t :foreground "doc"))))
 '(org-agenda-structure ((t (:height 1.3 :foreground "doc" :weight normal))))
 '(org-default ((t (:family "EtBembo"))))
 '(org-document-info ((t (:height 1.8 :weight normal :foreground "gray" :family "EtBembo"))))
 '(org-document-title ((t (:height 1.8 :weight normal :foreground "wheat" :family "EtBembo"))))
 '(org-ellipsis ((t (:foreground "doc" :underline nil))))
 '(org-headline-done ((t (:strike-through t :family "EtBembo"))))
 '(org-hide ((t (:foreground "#252222"))))
 '(org-latex-overlay ((t (:height 1.1))))
 '(org-level-1 ((t (:foreground "DarkSlateGray3"))))
 '(org-level-2 ((t (:foreground "salmon" :height 1.0))))
 '(org-level-3 ((t (:foreground "plum3"))))
 '(org-level-4 ((t (:foreground "wheat" :height 1.2 :family "EtBembo" :slant normal :weight normal))))
 '(org-level-5 ((t (:foreground "wheat" :height 1.1 :family "EtBembo" :slant normal :weight normal))))
 '(org-level-6 ((t (:foreground "wheat" :height 1.0 :family "EtBembo" :slant normal :weight normal))))
 '(org-level-7 ((t (:foreground "wheat" :height 1.0 :family "EtBembo" :slant normal :weight normal))))
 '(org-level-8 ((t (:foreground "wheat" :height 1.0 :family "EtBembo" :slant normal :weight normal))))
 '(org-scheduled ((t (:foreground "wheat"))))
 '(org-scheduled-previously ((t (:foreground "slate"))))
 '(org-scheduled-today ((t (:foreground "fg-white"))))
 '(org-table ((t (:foreground "light gray"))))
 '(org-tag ((t (:foreground "doc"))))
 '(org-upcoming-deadline ((t (:foreground "keyword"))))
 '(spaceline-evil-insert ((t (:foreground "DarkGoldenrod2"))))
 '(spacemacs-insert ((t (:foreground "#3E3D31"))))
 '(spacemacs-insert-face ((t (:foreground "DarkGoldenrod2")))))
