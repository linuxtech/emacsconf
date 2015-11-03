(setq show-paren-style 'expression)
(show-paren-mode 2)

(menu-bar-mode nil)
(setq tool-bar-mode nil)

(add-to-list 'load-path "~/.emacs.d/plugins/")

;; Line Numbers
(require 'linum+)
(setq linum-format "%d ")
(global-linum-mode 1)

;; Buffer Show
(require 'bs)
(setq bs-configurations
      '(("files" "^\\*scratch\\*" nil nil bs-visits-non-file bs-sort-buffer-interns-are-last)))

(global-set-key (kbd "<f2>") 'bs-show)

;; Add repository
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

;; Auto-coplete
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete")
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/emacs.d/plugins/auto-complete/dict")

;; SrSpeedbar
(require 'sr-speedbar)
(global-set-key (kbd "<f12>") 'sr-speedbar-toggle)

;; Yasnippet
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
(yas/load-directory "~/.emacs.d/elpa/yasnippet/snippets")

;; Perl-completions

(add-to-list 'load-path "~/.emacs.d/elpa/perl-completion")
(require 'perl-completion)

(add-hook 'cperl-mode-hook
	  (lambda()
	    (require 'perl-completion)
	                (perl-completion-mode t)))

(add-hook  'cperl-mode-hook
	   (lambda ()
	     (when (require 'auto-complete nil t) ; no error whatever auto-complete.el is not installed.
	       (auto-complete-mode t)
	       (make-variable-buffer-local 'ac-sources)
	       (setq ac-sources
		                          '(ac-source-perl-completion)))))

;; Set Perl-completion SmartHelp
(global-set-key (kbd "M-RET") 'plcmp-cmd-smart-complete)
;; Set Perldoc-at-point
(global-set-key (kbd "<f1> SPC") 'cperl-perldoc-at-point)

;; use cperl-mode instead of perl-mode
(setq auto-mode-alist (rassq-delete-all 'perl-mode auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.\\(p\\([lm]\\)\\)\\'" . cperl-mode))

(setq interpreter-mode-alist (rassq-delete-all 'perl-mode interpreter-mode-alist))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

;; Folding

(defvar hs-special-modes-alist
  (mapcar 'purecopy
	  '((perl-mode "{" "}" nil nil)
	    (cperl-mode "{" "}" nil)
	    (emacs-lisp- "(" ")" nil))))


;; Hideshow
(require 'hideshow)

(global-set-key (kbd "<f9>") 'hs-toggle-hiding)
(global-set-key (kbd "C-<f9>") 'hs-hide-all)
(global-set-key (kbd "C-S-<f9>") 'hs-show-all)