;;; packages.el --- general layer packages file for Spacemacs.
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
;; added to `general-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `general/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `general/pre-init-PACKAGE' and/or
;;   `general/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst general-packages
  '(
    highlight-symbol
    helm-mt
    company
    ;; UNUSED paradox
    hcl-mode
    keyfreq
    compile
    company
    ;; UNUSED restclient
    ;; UNUSED company-restclient
    vlf
    )
  )

(defun general/init-hcl-mode ()
  (use-package hcl-mode))

;; UNUSED ;; FIXME: Storing the key in an repositroy is generally a bad idea!
;; UNUSED (defun general/post-init-paradox ()
;; UNUSED   (setq paradox-github-token '53f1f0c65f90f8fea51e9ced4ae49f1dd7f5fffd))

;; UNUSED (defun general/init-highlight-symbol ()
;; UNUSED   (use-package highlight-symbol
;; UNUSED     :config
;; UNUSED     (setq global-auto-highlight-symbol-mode 't)
;; UNUSED     (setq highlight-symbol-nav-mode 't)
;; UNUSED     (setq highlight-symbol-idle-delay 0.1)))

(defun general/init-helm-mt ()
  (use-package helm-mt
    :after helm multi-term))
  )

;; UNUSED ;; REST Client
;; UNUSED ;; https://github.com/pashky/restclient.el
;; UNUSED (defun general/init-restclient ()
;; UNUSED   (use-package restclient))
;; UNUSED
;; UNUSED ;; REST Client Completion
;; UNUSED ;; https://github.com/iquiw/company-restclient
;; UNUSED (defun general/init-company-restclient ()
;; UNUSED   (use-package company-restclient)
;; UNUSED   (add-to-list 'company-backends 'company-restclient)
;; UNUSED   )

;; generic company configuration
(defun general/post-init-company ()
  (setq company-tooltip-limit 20)                      ; bigger popup window
  (setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
  (setq company-echo-delay 0)                          ; remove annoying blinking
  (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
  )


;; Keybindings
(global-set-key (kbd "M-s o") 'helm-occur)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)


;; UNUSED (global-set-key (kbd "C-x C-b") 'helm-buffers-list)

;; Overwrite selection with pasted text
(delete-selection-mode 1)


;; Detect system to setup some system dependent settings
(if (eq system-type 'windows-nt)
    ;; ON Windows
    (progn
      (message "We are on windows")
      ;; path to aspell, silversearcher, git, ... executables
      (add-to-list 'exec-path "D:/Software/PortableApps/CygwinPortable/App/Runtime/Cygwin/bin")

      ;;disable the version control
      (setq vc-handled-backends ())

      ;; to improve speed a little bit
      (setq w32-get-true-file-attributes nil)

      ;; Helm ag 
      (add-to-list 'exec-path "D:/Software/PortableApps/ag/")
      )
  )


;; make unix lineendings default
(setq default-buffer-file-coding-system 'utf-8-unix)


;; Configure GNU make as the default format for Makefiles
(add-to-list 'auto-mode-alist '("Makefile.*" . makefile-gmake-mode))

;; Activate Command Usage Statistics
(defun general/post-init-keyfreq ()
  (use-package keyfreq
    :config
    (keyfreq-mode 1)
    (keyfreq-autosave-mode 1)))

;; Compilation Buffer Configuration
(defun general/post-init-compile ()
  (setq compilation-scroll-output 'first-error)
  )

;; Activate Flycheck globally
(setq flycheck-global-modes t)

;; Helm configuration
;; https://github.com/syohex/emacs-helm-ag
;; helm-ag-base-command:
;;  ag --vimgrep --line-numbers -S --hidden --color --nogroup %s %s %s


;;; packages.el ends here
