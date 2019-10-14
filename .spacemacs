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
    react
    csv
    debug
    elm
    emacs-lisp
    emoji
    finance
    fsharp
    git
    go
    gtags
    html
    react
    idris
    ivy
    javascript
    latex
    lua
    markdown
    nixos
    notmuch
    (org :variables org-want-todo-bindings t)
    purescript
    python
    racket
    rust
    shell-scripts
    sml
    spacemacs-layouts
    sql
    syntax-checking
    twitter
    typescript
    yaml
    (org :variables org-want-todo-bindings t)

   ))

(setq jb55/additional-packages
  '( company-irony
     base16-theme
     editor-config
     bison-mode
     emojify
     forge
     glsl-mode
     gnu-apl-mode
     protobuf-mode
     graphviz-dot-mode
     helm-pages
     jade-mode
     meson-mode
     markdown-mode
     meson-mode
     mastodon
     olivetti
     org-brain
     org-clock-csv
     shen-mode
     w3m
     weechat

     (notmuch
       :location (recipe :fetcher github
                         :repo "jb55/notmuch"
                         :branch "dev"
                         :upgrade 't
                         :files ("emacs/notmuch*.el")))
     (flycheck
       :location (recipe :repo "flycheck/flycheck"
                         :fetcher github)
                         :upgrade 't)

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

; needed for compilation hooks as well
(require 'ansi-color)

(defun display-ansi-colors ()
  (interactive)
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))

(defun jb55/at-work ()
  (let* ((time (decode-time))
         (hour (nth 2 time)))
    (and (>= hour 9)
         (<  hour 17))))

(defun jb55/load-theme (theme)
  (counsel-load-theme-action (symbol-name theme)))

(defun jb55/themeswitch (theme)
  (if (eq theme 'light) (jb55/load-theme jb55/light-theme)
    (when (eq theme 'dark)
      (jb55/load-theme jb55/dark-theme))))

(defun jb55/link-hint-download ()
  (interactive)
  (let ((before (current-kill 0)))
    (link-hint-copy-link)
    (let ((after (current-kill 0)))
      (if (not (eq after before))
          (find-file after)))))


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
   dotspacemacs-frozen-packages '(react
                                  ruby
                                  elixir
                                  fsharp
                                  )
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
   dotspacemacs-default-font '("terminus"
                               :size 16
                               :style normal
                               :weight normal
                               :width normal
                            )
   ;; dotspacemacs-default-font '("Inconsolata"
   ;;                            :size 18
   ;;                            :weight normal
   ;;                            :width normal
   ;;                            :powerline-scale 1.1)
   dotspacemacs-active-transparency 90
   dotspacemacs-auto-generate-layout-names nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-default-package-repository nil
   dotspacemacs-display-default-layout nil
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-enable-paste-transient-state nil
   dotspacemacs-ex-command-key ":"
   dotspacemacs-ex-substitute-global nil
   dotspacemacs-folding-method 'evil
   dotspacemacs-frame-title-format "%I@%S"
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-use-fuzzy 'always
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-icon-title-format nil
   dotspacemacs-inactive-transparency 90
   dotspacemacs-large-file-size 1
   dotspacemacs-leader-key "SPC"
   dotspacemacs-line-numbers nil
   dotspacemacs-loading-progress-bar t
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-mode-line-unicode-symbols nil
   dotspacemacs-persistent-server nil
   dotspacemacs-pretty-docs nil
   dotspacemacs-remap-Y-to-y$ 't
   dotspacemacs-retain-visual-state-on-shift t
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")
   dotspacemacs-server-socket-dir "~/.emacs.d/server"
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-show-transient-state-title t
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-smooth-scrolling t
   dotspacemacs-switch-to-buffer-prefers-purpose nil
   dotspacemacs-visual-line-move-text nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-whitespace-cleanup nil
   dotspacemacs-zone-out-when-idle nil
   ))

