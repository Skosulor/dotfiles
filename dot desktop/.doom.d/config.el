;;; .doom.d/config.el -*- lexical-binding: t; -*-

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


(set 'haskell-interactive-popup-errors nil)

(eval-after-load "flyspell"
  '(defun flyspell-mode (&optional arg)))





;; Splash screen

(defvar fancy-splash-image-template
  (expand-file-name "~/Pictures/splash-images/blackhole-lines-template.svg" doom-private-dir)
  "Default template svg used for the splash image, with substitutions from ")
(defvar fancy-splash-image-nil
  (expand-file-name "~/Pictures/splash-images/transparent-pixel.png" doom-private-dir)
  "An image to use at minimum size, usually a transparent pixel")

(setq fancy-splash-sizes
      `((:height 500 :min-height 50 :padding (0 . 4) :template ,(expand-file-name "~/Pictures/splash-images/blackhole-lines-0.svg" doom-private-dir))
        (:height 440 :min-height 42 :padding (1 . 4) :template ,(expand-file-name "~/Pictures/splash-images/blackhole-lines-0.svg" doom-private-dir))
        (:height 400 :min-height 38 :padding (1 . 4) :template ,(expand-file-name "~/Pictures/splash-images/blackhole-lines-1.svg" doom-private-dir))
        (:height 350 :min-height 36 :padding (1 . 3) :template ,(expand-file-name "~/Pictures/splash-images/blackhole-lines-2.svg" doom-private-dir))
        (:height 300 :min-height 34 :padding (1 . 3) :template ,(expand-file-name "~/Pictures/splash-images/blackhole-lines-3.svg" doom-private-dir))
        (:height 250 :min-height 32 :padding (1 . 2) :template ,(expand-file-name "~/Pictures/splash-images/blackhole-lines-4.svg" doom-private-dir))
        (:height 200 :min-height 30 :padding (1 . 2) :template ,(expand-file-name "~/Pictures/splash-images/blackhole-lines-5.svg" doom-private-dir))
        (:height 100 :min-height 24 :padding (1 . 2) :template ,(expand-file-name "~/Pictures/splash-images/emacs-e-template.svg" doom-private-dir))
        (:height 0   :min-height 0  :padding (0 . 0) :file ,fancy-splash-image-nil)))

(defvar fancy-splash-sizes
  `((:height 500 :min-height 50 :padding (0 . 2))
    (:height 440 :min-height 42 :padding (1 . 4))
    (:height 330 :min-height 35 :padding (1 . 3))
    (:height 200 :min-height 30 :padding (1 . 2))
    (:height 0   :min-height 0  :padding (0 . 0) :file ,fancy-splash-image-nil))
  "list of plists with the following properties
  :height the height of the image
  :min-height minimum `frame-height' for image
  :padding `+doom-dashboard-banner-padding' to apply
  :template non-default template file
  :file file to use instead of template")

(defvar fancy-splash-template-colours
  '(("$colour1" . keywords) ("$colour2" . type) ("$colour3" . base5) ("$colour4" . base8))
  "list of colour-replacement alists of the form (\"$placeholder\" . 'theme-colour) which applied the template")

(unless (file-exists-p (expand-file-name "theme-splashes" doom-cache-dir))
  (make-directory (expand-file-name "theme-splashes" doom-cache-dir) t))

(defun fancy-splash-filename (theme-name height)
  (expand-file-name (concat (file-name-as-directory "theme-splashes")
                            theme-name
                            "-" (number-to-string height) ".svg")
                    doom-cache-dir))

(defun fancy-splash-clear-cache ()
  "Delete all cached fancy splash images"
  (interactive)
  (delete-directory (expand-file-name "theme-splashes" doom-cache-dir) t)
  (message "Cache cleared!"))

(defun fancy-splash-generate-image (template height)
  "Read TEMPLATE and create an image if HEIGHT with colour substitutions as
   described by `fancy-splash-template-colours' for the current theme"
  (with-temp-buffer
    (insert-file-contents template)
    (re-search-forward "$height" nil t)
    (replace-match (number-to-string height) nil nil)
    (dolist (substitution fancy-splash-template-colours)
      (goto-char (point-min))
      (while (re-search-forward (car substitution) nil t)
        (replace-match (doom-color (cdr substitution)) nil nil)))
    (write-region nil nil
                  (fancy-splash-filename (symbol-name doom-theme) height) nil nil)))

(defun fancy-splash-generate-images ()
  "Perform `fancy-splash-generate-image' in bulk"
  (dolist (size fancy-splash-sizes)
    (unless (plist-get size :file)
      (fancy-splash-generate-image (or (plist-get size :file)
                                       (plist-get size :template)
                                       fancy-splash-image-template)
                                   (plist-get size :height)))))

(defun ensure-theme-splash-images-exist (&optional height)
  (unless (file-exists-p (fancy-splash-filename
                          (symbol-name doom-theme)
                          (or height
                              (plist-get (car fancy-splash-sizes) :height))))
    (fancy-splash-generate-images)))

(defun get-appropriate-splash ()
  (let ((height (frame-height)))
    (cl-some (lambda (size) (when (>= height (plist-get size :min-height)) size))
             fancy-splash-sizes)))

(setq fancy-splash-last-size nil)
(setq fancy-splash-last-theme nil)
(defun set-appropriate-splash (&rest _)
  (let ((appropriate-image (get-appropriate-splash)))
    (unless (and (equal appropriate-image fancy-splash-last-size)
                 (equal doom-theme fancy-splash-last-theme)))
    (unless (plist-get appropriate-image :file)
      (ensure-theme-splash-images-exist (plist-get appropriate-image :height)))
    (setq fancy-splash-image
          (or (plist-get appropriate-image :file)
              (fancy-splash-filename (symbol-name doom-theme) (plist-get appropriate-image :height))))
    (setq +doom-dashboard-banner-padding (plist-get appropriate-image :padding))
    (setq fancy-splash-last-size appropriate-image)
    (setq fancy-splash-last-theme doom-theme)
    (+doom-dashboard-reload)))

(add-hook 'window-size-change-functions #'set-appropriate-splash)
(add-hook 'doom-load-theme-hook #'set-appropriate-splash)
