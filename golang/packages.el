;;; packages.el --- golang layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Matthias Scholz <mat@MatMac.fritz.box>
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
;; added to `golang-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `golang/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `golang/pre-init-PACKAGE' and/or
;;   `golang/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst golang-packages
  '(
    projectile
    go-projectile
    company-go
    go-mode
    )
  )

(defun golang/post-init-go-mode ()
  (add-hook 'before-save-hook #'gofmt-before-save))

(defun golang/post-init-projectile ()
  (when (memq window-system '(mac ns))
     (exec-path-from-shell-initialize)
     (exec-path-from-shell-copy-env "GOPATH"))
  )

(defun golang/init-go-projectile ()
  (use-package go-projectile
    ))

(defun golang/post-init-company-go ()
  )

;;; packages.el ends here

    
