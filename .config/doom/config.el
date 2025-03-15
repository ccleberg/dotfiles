;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Christian Cleberg"
      user-mail-address "hello@cmc.pub")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; load packages and programs
;; (use-package mu4e
;;   :load-path  "/Users/cmc/.config/emacs/modules/email/mu4e/")
;; (require 'smtpmail)
;; (setq mu4e-mu-binary (executable-find "mu"))

;; set base directory
;; (setq mu4e-maildir "~/.maildir")

;; sync imap servers
;; (setq mu4e-get-mail-command (concat (executable-find "mbsync") " -a"))

;; how often to sync in seconds
;; (setq mu4e-update-interval 300)

;; save attachments to defined directory
;; (setq mu4e-attachment-dir "~/Downloads")

;; rename files when moving - needed for mbsync:
;; (setq mu4e-change-filenames-when-moving t)

;; list of your email adresses:
;; (setq mu4e-user-mail-address-list '("hello@cmc.pub"))

;; check your ~/.maildir to see naming of subdirectories
;; (setq   mu4e-maildir-shortcuts
;;         '(("/migadu/INBOX" . ?e)
;;           ("/migadu/Sent" . ?E)))

;; (setq mu4e-contexts
;;       `(,(make-mu4e-context
;;           :name "migadu"
;;           :enter-func
;;           (lambda () (mu4e-message "Enter hello@cmc.pub context"))
;;           :leave-func
;;           (lambda () (mu4e-message "Leave hello@cmc.pub context"))
;;           :match-func
;;           (lambda (msg)
;;             (when msg
;;               (mu4e-message-contact-field-matches msg
;;                                                   :to "hello@cmc.pub")))
;;           :vars '((user-mail-address . "hello@cmc.pub")
;;                   (user-full-name . "Christian Cleberg")
;;                   ;; check your ~/.maildir to see how the subdirectories are called
;;                   ;; e.g `ls ~/.maildir/migadu'
;;                   (mu4e-drafts-folder . "/migadu/Drafts")
;;                   (mu4e-refile-folder . "/migadu/Archive")
;;                   (mu4e-sent-folder . "/migadu/Sent")
;;                   (mu4e-trash-folder . "/migadu/Trash")))))

;; (setq mu4e-context-policy 'pick-first) ;; start with the first (default) context;
;; (setq mu4e-compose-context-policy 'ask) ;; ask for context if no context matches;

;; gpg encryptiom & decryption:
;; this can be left alone
;; (require 'epa-file)
;; (epa-file-enable)
;; (setq epa-pinentry-mode 'loopback)
;; (auth-source-forget-all-cached)

;; don't keep message compose buffers around after sending:
;; (setq message-kill-buffer-on-exit t)

;; send function:
;; (setq send-mail-function 'sendmail-send-it
;;       message-send-mail-function 'sendmail-send-it)

;; send program:
;; (setq sendmail-program (executable-find "msmtp"))

;; select the right sender email from the context.
;; (setq message-sendmail-envelope-from 'header)

;; mu4e cc & bcc
;; (add-hook 'mu4e-compose-mode-hook
;;           (defun timu/add-cc-and-bcc ()
;;             "My Function to automatically add Cc & Bcc: headers.
;;     This is in the mu4e compose mode."
;;             (save-excursion (message-add-header "Cc:\n"))
;;             (save-excursion (message-add-header "Bcc:\n"))))

;; mu4e address completion
;; (add-hook 'mu4e-compose-mode-hook 'company-mode)
