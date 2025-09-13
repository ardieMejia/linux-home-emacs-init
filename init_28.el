
(require 'package)
(setq package-enable-at-startup nil)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(defvar ardie/all-compute-cfg-dir "~/.config/emacs/")

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
(if (< emacs-major-version 29)
    (desktop-save-mode 1)
  (desktop-save-mode -1))



;; ========== 
(setq frame-title-format
      '((:eval (if (buffer-file-name)
       (abbreviate-file-name (buffer-file-name))
       "%b"))))



(require 'ox-publish)

;; ===== once we are done with our EMACS 29 config, we can reduce error-level to from :warning to :error (or even :emergency, if youre daring)
(if (< emacs-major-version 29)
    (setq warning-minimum-level :error)
  )


(load-file (concat ardie/all-compute-cfg-dir "my_templates.el"))
(load-file (concat ardie/all-compute-cfg-dir "my_present/init_present.el"))
(if (< emacs-major-version 29)
    (load-file (concat ardie/all-compute-cfg-dir "my_hydra/my-hydra.el"))
  (load-file (concat ardie/all-compute-cfg-dir "my_hydra/my-hydra-29.el"))
)
(load-file (concat ardie/all-compute-cfg-dir "my-modeline/my-modeline.el"))
;; (load-file "~/.config/emacs/my_org_settings/my-sound.el")
(load-file (concat ardie/all-compute-cfg-dir "my_projectile/my-projectile.el"))
(load-file (concat ardie/all-compute-cfg-dir "my_web/my_web_mode.el"))
(load-file (concat ardie/all-compute-cfg-dir "my_looks/my_looks.el"))
(load-file (concat ardie/all-compute-cfg-dir "my_python/init_python.el"))

;; (load-file "~/.config/emacs/my_advices/my_advices.el")





(condition-case error
    (set-face-attribute 'default nil :font "Iosevka" :weight 'regular)
  ('error (progn (set-face-attribute 'default nil :font "Georgia" :weight 'regular)  "Iosevka failed, loading Georgia")))



(if (< emacs-major-version 29)
    (setq backup-directory-alist `(("." . ,(concat ardie/all-compute-cfg-dir "emacs_backup_files"))))  
  (setq backup-directory-alist '(("." . "/home/ardie/my-emacs-29-config/emacs_backup_files")))  
  )


;; (visual-line-mode)

(use-package org-bullets
  :hook
  ;; (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (org-mode . org-bullets-mode)
  :config
  (setq org-bullets-bullet-list '("◉" "‣" "⁃" "∙"))
  )




(use-package org-mode
  :defer t
  :mode "\\.org$"
  :init
  (setq org-startup-folded t)
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("cp" . "src c++"))
  (add-to-list 'org-structure-template-alist '("f" . "src forth"))
  (add-to-list 'org-structure-template-alist '("sh" . "src html"))
  (add-to-list 'org-structure-template-alist '("ss" . "src shell"))
  (add-to-list 'org-structure-template-alist '("p" . "src python"))
  (add-to-list 'org-structure-template-alist '("j" . "src javascript"))
  (add-to-list 'org-structure-template-alist '("sc" . "src css"))
  (add-to-list 'org-structure-template-alist '("m" . "src makefile-gmake"))
  (setq org-indent-indentation-per-level 4)


  )



;; (add-to-list 'org-structure-template-alist '("m" . "src magik"))
;; (add-to-list 'org-structure-template-alist '("ps" . "src powershell"))
;; (add-to-list 'org-structure-template-alist '("sc" . "src scheme"))
;; (add-to-list 'org-structure-template-alist '("ss" . "src shell"))
;; (add-to-list 'org-structure-template-alist '("j" . "src java"))
;; (add-to-list 'org-structure-template-alist '("sq" . "src sql"))
;; (add-to-list 'org-structure-template-alist '("x" . "src xml"))






(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 300)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(setq recentf-menu-filter "recentf-sort-ascending")

(run-at-time nil (* 5 60) 'recentf-save-list)
;; (run-at-time nil (* 5 150) 'my-org-sound-randomizer)


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
  
  (condition-case error
      (set-face-attribute (car face) nil :font "Jost" :weight 'medium :height (cdr face))
    ('error (progn
	      (set-face-attribute (car face) nil :font "Arial" :weight 'medium :height (cdr face))
	      "Iosevka failed, loading Arial"))))

;; ----- becoz we cant decide what we need for org-mode, our org is still ugly
(condition-case error
    (progn
      (set-face-attribute 'org-level-1 nil :font "Jost ExtraBold" :weight 'medium :height 1.6)
      (set-face-attribute 'org-level-2 nil :font "Jost SemiBold" :weight 'medium :height 1.4)
      (set-face-attribute 'org-level-3 nil :font "Jost SemiBold Italic" :weight 'medium :height 1.2)
      (set-face-attribute 'org-level-4 nil :font "Jost" :weight 'medium :height 1.2)
      (set-face-attribute 'org-block nil :font "Iosevka" :weight 'medium :height 1.0)
      (set-face-attribute 'org-block-begin-line nil :font "Iosevka" :slant 'italic :weight 'medium :height 1.0 :background "lightgray")
      (set-face-attribute 'org-block-end-line nil :font "Iosevka" :slant 'italic :weight 'medium :height 1.0)
      )
  ('error (progn
	    (progn
	      (set-face-attribute 'org-level-1 nil :font "Arial" :weight 'medium :height 1.6)
	      (set-face-attribute 'org-level-2 nil :font "Arial" :weight 'medium :height 1.4)
	      (set-face-attribute 'org-level-3 nil :font "Arial" :weight 'medium :height 1.2)
	      (set-face-attribute 'org-level-4 nil :font "Arial" :weight 'medium :height 1.2)
	      (set-face-attribute 'org-block nil :font "Arial" :weight 'medium :height 1.0)
	      (set-face-attribute 'org-block-begin-line nil :font "Arial" :slant 'italic :weight 'medium :height 1.0 :background "lightgray")
	      (set-face-attribute 'org-block-end-line nil :font "Arial" :slant 'italic :weight 'medium :height 1.0)
	      )
	    "Iosevka failed, loading Arial")))





;; ----- Im sure theres better way to do this. That dolist example was quite cool


;; ========== org-mode section ==========



(load-file (concat ardie/all-compute-cfg-dir "my_modes/my_mode.el"))






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



(add-hook 'powershell-mode-hook 'electric-pair-mode)
(add-hook 'emacs-lisp-mode-hook 'electric-pair-mode)
(add-hook 'python-mode-hook 'electric-pair-mode)
(add-hook 'python-ts-mode-hook 'electric-pair-mode)



;; ========== electric-pair-mode FIX ==========
;; ===== taken from this link:
;; https://emacs.stackexchange.com/questions/13603/auctex-disable-electric-pair-mode-in-minibuffer-during-macro-definition
(defvar my-electic-pair-modes '(emacs-lisp-mode powershell-mode python-mode python-ts-mode inferior-python-mode org-mode javascript-mode js-mode rust-mode rust-ts-mode web-mode c++-mode))

(defun my-inhibit-electric-pair-mode (char)
  (not (member major-mode my-electic-pair-modes)))

(setq electric-pair-inhibit-predicate #'my-inhibit-electric-pair-mode)
;; ========== electric-pair-mode FIX ==========




(add-hook 'focus-out-hook (lambda () (save-some-buffers t)))
;;(add-hook 'focus-in-hook (lambda () (revert-buffer)))



(load-file (concat ardie/all-compute-cfg-dir "my_navigation/init_navigation.el"))


(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                   (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)



(if (< emacs-major-version 29)
    (message "passing through")
  (progn
    (load-file (concat ardie/all-compute-cfg-dir "my_treesitter/my-treesitter.el"))
    (load-file (concat ardie/all-compute-cfg-dir "my_major_alist_overrides/major-alist.el"))
    (load-file (concat ardie/all-compute-cfg-dir "my_lsp/my-lsp.el"))
    (load-file (concat ardie/all-compute-cfg-dir "my_drill/my-drill.el"))
    )
  )



(put 'ardie/project-shell-command 'safe-local-variable #'stringp)



(global-set-key (kbd "C-;") '(lambda () (interactive)(insert ";")))
