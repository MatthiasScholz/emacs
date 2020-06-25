;;; packages.el --- tools layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Matthias Scholz <matthias@Matthiass-MacBook-Pro.local>
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
;; added to `tools-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `tools/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `tools/pre-init-PACKAGE' and/or
;;   `tools/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst tools-packages
  '(
    terraform-mode
    company-terraform
    dockerfile-mode
    docker-tramp
;;    plantuml-mode
    org-mode
    sh-mode
    bats-mode
    markdown-mode
    )
  )

(defun tools/post-init-terraform-mode()
  (use-package terraform-mode
    :config
    (progn
      (add-hook 'terraform-mode-hook 'terraform-format-on-save-mode)
      (add-hook 'terraform-mode-hook 'flycheck-mode))
    )
  )

(defun tools/init-company-terraform ()
  (use-package company-terraform
    :config
    (progn
      (company-terraform-init))
    )
  )

(defun tools/post-init-dockerfile-mode ()
  (use-package dockerfile-mode)
  )

(defun tools/post-init-docker-tramp ()
  (use-package docker-tramp)
  )

(defun tools/post-init-org-mode ()
  (use-package org-mode)
  )

;; NOT WORKING
;;(defun tools/init-plantuml-mode ()
;;  (use-package plantuml-mode)
;;  :config
;;  (progn
;;    (set plantuml-default-exec-mode 'executable)
;;    (add-to-list
;;     'org-src-lang-modes '("plantuml" . plantuml))
;;    )
;;  )

;; Activating indirectly shellcheck via flycheck
(defun tools/post-init-sh-mode ()
  (use-package sh-mode)
  :config
  (progn
    (add-hook 'sh-mode-hook 'flycheck-mode))
  )

;; Activate bats-mode and flycheck
(defun tools/init-bats-mode ()
  (use-package bats-mode
    :config
    (progn
      (add-hook 'bats-mode-hook 'flycheck-mode))
    )
  )

;; Activate flycheck for Markdown
(defun tools/post-init-markdown-mode ()
  (use-package markdown-mode
    :config
    (progn
      (add-hook 'markdown-mode 'flycheck-mode))
    )
  )

;;; packages.el ends here
