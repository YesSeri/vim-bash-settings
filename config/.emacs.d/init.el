;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)
(setq evil-want-C-i-jump nil)
;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))


(unless (package-installed-p 'goto-chg)
  (package-install 'goto-chg))

(require 'goto-chg)

(require 'evil)
(evil-mode 1)
(evil-set-undo-system 'undo-redo)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wheatgrass))
 '(org-agenda-files '("~/Dropbox/orgzly/todo.org"))
 '(package-selected-packages '(which-key-posframe which-key evil))
 '(warning-suppress-log-types '((comp) (comp) (comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
