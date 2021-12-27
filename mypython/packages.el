;;; packages.el --- python layer packages file for Spacemacs.
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
;; added to `mypython-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `mypython/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `mypython/pre-init-PACKAGE' and/or
;;   `mypython/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst mypython-packages
  '(
    flycheck
    )
)


(defun mypython/post-init-python ()
  (setq python-shell-interpreter "ipython")
  (setq python-shell-interpreter-args "--simple-prompt -i")
  ;; Using auto formatter: python3 -m pip install pyls-black
  (setq python-formatter 'black)
  ;; Using auto formatting on save
  (setq python-format-on-save t)
  )

;; TODO Check if flycheck is a layer or a package
(defun mypython/post-init-flycheck ()
  (setq flycheck-python-pycompile-executable "python3")
  )

;;; packages.el ends here
