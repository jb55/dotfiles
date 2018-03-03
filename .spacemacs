;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(setq jb55/base-layers
  '((haskell :variables
             haskell-enable-ghc-mod-support nil
             haskell-enable-hindent-style "chris-done")

    (c-c++ :variables
           c-c++-enable-clang-support t
           )

    (auto-completion :variables auto-completion-enable-help-tooltip t)

    csharp
    csv
    semantic
    elm
    go
    emacs-lisp
    emoji
    finance
    notmuch
    git
    github
    ivy
    gtags
    idris
    javascript
    (java :variables java-backend 'eclim)
    latex
    lua
    markdown
    ;; (debug :variables c-c++-enable-debug t)
    nixos
    (org :variables org-want-todo-bindings t)
    purescript
    python
    racket
    rust
    sml
    shell-scripts
    spacemacs-layouts
    spotify
    sql
    syntax-checking
    typescript
		windows-scripts
    yaml

   ))

(setq jb55/additional-packages
  '( company-irony
     base16-theme
     org-clock-csv
     gnu-apl-mode
     bison-mode
     graphviz-dot-mode
     emojify
     w3m
     shen-mode
     (notmuch
       :location (recipe :fetcher github
                         :repo "jb55/notmuch"
                         :branch "sort-updates"
                         :upgrade 't
                         :files ("emacs/notmuch*.el")))
     ereader
     glsl-mode
     (flycheck
       :location (recipe :repo "flycheck/flycheck"
                         :fetcher github)
                         :upgrade 't)
     helm-pages
     jade-mode
     markdown-mode
     org-brain
     weechat

     (shen-elisp
       :location (recipe :repo "deech/shen-elisp"
                         :fetcher github
                         :files ("shen*.el")
                         :upgrade 't))))

(defun is-mac ()
  (string-equal system-type "darwin"))

(setq jb55/layers (if (is-mac) (cons 'osx jb55/base-layers)
                    jb55/base-layers))


(setq jb55/excluded-packages (let ((base-excluded '(org-bullets vi-tilde-fringe anaconda-mode)))
                               (if (not (is-mac))
                                   (cons 'exec-path-from-shell base-excluded)
                                 base-excluded)
                               ))

(setq jb55/light-theme 'spacemacs-light)
(setq jb55/dark-theme 'base16-onedark)

(defun jb55/at-work ()
  (let* ((time (decode-time))
         (hour (nth 2 time)))
    (and (>= hour 9)
         (<  hour 17))))

(defun jb55/determine-theme ()
  (if (jb55/at-work)
      jb55/dark-theme
    jb55/dark-theme))

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   dotspacemacs-distribution 'spacemacs
   ;;dotspacemacs-enable-lazy-installation nil
   ;;dotspacemacs-delete-orphan-packages t
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation t
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers jb55/layers
   dotspacemacs-additional-packages jb55/additional-packages
   dotspacemacs-frozen-packages '()
   dotspacemacs-excluded-packages jb55/excluded-packages
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  (setq-default
   dotspacemacs-themes (list (jb55/determine-theme))
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-use-spacelpa nil
   dotspacemacs-verify-spacelpa-archives nil
   dotspacemacs-check-for-update nil
   dotspacemacs-elpa-subdirectory 'emacs-version
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   dotspacemacs-startup-buffer-responsive t
   dotspacemacs-scratch-mode 'text-mode
   ;; dotspacemacs-themes '(spacemacs-dark
   ;;                       spacemacs-light)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("Inconsolata"
                               :size 20
                               :style medium
                               :weight normal
                               :width normal
                               :powerline-scale 1.2)
   ;;dotspacemacs-default-font '("Source Code Pro"
   ;;                            :size 13
   ;;                            :weight normal
   ;;                            :width normal
   ;;                            :powerline-scale 1.1)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-ex-command-key ":"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-remap-Y-to-y$ 't
   dotspacemacs-retain-visual-state-on-shift t
   dotspacemacs-visual-line-move-text nil
   dotspacemacs-ex-substitute-global nil
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-auto-generate-layout-names nil
   dotspacemacs-large-file-size 1
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-helm-use-fuzzy 'always
   dotspacemacs-enable-paste-transient-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-switch-to-buffer-prefers-purpose nil
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers nil
   dotspacemacs-folding-method 'evil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-frame-title-format "%I@%S"
   dotspacemacs-icon-title-format nil
   dotspacemacs-whitespace-cleanup nil
   dotspacemacs-zone-out-when-idle nil
   dotspacemacs-pretty-docs nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  (setq custom-file "~/dotfiles/custom.el")
  (load custom-file)

  (defun jb55/eshell-prompt ()
    (concat (abbreviate-file-name (eshell/basename (eshell/pwd)))
            (if (= (user-uid) 0) " # " " $ ")))



  (load "urweb-mode/urweb-mode-startup")
  (load "~/src/elisp/notmuch/notmuch-github.el")

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
  (global-hl-line-mode -1)
  (setq compilation-scroll-output t)

  )

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."
  (setq jb55/org-path "~/Dropbox/doc/org")

  (set-face-background 'fringe "#1e1f22")
  (set-face-foreground 'vertical-border "#1e1f22")

  (defun jb55/notmuch-show-insert-header-p (part hide)
    ;; Show all part buttons except for the first part if it is text/plain.
    (let ((mime-type (notmuch-show-mime-type part)))
      (not (or (and (string= mime-type "text/plain")
                    (<= (plist-get part :id) 3))
               (member mime-type (list "multipart/alternative"
                                       "multipart/mixed"
                                       "multipart/signed"))))))

  (setq notmuch-show-insert-header-p-function
        'jb55/notmuch-show-insert-header-p)

  (setq spacemacs-indent-sensitive-modes
        (add-to-list 'spacemacs-indent-sensitive-modes 'nix-mode))

  (setq org-want-todo-bindings 't)

  (defun jb55/write-and-save ()
    (interactive)
    (evil-write-all nil)
    (projectile-compile-project nil)
    )

  (defun jb55/forward-page-recenter-top ()
    (interactive)
    (forward-page)
    (evil-scroll-line-to-top (line-number-at-pos)))

  (defun jb55/backward-page-recenter-top ()
    (interactive)
    (backward-page)
    (evil-scroll-line-to-top (line-number-at-pos)))

  (spacemacs/set-leader-keys
    "pS" 'jb55/write-and-save
    "yj" 'notmuch-jump-search
    "yi" 'notmuch-hello
    "ys" 'notmuch-search
    "]" 'jb55/forward-page-recenter-top
    "[" 'jb55/backward-page-recenter-top
    )

  (setq notmuch-tag-formats
        '(("unread"
           (propertize tag 'face 'notmuch-tag-unread))
          ("flagged"
           (notmuch-tag-format-image-data tag (notmuch-tag-star-icon))
           (propertize tag 'face 'notmuch-tag-flagged))
          ("pr"
           (notmuch-apply-face tag '(:foreground "green")))
          ("issue"
           (notmuch-apply-face tag '(:foreground "orange")))
          ("filed")
          ("list")
          ("github")
          ("inbox"
           #("⬇" 0 1
             (face (:foreground "white"))))
          ("lightning"
           #("⚡" 0 1
             (face (:foreground "yellow"))))))

  (setq notmuch-saved-searches-work
        (quote
         ((:name "unread" :query "tag:unread and tag:inbox" :key "u")
          (:name "flagged" :query "tag:flagged and tag:inbox" :key "f")
          (:name "sent" :query "tag:sent" :key "t")
          (:name "inbox" :query "tag:inbox and not tag:filed and not tag:noise" :key "i")
          (:name "github" :query "tag:github and tag:inbox" :key "g")
          (:name "internal" :query "tag:internal and tag:inbox" :key "m")
          (:name "noise" :query "tag:noise and tag:inbox" :key "n")
          (:name "report" :query "tag:report" :key "R")
          (:name "dev" :query "tag:dev and (tag:inbox or tag:unmerged)" :key "d")
          (:name "events" :query "tag:events and tag:inbox" :key "e")
          (:name "filed" :query "tag:inbox and tag:filed" :key "I")
          (:name "royalties" :query "tag:royalties and tag:inbox" :key "r")
          (:name "today" :query "date:today and tag:inbox" :key "1")
          (:name "2-day" :query "date:yesterday.. and tag:inbox" :key "2")
          (:name "week" :query "date:week.. and tag:inbox" :key "3"))) )

  (defun notmuch-switch-to-home ()
    (setq message-signature-file "~/.signature")
    (setq notmuch-command "notmuch")
    (setq notmuch-poll-script "notmuch-update-personal")
    ;;(setq notmuch-saved-searches notmuch-saved-searches-home)
    )

  ;; (defun notmuch-switch-to-work ()
  ;;   (interactive)
  ;;   (setq message-signature-file "~/.signature-work")
  ;;   (setq notmuch-command "notmuch-work")
  ;;   (setq notmuch-command "notmuch-work")
  ;;   (setq notmuch-poll-script "fetch-work-mail")
  ;;   (setq notmuch-saved-searches notmuch-saved-searches-work))

  (notmuch-switch-to-home)

  (defun jb55/make-org-path (file)
    (concat (file-name-as-directory jb55/org-path) file))

  (defun task-body (label)
    (concat "* " label " %?\n  %i\n  %a"))

  (setq anki-body "* %?\n** Front\n** Back")

  (setq todo-task (task-body "TODO"))

  (setq org-capture-templates
        `(("t" "Task" entry (file+headline ,(jb55/make-org-path "tasks.org") "Unorganized")
           ,todo-task)
          ("j" "Journal" entry (file+datetree ,(jb55/make-org-path "journal.org"))
           "* %?\nEntered on %U\n  %i\n  %a")
          ("n" "Notes" entry (file+headline ,(jb55/make-org-path "notes.org") "Notes")
           ,(task-body "NOTE"))
          ("a" "Anki" entry (file+headline ,(jb55/make-org-path "anki.org") "Anki")
           ,anki-body)
          ("w" "Work task" entry (file+headline ,(jb55/make-org-path "work.org") "Tasks")
           ,todo-task)
          ))

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
            (tags-todo "razor")
            (tags "tinker")
            (tags "errand"))
           ((org-agenda-tag-filter-preset '("-work"))
            (org-agenda-category-filter-preset '("-work"))
            (org-agenda-repeating-timestamp-show-all nil)
            ))
          ("hu" "Unscheduled" search "-SCHEDULED & -DEADLINE")
          ("g" . "GTD contexts")
          ("gw" "Work" tags-todo "work")
          ("gr" "Razor" tags-todo "razor")
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

  )

