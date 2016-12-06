;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.


;; Configuration Layers
;; --------------------

;; custom stuff

(setq jb55/base-layers
  '((haskell :variables
             haskell-enable-ghc-mod-support nil
             haskell-enable-hindent-style "chris-done")

    (c-c++ :variables
           c-c++-enable-clang-support t
           )

    auto-completion
    csv
    emacs-lisp
    emoji
    finance
    git
    elm
    github
    gnus
    gtags
    javascript
    lua
    markdown
    nixos
    org
    purescript
    python
    racket
    search-engine
    spacemacs-helm
    spacemacs-layouts
    spotify
    sql
    syntax-checking
    yaml
    spacemacs-ui-visual

   ))

(setq jb55/additional-packages '(
                                 company-irony
                                 jade-mode
                                 glsl-mode
                                 weechat
                                 emojify
                                 markdown-mode
                                 ))

(defun is-mac ()
  (string-equal system-type "darwin"))

(setq jb55/layers (if (is-mac) (cons 'osx jb55/base-layers)
                    jb55/base-layers))


(setq jb55/excluded-packages (let ((base-excluded '(org-bullets)))
                               (if (not (is-mac))
                                   (cons 'exec-path-from-shell base-excluded)
                                 base-excluded)
                               ))

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation nil
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers jb55/layers
   dotspacemacs-additional-packages jb55/additional-packages
   dotspacemacs-excluded-packages jb55/excluded-packages
   dotspacemacs-delete-orphan-packages t))


;; Settings
;; --------

;; Initialization Hooks
;; --------------------

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-startup-banner 'official
   dotspacemacs-themes '(base16-tomorrow-night)

   dotspacemacs-default-font '("Noto Mono"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.0)

   dotspacemacs-leader-key "SPC"
   dotspacemacs-remap-Y-to-y$ t
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-editing-style 'vim
   dotspacemacs-startup-lists '()
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-verbose-loading nil
   dotspacemacs-command-key ":"
   dotspacemacs-guide-key-delay 0.4
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-smartparens-strict-mode t
   dotspacemacs-persistent-server nil
   dotspacemacs-default-package-repository nil
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-enable-paste-transient-state nil
   dotspacemacs-colorize-cursor-according-to-state t

   ))

