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

    (auto-completion :variables auto-completion-enable-help-tooltip t)

    csharp
    csv
    elm
    go
    emacs-lisp
    emoji
    finance
    notmuch
    git
    github
    gtags
    idris
    javascript
    (java :variables java-backend 'eclim)
    latex
    lua
    markdown
    (debug :variables c-c++-enable-debug t)
    nixos
    (org :variables org-want-todo-bindings t)
    purescript
    python
    racket
    rust
    search-engineur
    sml
    spacemacs-helm
    shell-scripts
    spacemacs-layouts
    spacemacs-ui-visual
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
     bison-mode
     graphviz-dot-mode
     emojify
     w3m
     shen-mode
     (notmuch
       :location (recipe :fetcher github
                         :repo "jb55/notmuch"
                         :branch "sort-updates-wip-emacs"
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


(setq jb55/excluded-packages (let ((base-excluded '(org-bullets anaconda-mode)))
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
   dotspacemacs-default-font '("Inconsolata"
                               :size 22
                               :style medium
                               :weight normal
                               :width normal
                               :powerline-scale 1.2)


   dotspacemacs-startup-banner 'official
   dotspacemacs-themes (list (jb55/determine-theme))

   dotspacemacs-active-transparency 90
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-command-key ":"
   dotspacemacs-default-package-repository nil
   dotspacemacs-editing-style 'vim
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-enable-paste-transient-state nil
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-guide-key-delay 0.4
   dotspacemacs-inactive-transparency 90
   dotspacemacs-install-packages 'used-but-keep-unused
   dotspacemacs-leader-key "SPC"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-persistent-server nil
   dotspacemacs-remap-Y-to-y$ t
   dotspacemacs-smartparens-strict-mode t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-startup-lists '()
   dotspacemacs-verbose-loading nil

   ))

(defun dotspacemacs/user-init ()
  (defun jb55/eshell-prompt ()
    (concat (abbreviate-file-name (eshell/basename (eshell/pwd)))
            (if (= (user-uid) 0) " # " " $ ")))

  (load "urweb-mode/urweb-mode-startup")

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

  (defun jb55/notmuch-show-insert-header-p (part hide)
    ;; Show all part buttons except for the first part if it is text/plain.
    (let ((mime-type (notmuch-show-mime-type part)))
      (not (or (and (string= mime-type "text/plain")
                    (<= (plist-get part :id) 3))
               (member mime-type (list "multipart/alternative"
                                       "multipart/mixed"
                                       "multipart/signed"))))))

  (setq notmuch-show-insert-header-p-function 'jb55/notmuch-show-insert-header-p)

  (setq spacemacs-indent-sensitive-modes (add-to-list 'spacemacs-indent-sensitive-modes 'nix-mode))

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
    "yw" 'notmuch-switch-to-work
    "yh" 'notmuch-switch-to-home
    "]" 'jb55/forward-page-recenter-top
    "[" 'jb55/backward-page-recenter-top
    )

  (setq notmuch-saved-searches-home
        (quote
         ((:name "unread" :query "tag:unread and tag:inbox" :key "u")
          (:name "flagged" :query "tag:flagged and tag:inbox" :key "f")
          (:name "sent" :query "tag:sent" :key "t")
          (:name "inbox" :query "tag:inbox and not tag:filed and not tag:noise" :key "i")
          (:name "list" :query "tag:list and tag:inbox and not tag:busy" :key "l" :sort-order subject-ascending)
          (:name "list-busy" :query "tag:list and tag:inbox and tag:busy" :key "L" :sort-order subject-ascending)
          (:name "github" :query "tag:github and tag:inbox" :key "g" :sort-order subject-ascending)
          (:name "filed" :query "tag:inbox and tag:filed" :key "I")
          (:name "today" :query "date:today and tag:inbox" :key "1")
          (:name "rss" :query "tag:rss and tag:inbox and not tag:busy" :key "r" :sort-order from-ascending)
          (:name "rss-busy" :query "tag:rss and tag:inbox and tag:busy" :key "R" :sort-order from-ascending)
          (:name "2-day" :query "date:yesterday.. and tag:inbox" :key "2")
          (:name "week" :query "date:week.. and tag:inbox" :key "3"))))

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
          (:name "dev" :query "tag:dev and tag:inbox" :key "d")
          (:name "events" :query "tag:events and tag:inbox" :key "e")
          (:name "filed" :query "tag:inbox and tag:filed" :key "I")
          (:name "royalties" :query "tag:royalties and tag:inbox" :key "r")
          (:name "today" :query "date:today and tag:inbox" :key "1")
          (:name "2-day" :query "date:yesterday.. and tag:inbox" :key "2")
          (:name "week" :query "date:week.. and tag:inbox" :key "3"))) )

  (defun notmuch-switch ()
    (interactive)
    (if (jb55/at-work)
        (notmuch-switch-to-work)
      (notmuch-switch-to-home)))

  (defun notmuch-switch-to-home ()
    (interactive)
    (setq message-signature-file "~/.signature")
    (setq notmuch-command "notmuch")
    (setq notmuch-poll-script "notmuch-update")
    (setq notmuch-saved-searches notmuch-saved-searches-home))

  (defun notmuch-switch-to-work ()
    (interactive)
    (setq message-signature-file "~/.signature-work")
    (setq notmuch-command "notmuch-work")
    (setq notmuch-poll-script "fetch-work-mail")
    (setq notmuch-saved-searches notmuch-saved-searches-work))

  (notmuch-switch)

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

  (fset 'phab-task
        [?\" ?z ?y ?i ?w ?i ?\[ ?\[ ?h ?t ?t ?p ?s ?: ?/ ?/ ?p ?h ?a ?b ?r ?i ?c ?a ?t ?o ?r ?. ?m ?o ?n ?s ?t ?e ?r ?c ?a ?t ?. ?c ?o ?m ?/ escape ?E ?a ?\] ?\[ escape ?\" ?z ?p ?a ?\] ?\] escape ?y ?s ?i ?W ?\) ?i ?* ?* ?* ?* ?  escape ?f ?\) ?l ?l ?i ?+ escape ?A ?+ escape ?j ?0])

  (use-package jade-mode :defer t)

  (notmuch-switch)

  ;; Custom variables
  ;; ----------------

  ;; Do not write anything in this section. This is where Emacs will
  ;; auto-generate custom variable definitions.


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
 '(company-clang-arguments (quote ("-Ideps")))
 '(company-quickhelp-mode t)
 '(compilation-message-face (quote default))
 '(csv-separators (quote ("," "	")))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(debug-on-error nil)
 '(debug-on-quit nil)
 '(disaster-objdump "objdump -d -M att -Sl --no-show-raw-insn")
 '(elm-indent-offset 2)
 '(eshell-prompt-function (quote jb55/eshell-prompt))
 '(evil-shift-width 2)
 '(evil-want-Y-yank-to-eol t)
 '(expand-region-contract-fast-key "V")
 '(expand-region-reset-fast-key "r")
 '(fci-rule-character-color "#202020" t)
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
    (turn-on-haskell-indent haskell-hook turn-on-hi2 flycheck-mode)))
 '(haskell-notify-p t)
 '(haskell-process-args-ghci (quote ("-isrc" "-XOverloadedStrings" "-ferror-spans")))
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
 '(ispell-program-name "aspell")
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(js2-bounce-indent-p t)
 '(js2-strict-missing-semi-warning nil)
 '(ledger-reports
   (quote
    (("cleared" "ledger ")
     ("bal cleared" "ledger ")
     ("bal" "%(binary) -f %(ledger-file) bal")
     ("reg" "%(binary) -f %(ledger-file) reg")
     ("payee" "%(binary) -f %(ledger-file) reg @%(payee)")
     ("account" "%(binary) -f %(ledger-file) reg %(account)"))))
 '(link-hint-delete-trailing-paren t)
 '(linum-format " %7i ")
 '(magit-diff-use-overlays nil)
 '(mail-envelope-from (quote header))
 '(mail-specify-envelope-from nil)
 '(main-line-color1 "#1E1E1E")
 '(main-line-color2 "#111111")
 '(main-line-separator-style (quote chamfer))
 '(message-auto-save-directory "~/mail/drafts")
 '(message-kill-buffer-on-exit t)
 '(message-mode-hook nil)
 '(message-send-mail-function (quote message-send-mail-with-sendmail))
 '(message-sendmail-envelope-from (quote header))
 '(message-sendmail-f-is-evil t)
 '(mm-text-html-renderer (quote w3m))
 '(notmuch-command "notmuch" t)
 '(notmuch-fcc-dirs ".Sent +sent -inbox -unread")
 '(notmuch-hello-tag-list-make-query "tag:inbox")
 '(notmuch-message-headers-visible t)
 '(notmuch-saved-searches
   (quote
    ((:name "unread" :query "tag:unread and tag:inbox" :key "u")
     (:name "flagged" :query "tag:flagged and tag:inbox" :key "f")
     (:name "sent" :query "tag:sent" :key "t")
     (:name "inbox" :query "tag:inbox and not tag:filed and not tag:noise" :key "i")
     (:name "list" :query "tag:list and tag:inbox and not tag:busy" :key "l")
     (:name "github" :query "tag:github and tag:inbox" :key "g")
     (:name "filed" :query "tag:inbox and tag:filed" :key "I")
     (:name "today" :query "date:today and tag:inbox" :key "1")
     (:name "rss" :query "tag:rss and tag:inbox" :key "r" :sort-order from-ascending)
     (:name "2-day" :query "date:yesterday.. and tag:inbox" :key "2")
     (:name "week" :query "date:week.. and tag:inbox" :key "3"))) t)
 '(notmuch-search-oldest-first nil)
 '(notmuch-search-sort-order (quote newest-first))
 '(notmuch-show-all-tags-list t)
 '(notmuch-show-insert-text/plain-hook
   (quote
    (notmuch-wash-convert-inline-patch-to-part notmuch-wash-wrap-long-lines notmuch-wash-tidy-citations notmuch-wash-elide-blank-lines notmuch-wash-excerpt-citations)))
 '(org-agenda-current-time-string
   #("=========================== NOW ===========================" 0 59
     (org-heading t)))
 '(org-agenda-files (quote ("~/docs/org/anki" "~/docs/org")))
 '(org-agenda-time-grid
   (quote
    ((daily today require-timed)
     ""
     (800 1000 1200 1400 1600 1800 2000))))
 '(org-archive-location "archive/%s_archive::")
 '(org-directory "~/docs/org")
 '(org-export-headline-levels 2)
 '(org-export-with-section-numbers nil)
 '(org-export-with-toc nil)
 '(org-format-latex-options
   (quote
    (:foreground default :background default :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\["))))
 '(org-refile-targets (quote ((org-agenda-files :maxlevel . 1))))
 '(org-use-sub-superscripts (quote {}))
 '(package-selected-packages
   (quote
    (visual-fill-column org-mime evil-org tracking w3m typescript-mode powerline test-simple loc-changes load-relative faceup purescript-mode password-generator spinner alert log4e gntp shut-up sml-mode markdown-mode skewer-mode simple-httpd json-snatcher json-reformat multiple-cursors js2-mode insert-shebang prop-menu hydra parent-mode multi window-purpose imenu-list projectile request gitignore-mode pug-mode dot-mode graphviz-dot-mode transcription-mode emms transcribe godoctor go-rename go-guru go-eldoc company-go go-mode magit-popup git-commit with-editor dash async org-category-capture org-plus-contrib helm-notmuch bison-mode smartparens auctex-latexmk org-bullets exec-path-from-shell yapfify yaml-mode ws-butler winum which-key weechat web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package toml-mode toc-org tide symon string-inflection sql-indent spotify spaceline smeargle shen-mode shen-elisp restart-emacs realgud rainbow-delimiters racket-mode racer pyvenv pytest pyenv-mode py-isort psci psc-ide powershell popwin pip-requirements persp-mode pcre2el paradox orgit org-projectile org-present org-pomodoro org-download org-brain open-junk-file omnisharp ob-sml notmuch nix-mode neotree move-text mmm-mode meghanada mastodon markdown-toc magit-gitflow macrostep lua-mode lorem-ipsum livid-mode live-py-mode linum-relative link-hint ledger-mode json-mode js2-refactor js-doc jade-mode intero info+ indent-guide idris-mode hy-mode hungry-delete htmlize hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-spotify helm-pydoc helm-purpose helm-projectile helm-pages helm-nixos-options helm-mode-manager helm-make helm-hoogle helm-gtags helm-gitignore helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag haskell-snippets groovy-mode groovy-imports gradle-mode google-translate golden-ratio gnuplot glsl-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md ggtags fuzzy fsharp-mode flycheck-rust flycheck-pos-tip flycheck-ledger flycheck-haskell flycheck-elm flx-ido fill-column-indicator fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu ereader erc-yt erc-view-log erc-social-graph erc-image erc-hl-nicks ensime engine-mode emojify emoji-cheat-sheet-plus elm-mode elisp-slime-nav dumb-jump disaster define-word cython-mode csv-mode company-tern company-statistics company-nixos-options company-irony company-ghci company-ghc company-emoji company-emacs-eclim company-cabal company-c-headers company-auctex company-anaconda column-enforce-mode coffee-mode cmm-mode cmake-mode clean-aindent-mode clang-format cargo base16-theme auto-yasnippet auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
 '(powerline-color1 "#1E1E1E")
 '(powerline-color2 "#111111")
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" ".svn" "build" "node_modules")))
 '(projectile-mode-line (quote Projectile))
 '(psc-ide-add-import-on-completion t t)
 '(psc-ide-rebuild-on-save nil t)
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
 '(sendmail-program "sendmail")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(smerge-command-prefix "m")
 '(smtpmail-smtp-server "smtp.jb55.com")
 '(smtpmail-smtp-service 587)
 '(standard-indent 2)
 '(user-full-name "William Casarin")
 '(user-mail-address "jb55@jb55.com")
 '(vc-follow-symlinks nil)
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
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (window-numbering spacemacs-theme ido-vertical-mode quelpa package-build yapfify yaml-mode ws-butler winum which-key weechat web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package toc-org tide sql-indent spotify spaceline smeargle shen-elisp restart-emacs rainbow-delimiters racket-mode pyvenv pytest pyenv-mode py-isort psci psc-ide powershell popwin pip-requirements persp-mode pcre2el paradox orgit org-projectile org-present org-pomodoro org-download open-junk-file omnisharp notmuch nix-mode neotree move-text mmm-mode markdown-toc magit-gitflow magit-gh-pulls macrostep lua-mode lorem-ipsum livid-mode live-py-mode linum-relative link-hint ledger-mode json-mode js2-refactor js-doc jade-mode intero info+ indent-guide idris-mode hy-mode hungry-delete htmlize hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-spotify helm-pydoc helm-projectile helm-pages helm-nixos-options helm-mode-manager helm-make helm-hoogle helm-gtags helm-gitignore helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag haskell-snippets google-translate golden-ratio gnuplot glsl-mode github-search github-clone github-browse-file gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gist gh-md ggtags fuzzy fsharp-mode flycheck-pos-tip flycheck-ledger flycheck-haskell flycheck-elm flx-ido fill-column-indicator fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu ereader engine-mode emojify emoji-cheat-sheet-plus elm-mode elisp-slime-nav dumb-jump disaster define-word cython-mode csv-mode company-tern company-statistics company-nixos-options company-irony company-ghci company-ghc company-emoji company-cabal company-c-headers company-auctex company-anaconda column-enforce-mode coffee-mode cmm-mode cmake-mode clean-aindent-mode clang-format base16-theme auto-yasnippet auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))))
