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

;; Time Report
(defun tr/parse-org-clock-entries (file)
  "Return list of (date heading minutes) from FILE's CLOCK entries."
  (let (entries)
    (with-current-buffer (find-file-noselect file)
      (org-with-wide-buffer
       (goto-char (point-min))
       (while (re-search-forward
               "CLOCK: \\[\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}\\) [A-Za-z]\\{3\\} [0-9:]\\{5\\}\\]--\\[\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}\\) [A-Za-z]\\{3\\} \\([0-9:]\\{5\\}\\)\\] =>  *\\([0-9]+\\):\\([0-9]+\\)"
               nil t)
         (let* ((date (match-string 1))
                (h    (string-to-number (match-string 4)))
                (m    (string-to-number (match-string 5)))
                (mins (+ (* h 60) m))
                (heading (save-excursion
                           (org-back-to-heading t)
                           (org-get-heading t t t t))))
           (push (list date heading mins) entries)))))
    (nreverse entries)))

(defun tr/format-minutes (mins)
  (format "%d:%02d" (/ mins 60) (mod mins 60)))

(defun tr/generate-report (input-file output-file &optional tstart tend)
  "Parse INPUT-FILE and write time report to OUTPUT-FILE."
  (let* ((entries (tr/parse-org-clock-entries input-file))
         (entries (if (or tstart tend)
                      (cl-remove-if-not
                       (lambda (e)
                         (let ((d (car e)))
                           (and (or (null tstart) (not (string< d tstart)))
                                (or (null tend)   (not (string> d tend))))))
                       entries)
                    entries))
         (totals (make-hash-table :test #'equal)))
    (dolist (e entries)
      (let ((key (cons (nth 0 e) (nth 1 e))))
        (puthash key (+ (gethash key totals 0) (nth 2 e)) totals)))
    (let* ((keys (hash-table-keys totals))
           (keys (sort keys (lambda (a b)
                              (or (string< (car a) (car b))
                                  (and (string= (car a) (car b))
                                       (string< (cdr a) (cdr b)))))))
           (current-week nil))
      (with-temp-file output-file
        (insert "#+title: Time Report\n\n")
        (insert (format "| %-12s | %-45s | %5s |\n" "Date" "Code" "Hours"))
        (insert (concat "|" (make-string 14 ?-) "+" (make-string 47 ?-) "+" (make-string 7 ?-) "|\n"))
        (let (week-mins week-start)
          (dolist (k keys)
            (let* ((date (car k))
                   (heading (cdr k))
                   (mins (gethash k totals))
                   (time (date-to-time (concat date " 00:00:00")))
                   (week (format-time-string "%Y-W%V" time)))
              (when (and week-start (not (string= week current-week)))
                (insert (concat "|" (make-string 14 ?-) "+" (make-string 47 ?-) "+" (make-string 7 ?-) "|\n"))
                (insert (format "| %-12s | %-45s | %5s |\n" current-week "WEEK TOTAL" (tr/format-minutes week-mins)))
                (insert (concat "|" (make-string 14 ?-) "+" (make-string 47 ?-) "+" (make-string 7 ?-) "|\n"))
                (setq week-mins 0))
              (unless (string= week current-week)
                (setq current-week week week-start date week-mins 0))
              (setq week-mins (+ week-mins mins))
              (insert (format "| %-12s | %-45s | %5s |\n" date heading (tr/format-minutes mins)))))
          (when week-mins
            (insert (concat "|" (make-string 14 ?-) "+" (make-string 47 ?-) "+" (make-string 7 ?-) "|\n"))
            (insert (format "| %-12s | %-45s | %5s |\n" current-week "WEEK TOTAL" (tr/format-minutes week-mins)))))
        (insert "\n")))))

(defun tr/time-report-interactive ()
  "Interactively generate a time report from an org file."
  (interactive)
  (let* ((input  (read-file-name "Time tracking file: " nil nil t))
         (output (read-file-name "Output report file: "))
         (tstart (read-string "Start date (YYYY-MM-DD, blank for none): "))
         (tend   (read-string "End date   (YYYY-MM-DD, blank for none): "))
         (tstart (if (string-empty-p tstart) nil tstart))
         (tend   (if (string-empty-p tend)   nil tend)))
    (tr/generate-report input output tstart tend)
    (find-file output)
    (message "Report written to %s" output)))

;; Map time report to keybindings
(map! :leader
      :desc "Generate time report" "z t" #'tr/time-report-interactive)
