;; package-management

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'cask "~/.emacs.d/.cask/25.2/elpa/cask-20161024.1205/cask.el") ;; How should this be properly maintained?
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

(when (window-system)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))


;; mode line customization
(setq display-time-day-and-date t)
(display-time-mode 1)

;; keymaps
(defvar my-keys-minor-mode-map (make-keymap) "my keys")

;; Keeping things backed up
(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.emacs.d/.saves"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups

;; Configure workflow
(ido-mode -1) ;; disable ido-mode, we will use helm from now on.
(projectile-global-mode 1) ;; give emacs the concepts of projects
(helm-mode t)
(helm-projectile-on)
(global-set-key (kbd "M-x")                          'undefined)
(global-set-key (kbd "M-x")                          'helm-M-x)
(global-set-key (kbd "C-x r b")                      'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f")                      'helm-find-files)
(global-set-key (kbd "C-c h")                        'help)

;;(ac-config-default) ;; default auto-complete configuration
(add-hook 'after-init-hook 'global-company-mode)
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-tooltip-align-annotations 't)          ; align annotations to the right tooltip border
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
(global-set-key (kbd "C-c /") 'company-files)        ; Force complete file names on "C-c /" key

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
 '(magit-blame-date ((t (:inherit magit-blame-heading))))
 '(magit-blame-heading ((t (:background "grey25" :foreground "cyan"))))
 '(magit-diff-added ((t (:background "blue" :foreground "#ddffdd"))))
 '(magit-diff-added-highlight ((t (:background "blue" :foreground "#cceecc"))))
 '(magit-hash ((t (:foreground "yellow3")))))

(defun my-web-mode-hook ()
  "Hook for `web-mode'."
  (set (make-local-variable 'company-backends)
       '(company-tern company-web-html company-yasnippet company-files)))

(add-hook 'web-mode-hook 'my-web-mode-hook)

;; Enable JavaScript completion between <script>...</script> etc.
(defadvice company-tern (before web-mode-set-up-ac-sources activate)
  "Set `tern-mode' based on current language before running company-tern."
  (message "advice")
  (if (equal major-mode 'web-mode)
      (let ((web-mode-cur-language
             (web-mode-language-at-pos)))
        (if (or (string= web-mode-cur-language "javascript")
                (string= web-mode-cur-language "jsx")
                )
            (unless tern-mode (tern-mode))
          (if tern-mode (tern-mode -1))))))


(global-visual-line-mode t) ;; Word wrap
(delete-selection-mode t) ;; Delete selected text
(show-paren-mode t) ;; highlight matching parenthesis
(electric-indent-mode t) ;; auto-indent


(setq inhibit-startup-message t) ;; go straight to scratch buffer on startup
(setq make-backup-file nil) ;; don't make the tilda file when I edit a file.
(setq auto-save-default nil) ;; don't auto safe my file
(setq save-place-file (concat user-emacs-directory "saveplace.el")) ;; save file's last point position
(setq-default save-place t) ;; activate point save position
(setq-default tab-width 2) ;; by default tab will equal 2 spaces
(setq-default indent-tabs-mode nil) ;; use spaces not tabs
(setq js-indent-level 2) ;; set javascript tab to 2 spaces. It does not use the default.
(fset 'yes-or-no-p 'y-or-n-p) ;; When emacs asks for confirmation we can reply with a y or an n

;; org-mode settings
;; For some reason this electric-indent fix does not work.
;; (add-hook 'org-mode-hook (lamda()
;;                                (set (make-local-variable 'electric-indent-functions)
;;                                     (list (lamda(arg) 'no-indent))))) ;;disables org-mode indent so that electric-indent can be used.
(setq org-src-fontify-natively t) ;; org-mode code snippet syntax highlighting

;; dired settings
(setq dired-recursive-deletes (quote top)) ;; asks once if you would like to delete a non-empty directory. If you say yes then it will delete all children.
;;(define-key dired-mode-map (kbd "f") 'dired-find-alternate-file) ;; default - runs dired-find-file. For some reason I am unable to re-define the f key given the dired-mode-map key-map. Why is this. emacs fails to load when I try. I must investigate this issue.
;; (define-key dired-mode-map (kbd "^") 
;;   (lambda ()
;;     (interactive)
;;     (find-alternate-file "..")
;;     )
;;   )

;;irc settings
(setq rcirc-default-nick ENTER_USER_NAME)
(setq rcirc-server-alist
      '(("irc.freenode.net" :port 6697 :encryption tls
         :channels ("#emacs"))))

(add-to-list 'rcirc-server-alist
             '("irc.oftc.net" :port 6697 :encryption tls
               :channels ("#emacs")))

(set-face-foreground 'rcirc-my-nick "green" nil)
(setq rcirc-time-format "%Y-%m-%d %H:%M ")
(rcirc-track-minor-mode 1)
(setq rcirc-buffer-maximum-lines 10000)

;; comint-mode for node
(defun node-repl () (interactive)
       (pop-to-buffer (make-comint "node-repl" "node" nil "--interactive"))
       (node-repl))
       
;; minor-modes
(define-minor-mode my-keys-minor-mode 
  "A minor mode for my custom key-maps"
  t " my-keys"
  'my-keys-minor-mode-map)
(my-keys-minor-mode t)

;; keymaps
(define-key my-keys-minor-mode-map (kbd "C-c g") 'magit-status)
(define-key my-keys-minor-mode-map (kbd "C-c w") 'company-web-html)
(define-key my-keys-minor-mode-map (kbd "C-c j") 'company-web-jade)
(define-key my-keys-minor-mode-map (kbd "M-SPC") 'company-complete) ;; manually invoke auto-complete
(define-key my-keys-minor-mode-map (kbd "M-s l") 'select-current-line)
(define-key my-keys-minor-mode-map (kbd "M-RET") 'line-above-current-line)
(define-key my-keys-minor-mode-map (kbd "C-c SPC") 'ace-jump-mode) ;; jump point to line, word, or char

;; Functions
(defun select-current-line ()
  "Marks the current line from begining to end and highlights it."
  (interactive)
  (end-of-line)
  (push-mark (line-beginning-position) nil t))

(defun line-above-current-line ()
  "Creates a new line above the current line."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(org-time-clocksum-format
   (quote
    (:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t)))
 '(package-selected-packages
   (quote
    (projectile flycheck-pyflakes async flycheck git-commit helm helm-core magit-popup package-build yasnippet web-mode stylus-mode smartparens pallet palette org-plus-contrib multiple-cursors magit jade-mode idle-highlight-mode htmlize helm-projectile flycheck-cask expand-region expand-line drag-stuff company-web company-tern color-theme-sanityinc-tomorrow bind-key auto-complete ace-jump-mode ac-html-csswatcher ac-html-bootstrap))))
