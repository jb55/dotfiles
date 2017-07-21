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
    erc
    emacs-lisp
    emoji
    finance
    fsharp
    git
    gtags
    idris
    javascript
    (java :variables java-backend 'eclim)
    latex
    lua
    markdown
    (debug :variables c-c++-enable-debug t)
    nixos
    org
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

(setq jb55/additional-packages '(

                                 company-irony
                                 base16-theme
                                 emojify
                                 shen-mode
                                 ereader
                                 glsl-mode
                                 (flycheck
                                  :location (recipe :repo "flycheck/flycheck"
                                                    :fetcher github)
                                  :upgrade 't)
                                 helm-pages
                                 jade-mode
                                 markdown-mode
                                 notmuch
                                 org-brain
                                 weechat

                                 (shen-elisp
                                  :location (recipe :repo "deech/shen-elisp"
                                                    :fetcher github
                                                    :files ("shen*.el"))
                                  :upgrade 't)
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

(setq jb55/light-theme 'spacemacs-light)
(setq jb55/dark-theme 'base16-onedark)

(defun jb55/determine-theme ()
  (let* ((time (decode-time))
         (hour (nth 2 time)))
    (if (and (>= hour 9)
             (<  hour 17))
        jb55/light-theme
      jb55/dark-theme)))

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
   dotspacemacs-themes (list (jb55/determine-theme))

   dotspacemacs-default-font '("Inconsolata"
                               :size 14
                               :style medium
                               :weight normal
                               :width normal
                               :powerline-scale 1.2)

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
    "anj" 'notmuch-jump-search
    "anh" 'notmuch-hello
    "ans" 'notmuch-search
    "]" 'jb55/forward-page-recenter-top
    "[" 'jb55/backward-page-recenter-top
    )

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


  ;; Custom variables
  ;; ----------------

  ;; Do not write anything in this section. This is where Emacs will
  ;; auto-generate custom variable definitions.


)

(custom-set-faces
 ;; custa/sa/savem-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
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
 '(package-selected-packages
   (quote
    (symon string-inflection realgud test-simple loc-changes load-relative password-generator meghanada groovy-mode groovy-imports gradle-mode flycheck-bashate evil-org evil-lion ensime sbt-mode scala-mode editorconfig dante company-lua shen-mode window-numbering spacemacs-theme ido-vertical-mode quelpa package-build yapfify yaml-mode ws-butler winum which-key weechat web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package toc-org tide sql-indent spotify spaceline smeargle shen-elisp restart-emacs rainbow-delimiters racket-mode pyvenv pytest pyenv-mode py-isort psci psc-ide powershell popwin pip-requirements persp-mode pcre2el paradox orgit org-projectile org-present org-pomodoro org-download open-junk-file omnisharp notmuch nix-mode neotree move-text mmm-mode markdown-toc magit-gitflow magit-gh-pulls macrostep lua-mode lorem-ipsum livid-mode live-py-mode linum-relative link-hint ledger-mode json-mode js2-refactor js-doc jade-mode intero info+ indent-guide idris-mode hy-mode hungry-delete htmlize hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-spotify helm-pydoc helm-projectile helm-pages helm-nixos-options helm-mode-manager helm-make helm-hoogle helm-gtags helm-gitignore helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag haskell-snippets google-translate golden-ratio gnuplot glsl-mode github-search github-clone github-browse-file gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gist gh-md ggtags fuzzy fsharp-mode flycheck-pos-tip flycheck-ledger flycheck-haskell flycheck-elm flx-ido fill-column-indicator fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu ereader engine-mode emojify emoji-cheat-sheet-plus elm-mode elisp-slime-nav dumb-jump disaster define-word cython-mode csv-mode company-tern company-statistics company-nixos-options company-irony company-ghci company-ghc company-emoji company-cabal company-c-headers company-auctex company-anaconda column-enforce-mode coffee-mode cmm-mode cmake-mode clean-aindent-mode clang-format base16-theme auto-yasnippet auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
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

