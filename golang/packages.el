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
    go-dlv
    golint
    )
  )

(defun golang/post-init-go-mode ()
  ;; use goimports as a more sophisticated replacement of go fmt
  (setq gofmt-command "goimports")

  ;; run go fmt automatically when saving
  (add-hook 'before-save-hook #'gofmt-before-save)
  )

;; Applying the environment variables define in the shell ( bash, zsh ) for emacs
(defun golang/post-init-projectile ()
  (when (memq window-system '(mac ns))
     (exec-path-from-shell-initialize)
     (exec-path-from-shell-copy-env "GOPATH"))
  )

;; Configure the debugger
(defun golang/init-go-dlv ()
  (use-package go-dlv)
  (setq go-dlv-command-name '"~/go/bin/dlv"))

(defun golang/init-go-projectile ()
  (use-package go-projectile
    ))

(defun golang/post-init-company-go ()
  (use-package company-go
	       ))

;; Requires golint installed in the GOPATH!
(defun golang/init-golint ()
  (use-package golint)
  )

;; Go mode and imenu
;; Support multi line golang function signatures
;; https://emacs.stackexchange.com/questions/30797/imenu-is-missing-multi-line-golang-function-signatures
(defun my-go-mode-hook ()
                                        ; Custom imenu regexes
  (setq imenu-generic-expression
        '(("type" "^[ \t]*type *\\([^ \t\n\r\f]*[ \t]*\\(struct\\|interface\\)\\)" 1)
          ("func" "^func *\\(.*\\)" 1)))
  )

(add-hook 'go-mode-hook 'my-go-mode-hook)

;;; packages.el ends here
