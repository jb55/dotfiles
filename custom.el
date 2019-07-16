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
 '(before-save-hook
   (quote
    (spacemacs//python-sort-imports gofmt-before-save org-update-all-dblocks)))
 '(browse-url-browser-function (quote browse-url-generic))
 '(browse-url-generic-program "browser")
 '(company-clang-arguments (quote ("-Ideps")))
 '(company-quickhelp-mode t)
 '(compilation-message-face (quote default))
 '(compilation-window-height 15)
 '(csv-separators (quote ("," "	")))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(debug-on-error nil)
 '(debug-on-quit nil)
 '(disaster-objdump "objdump -d -M att -Sl --no-show-raw-insn")
 '(elm-indent-offset 4)
 '(epg-gpg-home-directory "~/.gnupg/trezor")
 '(eshell-prompt-function (quote jb55/eshell-prompt))
 '(evil-shift-width 2)
 '(evil-want-Y-yank-to-eol t)
 '(expand-region-contract-fast-key "V")
 '(expand-region-reset-fast-key "r")
 '(fci-rule-character-color "#202020")
 '(fci-rule-color "#202020")
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
 '(haskell-hoogle-command nil t)
 '(haskell-hoogle-url "http://localhost:8080/?hoogle=%s" t)
 '(haskell-indentation-indent-leftmost t)
 '(haskell-interactive-mode-scroll-to-bottom t)
 '(haskell-interactive-popup-error nil t)
 '(haskell-mode-hook
   (quote
    (turn-on-haskell-indent haskell-hook turn-on-hi2 flycheck-mode)) t)
 '(haskell-notify-p t t)
 '(haskell-process-args-cabal-repl
   (quote
    ("--ghc-options=-ferror-spans -fshow-loaded-modules")))
 '(haskell-process-args-ghci
   (quote
    ("-isrc" "-XOverloadedStrings" "-ferror-spans" "-fshow-loaded-modules")))
 '(haskell-process-auto-import-loaded-modules t t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t t)
 '(haskell-process-type (quote ghci))
 '(haskell-stylish-on-save nil t)
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
 '(hl-todo-keyword-faces
   (quote
    (("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#3a81c3")
     ("OKAY" . "#3a81c3")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#42ae2c")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX" . "#dc752f")
     ("XXXX" . "#dc752f"))))
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
 '(magit-revision-insert-related-refs nil)
 '(magit-revision-show-gravatars nil)
 '(magit-revision-use-hash-sections (quote quickest))
 '(mail-envelope-from (quote header))
 '(mail-specify-envelope-from nil)
 '(main-line-color1 "#1E1E1E")
 '(main-line-color2 "#111111")
 '(main-line-separator-style (quote chamfer))
 '(mastodon-instance-url "https://maly.io")
 '(message-auto-save-directory "~/mail/drafts")
 '(message-kill-buffer-on-exit t)
 '(message-mode-hook nil)
 '(message-send-mail-function (quote message-send-mail-with-sendmail))
 '(message-sendmail-envelope-from (quote header))
 '(message-sendmail-f-is-evil t)
 '(mm-text-html-renderer (quote w3m))
 '(mml-secure-key-preferences
   (quote
    ((OpenPGP
      (sign
       ("jb55@jb55.com" "5B2B1E4F62216BC74362AC61D4FBA2FC4535A2A9"))
      (encrypt
       ("jb55@jb55.com" "8860420C3C135662EABEADF96342E010C44A6337" "5B2B1E4F62216BC74362AC61D4FBA2FC4535A2A9")))
     (CMS
      (sign)
      (encrypt)))))
 '(mml-secure-openpgp-encrypt-to-self
   (quote
    ("8860420C3C135662EABEADF96342E010C44A6337" "87D78CE40B38B817" "5B2B1E4F62216BC74362AC61D4FBA2FC4535A2A9")))
 '(notmuch-fcc-dirs ".Sent +sent -inbox -unread")
 '(notmuch-hello-tag-list-make-query "tag:inbox")
 '(notmuch-message-headers-visible t)
 '(notmuch-saved-searches
   (quote
    ((:name "flagged" :query "tag:flagged and tag:inbox" :key "f")
     (:name "lightning" :query "tag:inbox and tag:lightning" :key "k" :sort-order newest-first)
     (:name "bitcoin" :query "tag:core and tag:inbox" :key "b" :sort-order newest-first)
     (:name "best" :query "tag:best and tag:inbox" :key "B" :sort-order newest-first)
     (:name "inbox" :query "tag:inbox and not tag:filed and not tag:noise" :key "i" :sort-order newest-first)
     (:name "nixpkgs" :query "tag:nixpkgs and tag:inbox" :key "n" :sort-order subject-ascending)
     (:name "notmuch" :query "tag:notmuch and tag:inbox" :key "N" :sort-order newest-first)
     (:name "list" :query "tag:list and not tag:github and tag:inbox and not tag:busy" :key "l" :sort-order subject-ascending)
     (:name "github" :query "tag:github and not tag:busy and tag:inbox" :key "g" :sort-order subject-ascending)
     (:name "today" :query "date:today and tag:inbox" :key "1")
     (:name "rss" :query "tag:rss and tag:inbox and not tag:busy" :key "r" :sort-order from-ascending)
     (:name "2-day" :query "date:yesterday.. and tag:inbox" :key "2"))))
 '(notmuch-search-line-faces
   (quote
    (("unread" . notmuch-search-unread-face)
     ("flagged" . notmuch-search-flagged-face))))
 '(notmuch-search-oldest-first nil)
 '(notmuch-search-sort-order (quote newest-first))
 '(notmuch-show-all-tags-list t)
 '(notmuch-show-insert-text/plain-hook
   (quote
    (notmuch-wash-convert-inline-patch-to-part notmuch-wash-wrap-long-lines notmuch-wash-tidy-citations notmuch-wash-elide-blank-lines notmuch-wash-excerpt-citations)))
 '(notmuch-tag-formats
   (quote
    (("unread" "?"
      (propertize tag
                  (quote face)
                  (quote notmuch-tag-unread)))
     ("flagged"
      (notmuch-tag-format-image-data tag
                                     (notmuch-tag-star-icon))
      (propertize tag
                  (quote face)
                  (quote notmuch-tag-flagged)))
     ("pr"
      (notmuch-apply-face tag
                          (quote
                           (:foreground "green"))))
     ("issue"
      (notmuch-apply-face tag
                          (quote
                           (:foreground "orange"))))
     ("filed")
     ("list")
     ("github"
      #("gh" 0 2
        (face
         ((:foreground "dim gray"))))
      (notmuch-apply-face tag
                          (quote
                           (:foreground "dim gray"))))
     ("inbox"
      #("⬇" 0 1
        (face
         ((:foreground "white"))))
      (notmuch-apply-face tag
                          (quote
                           (:foreground "white"))))
     ("lightning"
      #("⚡" 0 1
        (face
         ((:foreground "yellow"))))
      (notmuch-apply-face tag
                          (quote
                           (:foreground "yellow"))))
     ("closed"
      (notmuch-apply-face tag
                          (quote
                           (:foreground "wheat"))))
     ("merged"
      (notmuch-apply-face tag
                          (quote
                           (:foreground "yellow"))))
     ("bot"
      #("☃" 0 1
        (face
         ((:family "Noto Emoji" :weight bold :foreground "white smoke"))))
      (notmuch-apply-face tag
                          (quote
                           (:family "Noto Emoji" :weight bold :foreground "white smoke"))))
     ("busy"
      #("☄" 0 1
        (face
         ((:foreground "cyan"))))
      (notmuch-apply-face tag
                          (quote
                           (:foreground "cyan")))))))
 '(notmuch-wash-wrap-lines-length nil)
 '(olivetti-body-width 100 t)
 '(org-adapt-indentation nil)
 '(org-agenda-current-time-string
   #("=========================== NOW ===========================" 0 59
     (org-heading t)))
 '(org-agenda-files
   (quote
    ("/home/jb55/docs/org/projects.org" "/home/jb55/docs/org/tasks.org" "/home/jb55/projects/razorcx/doc/org/todo.org")))
 '(org-agenda-time-grid
   (quote
    ((daily today require-timed)
     ""
     (800 1000 1200 1400 1600 1800 2000))))
 '(org-archive-location "archive/%s_archive::")
 '(org-directory "~/docs/org")
 '(org-duration-format (quote ((special . h:mm))))
 '(org-export-headline-levels 2)
 '(org-export-with-section-numbers nil)
 '(org-export-with-toc nil)
 '(org-format-latex-options
   (quote
    (:foreground default :background default :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\["))))
 '(org-html-head-include-default-style nil)
 '(org-html-head-include-scripts nil)
 '(org-html-postamble nil)
 '(org-refile-targets (quote ((org-agenda-files :maxlevel . 1))))
 '(org-use-sub-superscripts (quote {}))
 '(package-selected-packages
   (quote
    (elm-test-runner doom-modeline eldoc-eval shrink-path counsel-spotify ob-ipython ein request-deferred websocket carbon-now-sh pipenv magithub ghub+ apiwrap magit-svn json-navigator hierarchy ivy-xref magit-gh-pulls magit ghub let-alist org-clock-csv yasnippet-snippets spaceline-all-the-icons all-the-icons memoize centered-cursor-mode font-lock+ visual-fill-column org-mime evil-org tracking w3m typescript-mode powerline test-simple loc-changes load-relative faceup purescript-mode password-generator spinner alert log4e gntp shut-up sml-mode markdown-mode skewer-mode simple-httpd json-snatcher json-reformat multiple-cursors js2-mode insert-shebang prop-menu hydra parent-mode multi window-purpose imenu-list projectile request gitignore-mode pug-mode dot-mode graphviz-dot-mode transcription-mode emms transcribe godoctor go-rename go-guru go-eldoc company-go go-mode magit-popup git-commit with-editor dash async org-category-capture org-plus-contrib helm-notmuch bison-mode smartparens auctex-latexmk org-bullets exec-path-from-shell yapfify yaml-mode ws-butler winum which-key weechat web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package toml-mode toc-org tide symon string-inflection sql-indent spotify spaceline smeargle shen-mode shen-elisp restart-emacs realgud rainbow-delimiters racket-mode racer pyvenv pytest pyenv-mode py-isort psci psc-ide powershell popwin pip-requirements persp-mode pcre2el paradox orgit org-projectile org-present org-pomodoro org-download org-brain open-junk-file omnisharp ob-sml notmuch nix-mode neotree move-text mmm-mode meghanada mastodon markdown-toc magit-gitflow macrostep lua-mode lorem-ipsum livid-mode live-py-mode linum-relative link-hint ledger-mode json-mode js2-refactor js-doc jade-mode intero info+ indent-guide idris-mode hy-mode hungry-delete htmlize hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-spotify helm-pydoc helm-purpose helm-projectile helm-pages helm-nixos-options helm-mode-manager helm-make helm-hoogle helm-gtags helm-gitignore helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag haskell-snippets groovy-mode groovy-imports gradle-mode google-translate golden-ratio gnuplot glsl-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md ggtags fuzzy fsharp-mode flycheck-rust flycheck-pos-tip flycheck-ledger flycheck-haskell flycheck-elm flx-ido fill-column-indicator fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu ereader erc-yt erc-view-log erc-social-graph erc-image erc-hl-nicks ensime engine-mode emojify emoji-cheat-sheet-plus elm-mode elisp-slime-nav dumb-jump disaster define-word cython-mode csv-mode company-tern company-statistics company-nixos-options company-irony company-ghci company-ghc company-emoji company-emacs-eclim company-cabal company-c-headers company-auctex company-anaconda column-enforce-mode coffee-mode cmm-mode cmake-mode clean-aindent-mode clang-format cargo base16-theme auto-yasnippet auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
 '(powerline-color1 "#1E1E1E")
 '(powerline-color2 "#111111")
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" ".svn" "build" "node_modules")))
 '(projectile-mode-line (quote Projectile))
 '(psc-ide-add-import-on-completion t t)
 '(psc-ide-rebuild-on-save nil t)
 '(python-indent-offset 4)
 '(rainbow-identifiers-cie-l*a*b*-lightness 80)
 '(rainbow-identifiers-cie-l*a*b*-saturation 18)
 '(rcirc-buffer-maximum-lines 10000)
 '(ring-bell-function (quote ignore))
 '(rng-nxml-auto-validate-flag nil)
 '(rust-indent-offset 4)
 '(safe-local-variable-values
   (quote
    ((indicate-empty-lines . t)
     (indent-tabs-mode . f)
     (flycheck-clang-include-path "./include" "../include"))))
 '(send-mail-function (quote smtpmail-send-it))
 '(sendmail-program "sendmail")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(smerge-command-prefix "m")
 '(smtpmail-smtp-server "smtp.jb55.com")
 '(smtpmail-smtp-service 587)
 '(standard-indent 4)
 '(tab-width 4)
 '(user-full-name "William Casarin")
 '(user-mail-address "jb55@jb55.com")
 '(vc-follow-symlinks t)
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
 )
