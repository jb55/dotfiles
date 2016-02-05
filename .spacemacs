;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.


;; Configuration Layers
;; --------------------

;; custom stuff

(setq base-layers '((haskell :variables
                             ;haskell-enable-hindent-style "chris-done"
                             haskell-enable-ghc-mod-support nil)

                    (c-c++ :variables
                           c-c++-enable-clang-support t)

                    auto-completion
                    csv
                    emacs-lisp
                    emoji
                    git
                    github
                    gnus
                    javascript
                    lua
                    markdown
                    nixos
                    org
                    purescript
                    python
                    rcirc
                    semantic
                    spacemacs-layouts
                    spotify
                    sql
                    syntax-checking
                    vim-empty-lines

                    ))

(defun is-mac ()
  (string-equal system-type "darwin"))

(setq my-layers (if (is-mac) (cons 'osx base-layers)
                    base-layers))

(setq excluded-packages (if (not (is-mac)) '(exec-path-from-shell) '()))
;; (setq excluded-packages '())

(defun file-string (file)
    "Read the contents of a file and return as a string."
    (with-temp-buffer
      (insert-file-contents file)
      (buffer-string)))

(defun drop-last (str)
  "Drop the last character in a string"
  (substring str 0 -1))

(defun rcirc-znc-server (network)
  "Add a virtual znc network"
  `(,(concat network ".znc.jb55.com")
    :user-name ,(concat "jb55/" network)
    :port 33111
    :encryption tls
    :password ,(drop-last (file-string "~/.dotfiles/ircpass"))
    :nick "jb55"))

(defun projectile-command-to-string (cmd)
  (let ((cwd (car (projectile-get-project-directories))))
    (shell-command-to-string (concat "cd \"" cwd "\" && " cmd))))

(defun nix-shell-path (&rest args)
  (interactive)
  (let ((path-from-shell (projectile-command-to-string
                          (concat "nix-shell --command 'echo $PATH'" args))))
    (setq exec-path (split-string path-from-shell path-separator))))

(setq irc-servers
      `(,(rcirc-znc-server "freenode")
        ))

(setq-default
 ;; List of additional paths where to look for configuration layers.
 ;; Paths must have a trailing slash (ie. `~/.mycontribs/')

 dotspacemacs-configuration-layer-path '()
 ;; List of configuration layers to load.

 dotspacemacs-configuration-layers my-layers

 ;; A list of packages and/or extensions that will not be install and loaded.

 dotspacemacs-additional-packages '(
                                    cuda-mode
                                    glsl-mode
                                    racket-mode
                                    jade-mode
                                    markdown-mode
                                    nix-mode
                                   )

 dotspacemacs-excluded-packages excluded-packages
)

;; Settings
;; --------

(setq-default
 ;; Specify the startup banner. If the value is an integer then the
 ;; banner with the corresponding index is used, if the value is `random'
 ;; then the banner is chosen randomly among the available banners, if
 ;; the value is nil then no banner is displayed.
 dotspacemacs-startup-banner 'official
 ;; Default theme applied at startup
 ;; dotspacemacs-default-theme 'solarized-light
 dotspacemacs-themes '(base16-tomorrow-dark)

 dotspacemacs-default-font '("Source Code Pro"
                             :size 10
                             :weight normal
                             :width normal
                             :powerline-scale 1.1)

 ;; The leader key
 dotspacemacs-leader-key "SPC"
 dotspacemacs-emacs-leader-key "M-m"
 dotspacemacs-editing-style 'vim
 ;; Major mode leader key is a shortcut key which is the equivalent of
 ;; pressing `<leader> m`
 dotspacemacs-major-mode-leader-key ","
 ;; The command key used for Evil commands (ex-commands) and
 ;; Emacs commands (M-x).
 ;; By default the command key is `:' so ex-commands are executed like in Vim
 ;; with `:' and Emacs commands are executed with `<leader> :'.
 dotspacemacs-command-key ":"
 ;; Guide-key delay in seconds. The Guide-key is the popup buffer listing
 ;; the commands bound to the current keystrokes.
 dotspacemacs-guide-key-delay 0.4
 ;; If non nil the frame is fullscreen when Emacs starts up (Emacs 24.4+ only).
 dotspacemacs-fullscreen-at-startup nil
 ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
 ;; Use to disable fullscreen animations in OSX."
 dotspacemacs-fullscreen-use-non-native nil
 ;; If non nil the frame is maximized when Emacs starts up (Emacs 24.4+ only).
 ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
 dotspacemacs-maximized-at-startup nil
 ;; A value from the range (0..100), in increasing opacity, which describes the
 ;; transparency level of a frame when it's active or selected. Transparency can
 ;; be toggled through `toggle-transparency'.
 dotspacemacs-active-transparency 90
 ;; A value from the range (0..100), in increasing opacity, which describes the
 ;; transparency level of a frame when it's inactive or deselected. Transparency
 ;; can be toggled through `toggle-transparency'.
 dotspacemacs-inactive-transparency 90
 ;; If non nil unicode symbols are displayed in the mode line (e.g. for lighters)
 dotspacemacs-mode-line-unicode-symbols nil
 ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth scrolling
 ;; overrides the default behavior of Emacs which recenters the point when
 ;; it reaches the top or bottom of the screen
 dotspacemacs-smooth-scrolling t
 ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
 dotspacemacs-smartparens-strict-mode t
 ;; If non nil advises quit functions to keep server open when quitting.
 dotspacemacs-persistent-server nil
 ;; The default package repository used if no explicit repository has been
 ;; specified with an installed package.
 ;; Not used for now.
 dotspacemacs-default-package-repository nil

 dotspacemacs-enable-paste-micro-state nil

 )

;; Initialization Hooks
;; --------------------

(defun dotspacemacs/init ()
  "User initialization for Spacemacs. This function is called at the very
 startup."
;;(define-key helm-map (kbd "ESC") 'helm-keyboard-quit)

;;(setq-default projectile-require-project-root nil)

  ;; ansi color shenanigans
  (defun colorize-compilation-buffer ()
    (toggle-read-only)
    (ansi-color-apply-on-region (point-min) (point-max))
    (toggle-read-only))

  (require 'ansi-color)
  (add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
  (add-to-list 'comint-output-filter-functions 'ansi-color-process-output)
  (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

  (require 'compile)
  ;; node stack track compilation errors in js-mode
  (add-to-list 'compilation-error-regexp-alist-alist
               '(npm "[[:space:]](?\\(.*?\\)\\([0-9A-Za-z_./\:-]+\\.\\(js\\|coffee\\)\\):\\([0-9]+\\):\\([0-9]+\\)" 2 4 5)
               )

  (add-to-list 'compilation-error-regexp-alist 'npm)

  ;; fringe, vertical border colors
  (set-face-background 'fringe "#1e1f22")
  (set-face-foreground 'vertical-border "#1e1f22")
  ;;(set-fring-style 'minimal)

  ;; (set-face-attribute 'default nil :height 100)

  ;; add nix path to exec-path
  ;;(add-to-list 'exec-path "~/.nix-profile/bin/")

  (global-hl-line-mode -1)

  ;; auto-scroll compilation buffers
  (setq compilation-scroll-output t)
)

(defun dotspacemacs/user-config ()
  "This is were you can ultimately override default Spacemacs configuration.
This function is called at the very end of Spacemacs initialization."

  ;; (eval-after-load 'smartparens
  ;;   '(progn
  ;;      (sp-pair "(" nil :actions :rem)
  ;;      (sp-pair "[" nil :actions :rem)
  ;;      (sp-pair "'" nil :actions :rem)
  ;;      (sp-pair "\"" nil :actions :rem)))

  (setq fci-rule-character-color "#202020")
  (setq fci-rule-color "gray10")
  (setq haskell-hoogle-command nil)
  (setq haskell-hoogle-url "http://localhost:8080/?hoogle=%s")
  ;; (setq haskell-process-type (quote ghci))
  (setq rcirc-server-alist irc-servers)

  (use-package jade-mode :defer t)
  (use-package nix-mode :defer t)
)

;;(add-hook 'after-init-hook 'my-helm-init)

;; Custom variables
;; ----------------

;; Do not write anything in this section. This is where Emacs will
;; auto-generate custom variable definitions.


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Linum-format "%7i ")
 '(ac-ispell-requires 4 t)
 '(ahs-case-fold-search nil)
 '(ahs-default-range (quote ahs-range-whole-buffer))
 '(ahs-idle-interval 0.25)
 '(ahs-idle-timer 0 t)
 '(ahs-inhibit-face-list nil)
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#110F13" "#B13120" "#719F34" "#CEAE3E" "#7C9FC9" "#7868B5" "#009090" "#F4EAD5"])
 '(ansi-term-color-vector
   [unspecified "#1d1f21" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#81a2be" "#c5c8c6"] t)
 '(browse-url-browser-function (quote browse-url-chromium))
 '(compilation-message-face (quote default))
 '(csv-separators (quote ("," "	")))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(disaster-objdump "gobjdump -d -M att -Sl --no-show-raw-insn")
 '(evil-shift-width 2)
 '(expand-region-contract-fast-key "V")
 '(expand-region-reset-fast-key "r")
 '(fci-rule-character-color "#202020" t)
 '(fci-rule-color "#202020" t)
 '(flycheck-clang-include-path (quote ("/home/jb55/src/c/sandy/include")))
 '(flycheck-gcc-language-standard "c++11")
 '(fringe-mode (quote (1 . 1)) nil (fringe))
 '(global-hl-line-mode t)
 '(grep-find-ignored-directories
   (quote
    ("SCCS" "RCS" "CVS" "MCVS" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "node_modules")))
 '(haskell-hoogle-command nil t)
 '(haskell-hoogle-url "http://localhost:8080/?hoogle=%s" t)
 '(haskell-interactive-mode-scroll-to-bottom t)
 '(haskell-interactive-popup-error nil t)
 '(haskell-mode-hook
   (quote
    (turn-on-haskell-indent haskell-hook turn-on-hi2 flycheck-mode)) t)
 '(haskell-notify-p t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote auto))
 '(haskell-stylish-on-save nil)
 '(haskell-tags-on-save t t)
 '(helm-echo-input-in-header-line nil)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   (quote
    (("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100))))
 '(hl-bg-colors
   (quote
    ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
    ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(if (version< emacs-version "24.4"))
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(js2-bounce-indent-p t)
 '(js2-strict-missing-semi-warning nil)
 '(linum-format " %7i " t)
 '(magit-diff-use-overlays nil)
 '(main-line-color1 "#1E1E1E")
 '(main-line-color2 "#111111")
 '(main-line-separator-style (quote chamfer))
 '(notmuch-search-oldest-first nil)
 '(org-use-sub-superscripts (quote {}))
 '(powerline-color1 "#1E1E1E")
 '(powerline-color2 "#111111")
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" ".svn" "build" "node_modules")))
 '(python-indent-offset 2)
 '(rainbow-identifiers-cie-l*a*b*-lightness 80)
 '(rainbow-identifiers-cie-l*a*b*-saturation 18)
 '(rcirc-buffer-maximum-lines 10000)
 '(ring-bell-function (quote ignore) t)
 '(rng-nxml-auto-validate-flag nil)
 '(rust-indent-offset 2)
 '(safe-local-variable-values
   (quote
    ((flycheck-clang-include-path "./include" "../include"))))
 '(send-mail-function (quote smtpmail-send-it))
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(smtpmail-smtp-server "smtp.googlemail.com")
 '(smtpmail-smtp-service 25)
 '(standard-indent 2)
 '(user-full-name "William Casarin")
 '(user-mail-address "bill@monstercat.com"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
