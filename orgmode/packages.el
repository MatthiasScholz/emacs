;;; packages.el --- orgmode layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author:  <scholz_m2@DEDRENB045>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `orgmode-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `orgmode/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `orgmode/pre-init-PACKAGE' and/or
;;   `orgmode/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst orgmode-packages
  '(
    org
    org-inlinetask
    deft
    ;; NOT WORKING org-brain
    ;; DISABLED org-trello
    )
  )

(defun orgmode/post-init-org ()
  ;; Configure path to the notes depending on the operating system
  ;; Windows
  (when (memq system-type '(windows-nt ms-dos))
    (setq org-directory "D:\\Documents\\Notes")
    (setq org-agenda-files '("D:\\Documents\\Notes"))
    )

  ;; MacOSX
  (when (memq system-type '(darwin))
    (setq org-directory "~/Documents/Notes")
    ;; NOT WORKING recursively:
    ;; (setq org-agenda-files '("~/Dropbox/Notes"))

    (setq org-agenda-files (apply 'append
			                            (mapcar
			                             (lambda (directory)
				                             (directory-files-recursively
				                              directory org-agenda-file-regexp))
			                             '("~/Documents/Notes"))))
    )

  (setq org-archive-location "archive/%s::")

  ;; Configure keywords
  (setq org-todo-keywords
        '((sequence "TODO(t)"
                    "IN-PROGRESS(i)"
                    "WAIT(w@/!)"
                    "|"
                    "DELEGATED(m)"
                    "DONE(d!)"
                    "CANCELED(c@)"
                    )))

  (setq org-todo-keyword-faces
        '(("TODO"        . "red")
          ("IN-PROGRESS" . "yellow")
          ("WAIT"        . "orange")
          ("DELEGATED"   . "green")
          ))

  (setq org-highest-priority ?A)
  (setq org-lowest-priority ?D)
  (setq org-default-priority ?B)

  ;; Open Agenda at startup
  ;; https://stackoverflow.com/questions/23528287/how-to-display-custom-agenda-view-on-emacs-startup
  (add-hook 'after-init-hook (lambda () (org-agenda nil "d")))

  ;; Configure capture
  (setq org-default-notes-file (concat org-directory "/capture.org"))
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline org-default-notes-file "Tasks")
           "* TODO %?\n   %T\n %i\n %a\n" :clock-in t :clock-resume t)
          ("j" "Journal" entry (file+datetree (concat org-directory "/journal.org"))
           "** %?\nEntered on %U\n %i\n %a\n")
          ))

  ;; Colorise code blocks
  (setq org-src-fontify-natively t)

  )

;; Setup a custom agenda view
(defun help-org-skip-subtree-if-priority (priority)
  "Skip an agenda subtree if it has a priority of PRIORITY.

PRIORITY may be one of the characters ?A, ?B, or ?C."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
        (pri-value (* 1000 (- org-lowest-priority priority)))
        (pri-current (org-get-priority (thing-at-point 'line t)))
        )
    (if (= pri-value pri-current)
        subtree-end
      nil)
    )
  )

;; Filtering support for habits
(defun help-org-skip-subtree-if-habit ()
  "Skip an agenda entry if it has a STYLE property equal to \"habit\"."
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (string= (org-entry-get nil "STYLE") "habit")
        subtree-end
      nil)))

;; Setting up a custom agenda view. Listing:
;; .high priority tasks ( "A" )
;; .scheduled tasks for the current day
;; .unscheduled tasks
;; HINT: Take into account that the default priority of tasks is "B"
(setq org-agenda-custom-commands
      '(("d" "Daily agenda and all TODOs"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function
                  '(org-agenda-skip-entry-if 'todo '("DONE" "CANCELED" "DELEGATED"))
                  )
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (agenda "" ((org-agenda-span 1)))
          (alltodo ""
                   ((org-agenda-skip-function '(or (help-org-skip-subtree-if-habit)
                                                   (help-org-skip-subtree-if-priority ?A)
                                                   (org-agenda-skip-if nil '(scheduled deadline))))
                    (org-agenda-overriding-header "ALL normal priority tasks:"))))
         )))

(defun orgmode/post-init-org-inlinetask ()
  )

(defun orgmode/post-init-deft ()
  (use-package org)

  ;; NOT WORKING: (setq deft-directory org-directory)

  ;; Windows
  (when (memq system-type '(windows-nt ms-dos))
    (setq deft-directory "D:\\Documents\\Notes")
    )

  ;; MacOSX
  (when (memq system-type '(darwin))
    (setq deft-directory "~/Documents/Notes")
    )
  )

;; NOT WORKING: Error (use-package): org-brain/:config: Symbol’s value as variable is void: org-capture-templates
;; (defun orgmode/post-init-org-brain ()
;;   (use-package org-brain :ensure t
;;     :init
;;     (setq org-brain-path org-directory)
;;     :config
;;     (setq org-id-track-globally t)
;;     (setq org-id-locations-file (concat org-brain-path "/.org-id-locations"))
;;     (push '("b" "Brain" plain (function org-brain-goto-end)
;;             "* %i%?" :empty-lines 1)
;;           org-capture-templates)
;;     (setq org-brain-visualize-default-choices 'all)
;;     (setq org-brain-title-max-length 24)
;;     )
;;   )

;; DISABLED -> https://develop.spacemacs.org/layers/+emacs/org/README.html#trello-support
;; Configure org-trello
;; Execute: M-x org-trello-install-key-and-token to configure connection to trello
;; (defun orgmode/post-init-org-trello ()
;; (use-package org-trello :ensure t
;;    :config
;;    ;; org-trello major mode for all .trello files
;;    ;; https://org-trello.github.io/usage.html#automatic-org-trello-files-in-emacs
;;    (add-to-list 'auto-mode-alist '("\\.trello$" . org-mode))
;;
;;    ;; add a hook function to check if this is trello file, then activate the org-trello minor mode.
;;    (add-hook 'org-mode-hook
;;              (lambda ()
;;                (let ((filename (buffer-file-name (current-buffer))))
;;                  (when (and filename (string= "trello" (file-name-extension filename)))
;;                    (org-trello-mode)))))
;;    )
;;  )

;;; packages.el ends here