(defun dotspacemacs/user-env ()
  (setq custom-file "~/dotfiles/custom.el")
  (load custom-file)
  )

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  (setq server-socket-dir "/home/jb55/.emacs.d/server")

  (defun cd-github ()
    (interactive)
    (cd (concat "/home/jb55/dev/github/" (read-string "Repo: "))))


  (defun jb55/eshell-prompt ()
    (concat (abbreviate-file-name (eshell/basename (eshell/pwd)))
            (if (= (user-uid) 0) " # " " $ ")))

  (load "urweb-mode/urweb-mode-startup")
  (load "~/src/elisp/notmuch/notmuch-github.el")
  (load "~/src/elisp/overlays/overlays.el")

  (defun cd-repo ()
    (interactive)
    (let ((repo (notmuch-repo-from-message)))
      (cd (concat "/home/jb55/dev/github/" repo))))

  (defun colorize-compilation-buffer ()
    (toggle-read-only)
    (ansi-color-apply-on-region (point-min) (point-max))
    (toggle-read-only))

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
  (setq jb55/org-path "~/docs/org")
  (url-handler-mode 1)

  ;; (require 'magit)

  ;; (defun magit-merge-ff (rev &optional args nocommit)
  ;;   (interactive (list (magit-read-other-branch-or-commit "Merge")
  ;;                      (magit-merge-arguments)
  ;;                      current-prefix-arg))
  ;;   (magit-merge rev (cons "--ff-only" args) nocommit))

  ;; (magit-define-popup-switch 'magit-merge-popup
  ;;    ?f "Fast-forward merge" 'magit-merge-ff)

  (set-face-background 'fringe "#1e1f22")
  (set-face-foreground 'vertical-border "#1e1f22")
  (setq gnus-inhibit-images nil)

  (defun jb55/compilation-finish (buffer status)
    (call-process "notify-send" nil nil nil
                  "-i" "emacs"
                  "Emacs compilation"
                  status))

  (setq compilation-finish-functions
        (append compilation-finish-functions
                '(jb55/compilation-finish)))

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

  (setq ivy-initial-inputs-alist (list))

  (setq spacemacs-indent-sensitive-modes
        (add-to-list 'spacemacs-indent-sensitive-modes 'nix-mode))

  (setq org-want-todo-bindings 't)

  (defun jb55/forward-page-recenter-top ()
    (interactive)
    (evil-ex-search-next)
    (evil-scroll-line-to-center (line-number-at-pos)))

  (defun jb55/backward-page-recenter-top ()
    (interactive)
    (evil-ex-search-previous)
    (evil-scroll-line-to-center (line-number-at-pos)))

  (defun jb55/xref-find-def ()
    (interactive)
    (let ((current-prefix-arg 4))
      (call-interactively 'xref-find-definitions)))

  (setq-default olivetti-body-width 80)

  (spacemacs/set-leader-keys
    "Ju" 'jb55/unhighlight-line
    "J]" 'jb55/forward-page-recenter-top
    "J[" 'jb55/backward-page-recenter-top

    "wc" 'olivetti-mode
    "xb" 'jb55/link-hint-download
    "Jd" 'jb55/xref-find-def
    "yj" 'notmuch-jump-search
    "is" 'company-yasnippet
    "yi" 'notmuch-hello
    "ys" 'notmuch-search
    "aTn" 'twittering-update-status-interactive
    "aTu" 'twittering-user-timeline
    "aTm" 'twittering-mentions-timeline
    )

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

  (setq todo-task (task-body "TODO"))

  (setq org-capture-templates
        `(("t" "Task" entry (file+headline ,(jb55/make-org-path "tasks.org") "Unorganized")
           ,todo-task)
          ("n" "Notes" entry (file+headline ,(jb55/make-org-path "notes.org") "Notes")
           ,(task-body "NOTE"))
          ("w" "Razor task" entry (file+headline "~/projects/razorcx/doc/org/todo.org" "Current")
           ,todo-task)
          ("o" "Openstamp task" entry (file+headline "~/projects/openstamp/openstamp-server/todo.org" "Current")
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
          ("gr" "Razor" tags-todo "razor")
          ("gt" "Tinker" tags-todo "tinker")
          ("gp" "polyadvent" tags-todo "polyadvent")
          ("G" "GTD Block Agenda"
           ((tags-todo "polyadvent")
            )
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

(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(vc-follow-symlinks t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
