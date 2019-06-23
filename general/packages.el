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
    origami
    highlight-symbol
    helm-mt
    helm-swoop
    company
    dockerfile-mode
    docker-tramp
    paradox
    hcl-mode
    terraform-mode
    company-terraform
    keyfreq
    compile
    )
  )

(defun general/init-hcl-mode ()
  (use-package hcl-mode))
(defun general/post-init-terraform-mode ()
  )
(defun general/init-company-terraform ()
  (use-package company-terraform))

;; FIXME: Storing the key in an repositroy is generally a bad idea!
(defun general/post-init-paradox ()
  (setq paradox-github-token '53f1f0c65f90f8fea51e9ced4ae49f1dd7f5fffd))

(defun general/post-init-origami ()
  (use-package origami
    :config
    (setq global-origami-mode 't)
  (global-set-key (kbd "TAB") 'origami-recursively-toggle-node)))

(defun general/init-highlight-symbol ()
  (use-package highlight-symbol
    :config
    (setq global-auto-highlight-symbol-mode 't)
    (setq highlight-symbol-nav-mode 't)
    (setq highlight-symbol-idle-delay 0.1)))

(defun general/init-helm-mt ()
  (use-package helm-mt
              :after helm multi-term))

(defun general/post-init-dockerfile-mode ()
  )

(defun general/post-init-docker-tramp ()
  )


;; TODO REFACTOR it could make sense to put helm-swoop into a separate layer since lots of configuration is provided here.
(defun general/post-init-helm-swoop ()
  (use-package helm-swoop
    :after helm
    :config
    (progn
      ;; Change the general keybinds to whatever you like :)
      (global-set-key (kbd "M-i") 'helm-swoop)
      (global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
      (global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
      (global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

      ;; When doing isearch, hand the word over to helm-swoop
      (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
      ;; From helm-swoop to helm-multi-swoop-all
      (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
      ;; When doing evil-search, hand the word over to helm-swoop
      ;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)

      ;; Instead of helm-multi-swoop-all, you can also use helm-multi-swoop-current-mode
      (define-key helm-swoop-map (kbd "M-m") 'helm-multi-swoop-current-mode-from-helm-swoop)

      ;; Move up and down like isearch
      (define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
      (define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
      (define-key helm-multi-swoop-map (kbd "C-r") 'helm-previous-line)
      (define-key helm-multi-swoop-map (kbd "C-s") 'helm-next-line)
      (global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

      ;; When doing isearch, hand the word over to helm-swoop
      (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
      ;; From helm-swoop to helm-multi-swoop-all
      (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
      ;; When doing evil-search, hand the word over to helm-swoop
      ;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)

      ;; Instead of helm-multi-swoop-all, you can also use helm-multi-swoop-current-mode
      (define-key helm-swoop-map (kbd "M-m") 'helm-multi-swoop-current-mode-from-helm-swoop)

      ;; Move up and down like isearch
      (define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
      (define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
      (define-key helm-multi-swoop-map (kbd "C-r") 'helm-previous-line)
      (define-key helm-multi-swoop-map (kbd "C-s") 'helm-next-line)

      ;; ;; If this value is t, split window inside the current window
      (setq helm-swoop-split-with-multiple-windows nil)
      ;; ;; Split direction. 'split-window-vertically or 'split-window-horizontally
      (setq helm-swoop-split-direction 'split-window-horizontally)

      ;; Save buffer when helm-multi-swoop-edit complete
      (setq helm-multi-swoop-edit-save t)

      ;; If nil, you can slightly boost invoke speed in exchange for text color
      (setq helm-swoop-speed-or-color t)

      ;; ;; Go to the opposite side of line from the end or beginning of line
      (setq helm-swoop-move-to-line-cycle t)

      ;; Optional face for line numbers
      ;; Face name is `helm-swoop-line-number-face`
      (setq helm-swoop-use-line-number-face t)

      ;; If you prefer fuzzy matching
      (setq helm-swoop-use-fuzzy-match t)

      ;; If there is no symbol at the cursor, use the last used words instead.
      (setq helm-swoop-pre-input-function
            (lambda ()
              (let (($pre-input (thing-at-point 'symbol)))
                (if (eq (length $pre-input) 0)
                    helm-swoop-pattern ;; this variable keeps the last used words
                  $pre-input))))
    )
  )
)

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


;; Neo2 configuration:
(setq ns-right-alternate-modifier nil)
(setq ns-alternate-modifier 'meta)
;; Deactivte special space of the layer 3
(global-set-key (kbd " ") " ")

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

;; Helm configuration
;; https://github.com/syohex/emacs-helm-ag
;; helm-ag-base-command:
;;  ag --vimgrep --line-numbers -S --hidden --color --nogroup %s %s %s


;;; packages.el ends here
