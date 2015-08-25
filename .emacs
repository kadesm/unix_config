;; MELPA
;; list-packages i install x execute U update
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)


;; disable interprogram cut/paste, which I fucking hate:
(setq interprogram-cut-function nil)
(setq interprogram-paste-function nil)

;; css mode customizations

(setq cssm-indent-function #'cssm-c-style-indenter)
(setq cssm-indent-level 2)

(setq-default indent-tabs-mode nil)

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/jade-mode")
(add-to-list 'load-path "~/.emacs.d/enhanced-ruby-mode")
(add-to-list 'load-path "~/.emacs.d/egg")
(add-to-list 'load-path "~/.emacs.d/elisp/cucumber.el")
(add-to-list 'load-path "~/.emacs.d/elisp/markdown-mode")

(require 'egg)
(require 'feature-mode)

(autoload 'hobo-register-agent "hobo" "" t)
(autoload 'hobo-register-agent-from-file "hobo" "" t)
(autoload 'hobo-find-file "hobo" "" t)


(require 'tramp)
(setq tramp-default-method "ssh")
(setq default-tab-width 2)
;; (add-to-list 'load-path "~/.emacs.d/actionscript-mode.connors")
(autoload 'js2-mode "js2" nil t)
(add-hook 'js2-mode-hook (lambda () (js2-leave-mirror-mode) (set-variable js2-mode-escape-quotes 1)))


(autoload 'css-mode "css-mode" nil t)
(autoload 'ruby-mode "ruby-mode" nil t)
(autoload 'enh-ruby-mode "enh-ruby-mode" nil t)
(autoload 'haml-mode "haml-mode" nil t)
(autoload 'sass-mode "sass-mode" nil t)
(autoload 'patch-mode "patch" nil t)
(autoload 'jade-mode "jade-mode" nil t)
(autoload 'stylus-mode "stylus-mode" nil t)
(autoload 'sws-mode "sws-mode" nil t)
(autoload 'yaml-mode "yaml-mode" nil t)
(autoload 'scss-mode "scss-mode")
(autoload `markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)

(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))
(add-to-list 'auto-mode-alist '("\\.js.erb$" . js-mode))
(add-to-list 'auto-mode-alist '("\\.jsm$" . js-mode))
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(add-to-list 'auto-mode-alist
	     '("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist
	     '("\\(Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.mm$" . objc-mode))
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))
(add-to-list 'auto-mode-alist '("\\.hbs$" . hbs-mode))
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
(add-to-list 'auto-mode-alist '("\\.styl$" . stylus-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.feature$" . feature-mode))
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.jst.ejs$" . html-mode))
(iswitchb-mode)

(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
(require 'color-theme)
(require 'color-theme-autoloads)
(load "~/.emacs.d/color-theme-6.6.0/themes/color-theme-library.el")

(color-theme-dark-laptop)
(put 'narrow-to-region 'disabled nil)

(add-to-list 'load-path "~/.emacs.d/mo-git-blame")

(autoload 'mo-git-blame-file "mo-git-blame" nil t)
(autoload 'mo-git-blame-current "mo-git-blame" nil t)

(global-set-key [?\C-c ?g ?c] 'mo-git-blame-current)
(global-set-key [?\C-c ?g ?f] 'mo-git-blame-file)

(global-set-key [?\C-x ?p] 'previous-multiframe-window)



;; (setq load-path (cons (expand-file-name "~/.emacs.d/rails-reloaded") load-path))
;; (require 'rails-autoload)
;;(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
;; '(safe-local-variable-values (quote ((encoding . utf-8)))))
;;(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
;;  )

;; and , disable the useless menu bar.:
(menu-bar-mode)

(defun pbcopy (start end) "Copy the region to the OSX pasteboard"
  ( interactive "r" )
  ( shell-command-on-region start end "pbcopy" )
  )

(defun pbpaste (location) "Paste the OSX pasteboard at the current point"
  ( interactive "d" ) ;; automatically take one variable
  ( insert ( shell-command-to-string "pbpaste" ) )
  )

(setq create-lockfiles nil) 

(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(egg-enable-tooltip t)
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(mouse-wheel-scroll-amount (quote (1 ((shift) . 1) ((control)))))
 '(ns-antialias-text nil)
 '(safe-local-variable-values (quote ((js-indent-level . 2))))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(truncate-lines t)
 '(visible-bell t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; stuff to make surepaths work right:
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))


;; ====================
;; insert date and time

(defvar current-date-time-format "%a %b %d %H:%M:%S %Z %Y"
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")

(defvar current-time-format "%a %H:%M:%S"
  "Format of date to insert with `insert-current-time' func.
Note the weekly scope of the command's precision.")

(defun insert-current-date-time ()
  "insert the current date and time into current buffer.
Uses `current-date-time-format' for the formatting the date/time."
       (interactive)
       (insert "==========\n")
;       (insert (let () (comment-start)))
       (insert (format-time-string current-date-time-format (current-time)))
       (insert "\n")
       )

(defun insert-current-time ()
  "insert the current time (1-week scope) into the current buffer."
       (interactive)
       (insert (format-time-string current-time-format (current-time)))
       (insert "\n")
       )

(global-set-key "\C-c\C-d" 'insert-current-date-time)
(global-set-key "\C-c\C-t" 'insert-current-time)

;; do meta-x with control-x/c control-m
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; Make control-w kill one word back, not the whole region.
;; kill whole region with C-x C-k
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key "\C-c\C-w" 'kill-ring-save)

;; (global-set-key "\C-z" 'shell)

(defun dos2unix (buffer)
      "Automate M-% C-q C-m RET C-q C-j RET"
      (interactive "*b")
      (save-excursion
        (goto-char (point-min))
        (while (search-forward (string ?\C-m) nil t)
           (replace-match (string ?\C-j) nil t))))


(defun toggle-camelcase-underscores ()
  "Toggle between camcelcase and underscore notation for the symbol at point."
  (interactive)
  (save-excursion
    (let* ((bounds (bounds-of-thing-at-point 'symbol))
           (start (car bounds))
           (end (cdr bounds))
           (currently-using-underscores-p (progn (goto-char start)
                                                 (re-search-forward "_" end t))))
      (if currently-using-underscores-p
          (progn
            (upcase-initials-region start end)
            (replace-string "_" "" nil start end)
            (downcase-region start (1+ start)))
        (replace-regexp "\\([A-Z]\\)" "_\\1" nil (1+ start) end)
        (downcase-region start end)))))

(global-set-key "\C-C-\C-U" 'toggle-camelcase-underscores)
