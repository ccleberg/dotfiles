;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; User Information
(setq user-full-name "Christian Cleberg"
      user-mail-address "hello@cleberg.net")

;; Visuals
(setq doom-theme 'doom-homage-black)
(setq display-line-numbers-type t)

;; Corfu
(after! corfu
  (setq corfu-auto t               ; Enable auto-completion
        corfu-auto-delay 0.1       ; Shorter delay (default is 0.2)
        corfu-auto-prefix 2        ; Complete after 2 characters
        corfu-quit-at-boundary t)  ; Quit when hitting space/non-matching
  (add-hook 'doom-first-input-hook #'global-corfu-mode))

;; Org-Mode & Roam
(setq org-directory "~/Documents/notes/")
(setq org-roam-directory (file-name-concat org-directory "roam"))

(after! org
  (setq org-hide-emphasis-markers t
        org-appearance-autolinks t
        org-pretty-entities t
        org-agenda-files '("~/Documents/notes/")))

(setq org-capture-templates
      '(("t" "Personal todo" entry
         (file+headline "~/Documents/notes/todo.org" "Inbox")
         "* TODO %?\n%i\n%a")
        ("n" "Personal notes" entry
         (file+headline "~/Documents/notes/notes.org" "Inbox")
         "* %u %?\n%i\n%a")))

;; Abbreviations
(setq-default abbrev-mode t)
(define-abbrev-table 'global-abbrev-table
  '(
    ;; ("abbreviation" "expansion")
    ("omw" "on my way")
    ("eml" "hello@cleberg.net")
    ("shrg" "¯\_(ツ)_/¯")
    ("teh" "the")
    ("xtoday" "" (lambda () (insert (format-time-string "%Y-%m-%d %H:%M:%S"))))
    ("xnow" "" (lambda () (insert (format-time-string "%H:%M:%S"))))
    ))

