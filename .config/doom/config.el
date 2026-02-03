;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Christian Cleberg"
      user-mail-address "hello@cleberg.net")
(setq doom-theme 'doom-homage-black)
(setq display-line-numbers-type t)
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
