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
    org-brain
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
    (setq org-directory "~/Dropbox/Notes")
    (setq org-agenda-files '("~/Dropbox/Notes"))
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

  ;; Configure capture
  (setq org-default-notes-file (concat org-directory "/capture.org"))
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline org-default-notes-file "Tasks")
           "* TODO %?\n   %T\n %i\n %a\n" :clock-in t :clock-resume t)
          ("j" "Journal" entry (file+datetree (concat org-directory "/journal.org"))
           "** %?\nEntered on %U\n %i\n %a\n")
          ))
  )

(defun orgmode/post-init-org-inlinetask ()
  )

(defun orgmode/post-init-deft ()
  (when (memq system-type '(windows-nt ms-dos))
    (setq deft-directory "D:\\Documents\\Notes")
    )
  )

(defun orgmode/init-org-brain ()
  (use-package org-brain)
  )

;;; packages.el ends here
