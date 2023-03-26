;; -*- mode: elisp -*- 
(setq inhibit-startup-message t)

;; Errors
(setq debug-on-error t)

;; Org
(transient-mark-mode 1)
(require 'org)
(use-package org-superstar)
(setq org-todo-keywords
      '((sequence "TODO" "FEEDBACK" "VERIFY" "|" "DONE" "DELEGATED")))

;; Org babel for mysql
(org-babel-do-load-languages
 'org-babel-load-languages
 '((perl . t)
   (shell . t)
   (sql . t)
   (org . t)
   (emacs-lisp . t)
   (gnuplot . t)
   (sql . t)))

(with-eval-after-load 'org
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sql . t))))

;; SQL Setup
(setq sql-connection-alist
'((pool-a
(sql-product 'mysql)
(sql-server "127.0.0.1")
(sql-user "core")
(sql-password "w")
(sql-database "mplayer")
(sql-port 3306))
(pool-b
(sql-product 'mysql)
(sql-server "1.2.3.4")
(sql-user "me")
(sql-password "mypassword")
(sql-database "thedb")
(sql-port 3307))))

(defun sql-connect-preset (name)
  "Connect to a predefined SQL connection listed in `sql-connection-alist'"
  (eval `(let ,(cdr (assoc name sql-connection-alist))
    (flet ((sql-get-login (&rest what)))
      (sql-product-interactive sql-product)))))

(defun sql-pool-a ()
  (interactive)
  (sql-connect-preset 'pool-a))
;;

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)

(menu-bar-mode -1)

(setq visible-bell t)

(set-face-attribute 'default nil :font "Monospace" :height 110)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Make esc quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


;; Closing brackets
(electric-pair-mode t)
(show-paren-mode 1)

;; Theme
(load-theme 'modus-vivendi t)

(require 'package)


(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
    

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(setq use-package-always-ensure t)

;; Icons for doom line
(use-package all-the-icons)
 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("30dc9873c16a0efb187bb3f8687c16aae46b86ddc34881b7cae5273e56b97580" "dde643b0efb339c0de5645a2bc2e8b4176976d5298065b8e6ca45bc4ddf188b7" default))
 '(fci-rule-color "#4F4F4F")
 '(highlight-tail-colors ((("#454845") . 0) (("#474f4f") . 20)))
 '(jdee-db-active-breakpoint-face-colors (cons "#000000" "#8CD0D3"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#000000" "#7F9F7F"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#000000" "#494949"))
 '(objed-cursor-color "#CC9393")
 '(package-selected-packages
   '(treemacs php-mode doom-themes helpful ivy-rich which-key rainbow-delimiters all-the-icons-completion all-the-icons doom-modeline use-package modus-themes ox-slack magit ivy smex counsel org-plus-contrib org))
 '(rustic-ansi-faces
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCDC"])
 '(vc-annotate-background "#3F3F3F")
 '(vc-annotate-color-map
   (list
    (cons 20 "#7F9F7F")
    (cons 40 "#a4b48f")
    (cons 60 "#cac99f")
    (cons 80 "#F0DFAF")
    (cons 100 "#eacfa4")
    (cons 120 "#e4bf99")
    (cons 140 "#DFAF8F")
    (cons 160 "#dea3a0")
    (cons 180 "#dd97b1")
    (cons 200 "#DC8CC3")
    (cons 220 "#d68eb3")
    (cons 240 "#d190a3")
    (cons 260 "#CC9393")
    (cons 280 "#ab8080")
    (cons 300 "#8a6d6d")
    (cons 320 "#695b5b")
    (cons 340 "#4F4F4F")
    (cons 360 "#4F4F4F")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Bootstrap 'use-package'
(eval-after-load 'gnutls
  '(add-to-list 'gnutls-trustfiles "/etc/ssl/cert.pem"))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(setq use-package-always-ensure t)

(require 'use-package)



;; Ivy
(use-package ivy
	     :diminish
	     :config
	     (ivy-mode 1))



;; Line numbers
(column-number-mode)
(global-display-line-numbers-mode t)

(dolist (mode '(term-mode-hook
		eshell-mode-hook
		shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


;; TODO Remap left Control to Caps Lock

;; Line from doom
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 25)))

;; RAINBOW
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))


;; Which Key panel
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(set-frame-parameter (selected-frame) 'alpha '(85 . 50))
 (add-to-list 'default-frame-alist '(alpha . (85 . 50)))

;;(defun toggle-transparency ()
;   (interactive)
;   (let ((alpha (frame-parameter nil 'alpha)))
;     (set-frame-parameter
;      nil 'alpha
;      (if (eql (cond ((numberp alpha) alpha)
;                     ((numberp (cdr alpha)) (cdr alpha))
;                     ;; Also handle undocumented (<active> <inactive>) form.
;                     ((numberp (cadr alpha)) (cadr alpha)))
;               100)
;          '(85 . 50) '(100 . 100)))))
; (global-set-key (kbd "C-c t") 'toggle-transparency)

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ;; Don't start searches with ^

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))


(use-package doom-themes)

;; MPD Config
(use-package mpdel)
(global-set-key (kbd "C-c z") 'mpdel-prefix-key)



;;; Bindings

(global-set-key (kbd "C-c i") 'all-the-icons-insert)

;; Binding for theme picker
(global-set-key (kbd "C-c a") 'counsel-load-theme)

;; Buffer switch
(global-set-key (kbd "C-M-j") 'counsel-switch-buffer)

;; newline-without-break-of-line
(defun newline-without-break-of-line ()
  "1. move to end of the line.
  2. insert newline with index"

  (interactive)
  (let ((oldpos (point)))
    (end-of-line)
    (newline-and-indent)))

(global-set-key (kbd "<S-return>") 'newline-without-break-of-line)


(org-superstar-mode)
;;(use-package org-latex)
;;(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(use-package treemacs)
(global-set-key (kbd "c-c t") 'treemacs)
