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
    ;; NOT WORKING recursively:
    ;; (setq org-agenda-files '("~/Dropbox/Notes"))

    (setq org-agenda-files (apply 'append
			                            (mapcar
			                             (lambda (directory)
				                             (directory-files-recursively
				                              directory org-agenda-file-regexp))
			                             '("~/Dropbox/Notes"))))
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
  (use-package org)

  ;; NOT WORKING: (setq deft-directory org-directory)

  ;; Windows
  (when (memq system-type '(windows-nt ms-dos))
    (setq deft-directory "D:\\Documents\\Notes")
    )

  ;; MacOSX
  (when (memq system-type '(darwin))
    (setq deft-directory "~/Dropbox/Notes")
    )
  )

(defun orgmode/init-org-brain ()
  (use-package org-brain :ensure t
    :init
    (setq org-brain-path org-directory)
    :config
    (setq org-id-track-globally t)
    (setq org-id-locations-file (concat org-brain-path "/.org-id-locations"))
    (push '("b" "Brain" plain (function org-brain-goto-end)
            "* %i%?" :empty-lines 1)
          org-capture-templates)
    (setq org-brain-visualize-default-choices 'all)
    (setq org-brain-title-max-length 24)
    )
  )

;;; packages.el ends here
