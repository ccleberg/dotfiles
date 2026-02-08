;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; User Information
(setq user-full-name "Christian Cleberg"
      user-mail-address "hello@cleberg.net")

;; Visuals
(setq doom-theme 'doom-homage-black)
(setq display-line-numbers-type t)

;; Org-Mode
(setq org-directory "~/Documents/notes/")
(setq org-agenda-files '("~/Documents/notes/"))
(setq org-capture-templates
      '(("t" "Personal todo" entry
         (file+headline "~/Documents/notes/todo.org" "Inbox")
         "* TODO %?\n%i\n%a")
        ("n" "Personal notes" entry
         (file+headline "~/Documents/notes/notes.org" "Inbox")
         "* %u %?\n%i\n%a")))
(after! org
  (setq org-hide-emphasis-markers t
        org-appearance-autolinks t
        org-pretty-entities t))

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
