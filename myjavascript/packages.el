;;; packages.el --- myjavascript layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2020 Sylvain Benner & Contributors
;;
;; Author: Matthias Scholz <matthias.scholz@gmail.com>
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
;; added to `myjavascript-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `myjavascript/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `myjavascript/pre-init-PACKAGE' and/or
;;   `myjavascript/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

;; (defconst myjavascript-packages
;;   '(
;;     prettier
;;     import-js
;;     )
;;   "The list of Lisp packages required by the myjavascript layer."
;;   )
;;
;; (defun myjavascript/init-prettier ()
;;   (use-package prettier
;;     :defer t))
;;
;; (defun myjavascript/init-import-js ()
;;   (use-package import-js
;;     :defer t))
;;; packages.el ends here
