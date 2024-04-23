;; Set up package.el to work with MELPA
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
(setq evil-want-C-i-jump nil)
;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))


(unless (package-installed-p 'goto-chg)
  (package-install 'goto-chg))

(projectile-mode +1)
;; Recommended keymap prefix on Windows/Linux
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)



(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

;; Ivy-based interface to standard commands

(global-set-key (kbd "C-s") 'swiper-isearch)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "<f2> j") 'counsel-set-variable)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-c v") 'ivy-push-view)
(global-set-key (kbd "C-c V") 'ivy-pop-view)

;; Ivy-based interface to shell and system tools

(global-set-key (kbd "C-c c") 'counsel-compile)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c L") 'counsel-git-log)
(global-set-key (kbd "C-c k") 'counsel-rg)
(global-set-key (kbd "C-c m") 'counsel-linux-app)
(global-set-key (kbd "C-c n") 'counsel-fzf)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-c J") 'counsel-file-jump)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(global-set-key (kbd "C-c w") 'counsel-wmctrl)

;; Ivy-resume and other commands
;; ivy-resume resumes the last Ivy-based completion.

(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "C-c b") 'counsel-bookmark)
(global-set-key (kbd "C-c d") 'counsel-descbinds)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c o") 'counsel-outline)
(global-set-key (kbd "C-c t") 'counsel-load-theme)
(global-set-key (kbd "C-c F") 'counsel-org-file)



(require 'goto-chg)

(require 'evil)
(evil-mode 1)
(evil-set-undo-system 'undo-redo)

;; Which-key
(which-key-mode)

;; lsp
(require 'eglot)
(add-to-list 'eglot-server-programs '(rust-mode . ("rust-analyzer")))
(add-hook 'rust-mode-hook 'eglot-ensure)


;; Make Elisp files in that directory available to the user.
;; https://protesilaos.com/emacs/ef-themes
(add-to-list 'load-path "~/.emacs.d/manual-packages/ef-themes")
(require 'ef-themes)

;; Load the theme of choice:
;; Make customisations that affect Emacs faces BEFORE loading a theme
;; (any change needs a theme re-load to take effect).
;; (require 'ef-themes)


;; Disable all other themes to avoid awkward blending:
(mapc #'disable-theme custom-enabled-themes)


;; The themes we provide are recorded in the `ef-themes-dark-themes',
;; `ef-themes-light-themes'.

;; We also provide these commands, but do not assign them to any key:
;;
;; - `ef-themes-toggle'
;; - `ef-themes-select'
;; - `ef-themes-select-dark'
;; - `ef-themes-select-light'
;; - `ef-themes-load-random'
;; - `ef-themes-preview-colors'
;; - `ef-themes-preview-colors-current'

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(ef-deuteranopia-dark))
 '(custom-safe-themes
   '("5b338bbf32cb7c1d6d1f95687eb680ab62b8ebbb1f8a9602aeecb93ca4d02012" "b4b3c720a4ef5baa8e01645085920aceaf17bac9122da24069821a21704a8917" default))
 '(org-agenda-files '("~/Dropbox/orgzly/todo.org"))
 '(package-selected-packages
   '(rust-mode web-mode counsel ivy projectile magit which-key-posframe which-key evil))
 '(warning-suppress-log-types '((comp) (comp) (comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Noto Mono" :foundry "GOOG" :slant normal :weight regular :height 115 :width normal)))))