(defun dotspacemacs/user-init ()
  (defun jb55/eshell-prompt ()
    (concat (abbreviate-file-name (eshell/basename (eshell/pwd)))
            (if (= (user-uid) 0) " # " " $ ")))

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
  (set-face-background 'fringe "#1e1f22")
  (set-face-foreground 'vertical-border "#1e1f22")
  (global-hl-line-mode -1)
  (setq compilation-scroll-output t)
)


(defun dotspacemacs/user-config ()
  "This is were you can ultimately override default Spacemacs configuration.
This function is called at the very end of Spacemacs initialization."
  (setq jb55/org-path "~/Dropbox/doc/org")

  (setq spacemacs-indent-sensitive-modes (add-to-list 'spacemacs-indent-sensitive-modes 'nix-mode))

  (defun jb55/write-and-save ()
    (interactive)
    (evil-write-all nil)
    (projectile-compile-project nil)
    )

  (spacemacs/set-leader-keys
    "pS" 'jb55/write-and-save)

  (defun jb55/make-org-path (file)
    (concat (file-name-as-directory jb55/org-path) file))

  (defun task-body (label)
    (concat "* " label " %?\n  %i\n  %a"))

  (setq todo-task (task-body "TODO"))

  (setq org-capture-templates
        `(("t" "Task" entry (file+headline ,(jb55/make-org-path "tasks.org") "Unorganized")
           ,todo-task)
          ("j" "Journal" entry (file+datetree ,(jb55/make-org-path "journal.org"))
           "* %?\nEntered on %U\n  %i\n  %a")
          ("n" "Notes" entry (file+headline ,(jb55/make-org-path "notes.org") "Notes")
           ,(task-body "NOTE"))
          ("w" "Work task" entry (file+headline ,(jb55/make-org-path "work.org") "Tasks")
           ,todo-task)
          ("p" "Phabricator task" entry (file+headline ,(jb55/make-org-path "work.org") "Tasks")
           "* TODO ([[https://phabricator.monstercat.com/%^{T123}][%\\1]]) %?\n  %i")))

  (setq org-agenda-custom-commands
        '(("w" "Work review"
           ((agenda "" ((org-agenda-ndays 7)
                        (org-agenda-repeating-timestamp-show-all nil)
                        (org-agenda-start-on-weekday nil)
                        ))
            (tags-todo "+sprint&-waiting")
            (tags-todo "+payments&-waiting")
            (tags-todo "+waiting")
            )
           ((org-agenda-category-filter-preset '("+work"))))
          ("h" "Home review"
           ((agenda "" ((org-agenda-ndays 7)
                        (org-agenda-repeating-timestamp-show-all nil)
                        (org-agenda-start-on-weekday nil)
                        ))
            (tags-todo "vanessa")
            (tags "tinker")
            (tags "project")
            (tags "errand"))
           ((org-agenda-tag-filter-preset '("-work"))
            (org-agenda-category-filter-preset '("-work"))
            (org-agenda-repeating-timestamp-show-all nil)
            ))
          ("hu" "Unscheduled" search "-SCHEDULED & -DEADLINE")
          ("g" . "GTD contexts")
          ("gw" "Work" tags-todo "work")
          ("gt" "Tinker" tags-todo "tinker")
          ("gp" "Project" tags-todo "project")
          ("gp" "Vanessa" tags-todo "vanessa")
          ("G" "GTD Block Agenda"
           ((tags-todo "vanessa")
            (tags-todo "tinker")
            (tags-todo "projects"))
           nil)
          ))

  ;; fixes tramp slowness
  (setq projectile-mode-line "Projectile")
  (defadvice projectile-project-root (around ignore-remote first activate)
    (unless (file-remote-p default-directory) ad-do-it))

  (setq fci-rule-character-color "#202020")
  (setq fci-rule-color "gray10")
  (setq haskell-hoogle-command nil)
  (setq haskell-hoogle-url "http://localhost:8080/?hoogle=%s")
  ;; (setq haskell-process-type (quote ghci))

  (fset 'phab-task
        [?\" ?z ?y ?i ?w ?i ?\[ ?\[ ?h ?t ?t ?p ?s ?: ?/ ?/ ?p ?h ?a ?b ?r ?i ?c ?a ?t ?o ?r ?. ?m ?o ?n ?s ?t ?e ?r ?c ?a ?t ?. ?c ?o ?m ?/ escape ?E ?a ?\] ?\[ escape ?\" ?z ?p ?a ?\] ?\] escape ?y ?s ?i ?W ?\) ?i ?* ?* ?* ?* ?  escape ?f ?\) ?l ?l ?i ?+ escape ?A ?+ escape ?j ?0])

  (use-package jade-mode :defer t)
)

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
 '(ahs-case-fold-search nil t)
 '(ahs-default-range (quote ahs-range-whole-buffer) t)
 '(ahs-idle-interval 0.25 t)
 '(ahs-idle-timer 0 t)
 '(ahs-inhibit-face-list nil t)
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#110F13" "#B13120" "#719F34" "#CEAE3E" "#7C9FC9" "#7868B5" "#009090" "#F4EAD5"])
 '(ansi-term-color-vector
   [unspecified "#1d1f21" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#81a2be" "#c5c8c6"] t)
 '(browse-url-browser-function (quote browse-url-chromium))
 '(company-clang-arguments (quote ("-Ideps")))
 '(compilation-message-face (quote default))
 '(csv-separators (quote ("," "	")))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(disaster-objdump "gobjdump -d -M att -Sl --no-show-raw-insn")
 '(elm-indent-offset 2)
 '(eshell-prompt-function (quote jb55/eshell-prompt))
 '(evil-shift-width 2)
 '(expand-region-contract-fast-key "V")
 '(expand-region-reset-fast-key "r")
 '(fci-rule-character-color "#202020")
 '(fci-rule-color "#202020" t)
 '(flycheck-clang-include-path (quote ("deps")))
 '(flycheck-clang-language-standard nil)
 '(flycheck-gcc-language-standard "c++11")
 '(flycheck-ghc-args (quote ("-isrc")))
 '(flycheck-hlint-ignore-rules (quote ("Eta reduce")))
 '(fringe-mode (quote (1 . 1)) nil (fringe))
 '(global-hl-line-mode t)
 '(grep-find-ignored-directories
   (quote
    ("SCCS" "RCS" "CVS" "MCVS" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "node_modules")))
 '(haskell-font-lock-symbols nil)
 '(haskell-hoogle-command nil)
 '(haskell-hoogle-url "http://localhost:8080/?hoogle=%s")
 '(haskell-indentation-indent-leftmost t)
 '(haskell-interactive-mode-scroll-to-bottom t)
 '(haskell-interactive-popup-error nil t)
 '(haskell-mode-hook
   (quote
    (turn-on-haskell-indent haskell-hook turn-on-hi2 flycheck-mode)) t)
 '(haskell-notify-p t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote ghci))
 '(haskell-stylish-on-save nil)
 '(haskell-tags-on-save nil)
 '(helm-echo-input-in-header-line nil)
 '(helm-ff-skip-boring-files t)
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
 '(linum-format " %7i ")
 '(magit-diff-use-overlays nil)
 '(main-line-color1 "#1E1E1E")
 '(main-line-color2 "#111111")
 '(main-line-separator-style (quote chamfer))
 '(notmuch-search-oldest-first nil)
 '(org-agenda-current-time-string
   #("=========================== NOW ===========================" 0 59
     (org-heading t)))
 '(org-agenda-files (quote ("~/Dropbox/doc/org" "~/var/ical2org")))
 '(org-agenda-time-grid
   (quote
    ((daily today require-timed)
     ""
     (800 1000 1200 1400 1600 1800 2000))))
 '(org-archive-location "archive/%s_archive::")
 '(org-directory "~/Dropbox/doc/org")
 '(org-refile-targets (quote ((org-agenda-files :maxlevel . 1))))
 '(org-use-sub-superscripts (quote {}))
 '(package-selected-packages
   (quote
    (hlint-refactor company-ghci flycheck-elm elm-mode ledger-mode helm-gtags ggtags flycheck-ledger yaml-mode ws-butler window-numbering which-key web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package toc-org sql-indent spotify spacemacs-theme spaceline smooth-scrolling smeargle shm restart-emacs rainbow-delimiters racket-mode quelpa pyvenv pytest pyenv-mode py-yapf psci psc-ide popwin pip-requirements persp-mode pcre2el paradox page-break-lines orgit org-repo-todo org-present org-pomodoro org-plus-contrib org-download open-junk-file nix-mode neotree move-text mmm-mode markdown-toc magit-gitflow magit-gh-pulls macrostep lua-mode lorem-ipsum livid-mode live-py-mode linum-relative link-hint leuven-theme json-mode js2-refactor js-doc jade-mode info+ indent-guide ido-vertical-mode hy-mode hungry-delete htmlize hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation help-fns+ helm-themes helm-swoop helm-spotify helm-pydoc helm-projectile helm-nixos-options helm-mode-manager helm-make helm-hoogle helm-gitignore helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag haskell-snippets google-translate golden-ratio gnuplot github-clone github-browse-file gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gist gh-md flycheck-purescript flycheck-pos-tip flycheck-haskell flx-ido fill-column-indicator fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu emoji-cheat-sheet-plus elisp-slime-nav disaster define-word cython-mode csv-mode company-tern company-statistics company-quickhelp company-nixos-options company-irony company-ghc company-emoji company-cabal company-c-headers company-anaconda column-enforce-mode coffee-mode cmm-mode cmake-mode clean-aindent-mode clang-format buffer-move bracketed-paste base16-theme auto-yasnippet auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
 '(powerline-color1 "#1E1E1E")
 '(powerline-color2 "#111111")
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" ".svn" "build" "node_modules")))
 '(projectile-mode-line (quote Projectile))
 '(python-indent-offset 2)
 '(rainbow-identifiers-cie-l*a*b*-lightness 80)
 '(rainbow-identifiers-cie-l*a*b*-saturation 18)
 '(rcirc-buffer-maximum-lines 10000)
 '(ring-bell-function (quote ignore))
 '(rng-nxml-auto-validate-flag nil)
 '(rust-indent-offset 2)
 '(safe-local-variable-values
   (quote
    ((flycheck-clang-include-path "./include" "../include"))))
 '(send-mail-function (quote smtpmail-send-it))
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(smerge-command-prefix "m")
 '(smtpmail-smtp-server "smtp.googlemail.com")
 '(smtpmail-smtp-service 25)
 '(standard-indent 2)
 '(user-full-name "William Casarin")
 '(user-mail-address "bill@monstercat.com")
 '(weechat-auto-monitor-buffers
   (quote
    ("monstercat.#general" "monstercat.#payments" "monstercat.#code")))
 '(weechat-auto-monitor-new-buffers t)
 '(weechat-modules (quote (weechat-button weechat-image weechat-complete))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
