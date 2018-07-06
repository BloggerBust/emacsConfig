;; package-management

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(require 'cask "~/dev/cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
;                        ("marmalade" . "https://marmalade-repo.org/packages/")
                        ("melpa" . "https://melpa.org/packages/")
                        ("org" . "https://orgmode.org/elpa/")))

;; load modes
(require 'rcirc)
(require 'company)                                   ; load company mode
(require 'company-web-jade)                          ; load company mode jade backend
(require 'company-web-slim)                          ; load company mode slim backend
(require 'stylus-mode)
(require 'auth-source)

(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))

;; company-mode color
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-preview ((t (:foreground "darkgray" :underline t))))
 '(company-preview-common ((t (:inherit company-preview))))
 '(company-tooltip ((t (:background "lightgray" :foreground "black"))))
 '(company-tooltip-common ((((type x)) (:inherit company-tooltip :weight bold)) (t (:inherit company-tooltip))))
 '(company-tooltip-common-selection ((((type x)) (:inherit company-tooltip-selection :weight bold)) (t (:inherit company-tooltip-selection))))
 '(company-tooltip-selection ((t (:background "steelblue" :foreground "white"))))
 '(magit-blame-date ((t (:inherit magit-blame-heading))) t)
 '(magit-blame-heading ((t (:background "grey25" :foreground "cyan"))))
 '(magit-diff-added ((t (:background "blue" :foreground "#ddffdd"))))
 '(magit-diff-added-highlight ((t (:background "blue" :foreground "#cceecc"))))
 '(magit-hash ((t (:foreground "yellow3")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(org-babel-load-languages (quote ((emacs-lisp . t) (python . t) (shell . t))))
 '(org-babel-uppercase-example-markers t)
 '(org-time-clocksum-format
   (quote
    (:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t)))
 '(package-selected-packages
   (quote
    (shut-up company-restclient restclient restclient-helm websocket json-mode typescript-mode ledger-mode cask dash dash-functional epl f ghub metaweblog org s with-editor markdown-mode markdown-preview-eww markdown-preview-mode company projectile flycheck-pyflakes async flycheck git-commit helm helm-core magit-popup package-build yasnippet web-mode stylus-mode smartparens pallet palette org-plus-contrib multiple-cursors magit jade-mode idle-highlight-mode htmlize helm-projectile flycheck-cask expand-region expand-line drag-stuff company-web company-tern color-theme-sanityinc-tomorrow bind-key auto-complete ace-jump-mode ac-html-csswatcher ac-html-bootstrap)))
 '(temporary-file-directory "~/.emacs.d/.tmp"))
