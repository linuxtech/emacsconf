(setq show-paren-style 'expression)
(show-paren-mode 1)

(menu-bar-mode 0)
(tool-bar-mode 0)
(load-theme 'tango-dark)

;; Add repo
(require 'package) 
;(add-to-list 'package-archives
;             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  )
(package-initialize) ;; You might already have this line


(add-to-list 'load-path "~/.emacs.d/plugins/")

;; Line Numbers
(require 'linum+)
(setq linum-format "%d ")
(global-linum-mode 1)

;; Buffer List Show
(require 'bs)
(setq bs-configurations
      '(("files" "^\\*scratch\\*" nil nil bs-visits-non-file bs-sort-buffer-interns-are-last)))
(global-set-key (kbd "<f2>") 'bs-show)


; File browser
(require 'sr-speedbar)
(global-set-key (kbd "<f12>") 'sr-speedbar-toggle)


; Use cperl-mode instead of perl-mode
(setq auto-mode-alist (rassq-delete-all 'perl-mode auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.\\(p\\([lm]\\)\\)\\'" . cperl-mode))

(setq interpreter-mode-alist (rassq-delete-all 'perl-mode interpreter-mode-alist))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

(ac-config-default)
(require 'yasnippet)
(yas-global-mode 1)
;(require 'perl-completion)

(add-hook  'cperl-mode-hook
           (lambda ()
	     (when (require 'perl-completion )
	       (local-set-key (kbd "C-<return>") 'plcmp-cmd-complete-all))))
	      
;             (when (require 'auto-complete nil t) ; no error whatever auto-complete.el is not installed.
;               (auto-complete-mode t)
;               (make-variable-buffer-local 'ac-sources)
;               (setq ac-sources
;                     '(ac-source-perl-completion)))))



(custom-set-variables
 
; '(kill-whole-line t)
 )
(custom-set-faces
 )

;(defvar my-fullscreen-p t "Check if fullscreen is on or off")

;(defun my-non-fullscreen ()
;  (interactive)
;  (if (fboundp 'w32-send-sys-command)
;	  ;; WM_SYSCOMMAND restore #xf120
;	  (w32-send-sys-command 61728)
;	(progn (set-frame-parameter nil 'width 82)
;		   (set-frame-parameter nil 'fullscreen 'fullheight))))
;
;(defun my-fullscreen ()
;  (interactive)
;  (if (fboundp 'w32-send-sys-command)
;	  ;; WM_SYSCOMMAND maximaze #xf030
;	  (w32-send-sys-command 61488)
;	(set-frame-parameter nil 'fullscreen 'fullboth)))

;(defun my-toggle-fullscreen ()
;  (interactive)
;  (setq my-fullscreen-p (not my-fullscreen-p))
;  (if my-fullscreen-p
;	  (my-non-fullscreen)
;	(my-fullscreen)))

(defun toggle-fullscreen ()
  "Toggle full screen on X11"
  (interactive)
  (when (eq window-system 'x)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))

; My keybindings
; Unset old and set new

(global-unset-key (kbd "C-k"))
(global-set-key (kbd "<f8>") 'kill-whole-line) ;del line
(global-set-key (kbd "C-S-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-S-<left>") 'shrink-window-horizontally)
(global-set-key [f11] 'toggle-fullscreen)
(global-set-key (kbd "C-c") 'kill-ring-save) ;copy
(global-set-key (kbd "C-v") 'yank) ;paste

