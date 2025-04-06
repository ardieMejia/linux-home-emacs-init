(require 'package)
(setq package-enable-at-startup nil)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

;; https://www.sandeepnambiar.com/my-minimal-emacs-setup/



;; save history between sessions. Useful for magik-session
(savehist-mode 1)


;; ========== removing menu bars, and non-blinking cursor
(menu-bar-mode 1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)


;; ========== highlight
;; (global-hl-line-mode +1)

;; ========== no splash screen
(setq inhibit-startup-screen t)


;; ========== save session
(desktop-save-mode 1)


;; ========== 
(setq frame-title-format
      '((:eval (if (buffer-file-name)
       (abbreviate-file-name (buffer-file-name))
       "%b"))))



(require 'ox-publish)





(load-file "~/.config/emacs/my_templates.el")
(load-file "~/.config/emacs/my_present/init_present.el")
(load-file "~/.config/emacs/my_hydra/my-hydra.el")
(load-file "~/.config/emacs/my_python/init_python.el")
(load-file "~/.config/emacs/my-modeline/my-modeline.el")
(load-file "~/.config/emacs/my_org_settings/my-sound.el")
(load-file "~/.config/emacs/my_projectile/my-projectile.el")
(load-file "~/.config/emacs/my_web/my_web_mode.el")
(load-file "~/.config/emacs/my_looks/my_looks.el")
;; (load-file "~/.config/emacs/my_advices/my_advices.el")





(condition-case xe
    (set-face-attribute 'default nil :font "Iosevka" :weight 'regular)
  ('error (progn (set-face-attribute 'default nil :font "Georgia" :weight 'regular)  "Iosevka failed, loading Georgia")))



(setq backup-directory-alist '(("." . "/home/ardie/.config/emacs/emacs_backup_files")))


(visual-line-mode)
(add-hook 'org-mode-hook 'visual-line-mode)


(require 'org-tempo)

;; (add-to-list 'org-structure-template-alist '("m" . "src magik"))
(add-to-list 'org-structure-template-alist '("el" . "src lisp"))
(add-to-list 'org-structure-template-alist '("sh" . "src html"))
(add-to-list 'org-structure-template-alist '("p" . "src python"))
(add-to-list 'org-structure-template-alist '("j" . "src javascript"))
(add-to-list 'org-structure-template-alist '("sc" . "src css"))
;; (add-to-list 'org-structure-template-alist '("ps" . "src powershell"))
;; (add-to-list 'org-structure-template-alist '("sc" . "src scheme"))
;; (add-to-list 'org-structure-template-alist '("ss" . "src shell"))
;; (add-to-list 'org-structure-template-alist '("j" . "src java"))
;; (add-to-list 'org-structure-template-alist '("sq" . "src sql"))
;; (add-to-list 'org-structure-template-alist '("x" . "src xml"))




(setq org-startup-folded t)

(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 300)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(setq recentf-menu-filter "recentf-sort-ascending")

(run-at-time nil (* 5 60) 'recentf-save-list)
(run-at-time nil (* 5 150) 'my-org-sound-randomizer)


(require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


(setq dired-dwim-target t)


;; ========== org-mode section ==========

;; (require 'org-superstar)

  ;; ;; Every non-TODO headline now have no bullet
  ;; (setq org-superstar-headline-bullets-list '("　"))
  ;; (setq org-superstar-leading-bullet ?　)
  ;; ;; Enable custom bullets for TODO items
;; (setq org-superstar-special-todo-items t)
(setq org-indent-indentation-per-level 4)
  ;; (setq org-superstar-todo-bullet-alist
  ;;       '(("TODO" "☐　")
  ;;         ("NEXT" "✒　")
  ;;         ("PROG" "✰　")
  ;;         ("WAIT" "☕　")
  ;;         ("FAIL" "✘　")
  ;;         ("DONE" "✔　")))




;; (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(add-hook 'org-mode-hook (lambda () (org-indent-mode 1)))

(dolist (face '((org-level-1 . 1.2)
                (org-level-2 . 1.1)
                (org-level-3 . 1.05)
                (org-level-4 . 1.0)
                (org-level-5 . 1.1)
                (org-level-6 . 1.1)
                (org-level-7 . 1.1)
                (org-level-8 . 1.1)))
  ;; ----- previous value "Ioevka"
  (set-face-attribute (car face) nil :font "Jost" :weight 'medium :height (cdr face)))

;; ----- becoz we cant decide what we need for org-mode, our org is still ugly
(set-face-attribute 'org-level-1 nil :font "Jost ExtraBold" :weight 'medium :height 1.6)
(set-face-attribute 'org-level-2 nil :font "Jost SemiBold" :weight 'medium :height 1.4)
(set-face-attribute 'org-level-3 nil :font "Jost SemiBold Italic" :weight 'medium :height 1.2)
(set-face-attribute 'org-level-4 nil :font "Jost" :weight 'medium :height 1.2)


;; ----- Im sure theres better way to do this. That dolist example was quite cool
(set-face-attribute 'org-block nil :font "Iosevka" :weight 'medium :height 1.0)
(set-face-attribute 'org-block-begin-line nil :font "Iosevka" :slant 'italic :weight 'medium :height 1.0 :background "lightgray")
(set-face-attribute 'org-block-end-line nil :font "Iosevka" :slant 'italic :weight 'medium :height 1.0)


;; ========== org-mode section ==========



(load-file "~/.config/emacs/my_modes/my_mode.el")

(use-package magik-mode
  :ensure t
  :config
  (magik-global-bindings)
  (magik-menu-set-menus))




;; ===== xah lee open folder of current file or dired 
;; ========== TODO: the original allow smultiple files tp open. refer to link
(defun my-show-in-desktop ()
  "Open the current file or dired marked files in external app.
When called in emacs lisp, if Fname is given, open that.

URL `http://xahlee.info/emacs/emacs/emacs_dired_open_file_in_ext_apps.html'
Created: 2019-11-04
Version: 2023-06-26"
  (interactive)
      (shell-command (concat "xdg-open " default-directory)))

(global-set-key (kbd "C-c m s d") 'my-show-in-desktop)


;; ================================================== all-the-icons
;; ========== TODO: study use-package

(use-package all-the-icons-completion
  :after (marginalia all-the-icons)
  :hook (marginalia-mode . all-the-icons-completion-marginalia-setup)
  :init
  (all-the-icons-completion-mode))


(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

;; ================================================== all-the-icons

(require 'org-bullets)

(add-hook 'powershell-mode-hook 'electric-pair-mode)
(add-hook 'org-mode-hook 'electric-pair-mode)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(add-hook 'emacs-lisp-mode-hook 'electric-pair-mode)
(add-hook 'focus-out-hook (lambda () (save-some-buffers t)))
;;(add-hook 'focus-in-hook (lambda () (revert-buffer)))
(setq org-bullets-bullet-list '("◉" "‣" "⁃" "∙"))


(load-file "~/.config/emacs/my_navigation/init_navigation.el")
