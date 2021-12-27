;;; packages.el --- tramp layer packages file for Spacemacs.
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

;; References
;; . Using pscp method for access ( https://www.emacswiki.org/emacs/Comments_on_Tramp_on_Windows )
;; . Configure plink ( https://rentes.github.io/emacs/windows/ssh/2016/08/25/Editing-Remote-Files-With-Emacs-Under-Windows/ )
;; . General, but confusing ( https://www.emacswiki.org/emacs/TrampMode#toc32 )


;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `tramp-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `tramp/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `tramp/pre-init-PACKAGE' and/or
;;   `tramp/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst tramp-packages
  '(tramp
    ;; UNUSED dired
    )
  )

;; https://www.emacswiki.org/emacs/TrampMode
;; D:\Software\PortableApps\PuTTYPortable\App\putty
(defun tramp/post-init-tramp ()
  ;; https://www.emacswiki.org/emacs/Tramp_on_Windows
  (when (eq window-system 'w32)
    (set-default 'tramp-auto-save-directory "C:\\Users\\matthias.scholz\\AppData\\Local\\Temp")
    (setq tramp-default-method "plink")
    (when (and (not (string-match putty-directory (getenv "PATH")))
	             (file-directory-p putty-directory))
      (setenv "PATH" (concat putty-directory ";" (getenv "PATH")))
      (add-to-list 'exec-path putty-directory)))
  )

(defun tramp/sudo-edit-current-file ()
  (interactive)
  (let ((my-file-name) ; fill this with the file to open
        (position))    ; if the file is already open save position
    (if (equal major-mode 'dired-mode) ; test if we are in dired-mode 
        (progn
          (setq my-file-name (dired-get-file-for-visit))
          (find-alternate-file (prepare-tramp-sudo-string my-file-name)))
      (setq my-file-name (buffer-file-name); hopefully anything else is an already opened file
            position (point))
      (find-alternate-file (prepare-tramp-sudo-string my-file-name))
      (goto-char position))))


(defun tramp/prepare-tramp-sudo-string (tempfile)
  (if (file-remote-p tempfile)
      (let ((vec (tramp-dissect-file-name tempfile)))

        (tramp-make-tramp-file-name
         "sudo"
         (tramp-file-name-user nil)
         (tramp-file-name-host vec)
         (tramp-file-name-localname vec)
         (format "ssh:%s@%s|"
                 (tramp-file-name-user vec)
                 (tramp-file-name-host vec))))
    (concat "/sudo:root@localhost:" tempfile)))

;; TODO UNTESTED, maybe unneeded
;;(defun general/init-dired ()
;;  (use-package dired))

;;(define-key dired-mode-map [s-return] 'sudo-edit-current-file)

;;; packages.el ends here
