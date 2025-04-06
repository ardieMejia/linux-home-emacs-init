
(use-package emacs
  :config
  (require-theme 'modus-themes) ; `require-theme' is ONLY for the built-in Modus themes

  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil)

  ;; Maybe define some palette overrides, such as by using our presets
  (setq modus-themes-common-palette-overrides
        modus-themes-preset-overrides-cooler)

  ;; Load the theme of your choice.
  ;; (load-theme 'modus-vivendi)

  (define-key global-map (kbd "<f5>") #'modus-themes-toggle))

(defun my-emacs-modus-vivendi ()
  (interactive)
  (load-theme 'modus-vivendi)
  (setq my-mode-list-contrast '(tty-menu-disabled-face show-paren-match  modus-themes-intense-red shadow))
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    ;; ----- previous value "Ioevka"
    (set-face-attribute (car face) nil :font "Arial" :weight 'medium :height (cdr face)))
  
  ;; ----- becoz we cant decide what we need for org-mode, our org is still ugly
  (set-face-attribute 'org-level-1 nil :font "Georgia:line-spacing:100" :weight 'medium :height 1.8)
  (set-face-attribute 'org-level-2 nil :font "Garamond" :weight 'medium :height 1.4)
  (set-face-attribute 'org-level-3 nil :font "Georgia" :weight 'medium :height 1.2)
  (set-face-attribute 'org-level-4 nil :font "Georgia" :weight 'medium :height 1.1))



(defun my-emacs-modus-operandi ()
  (interactive)
  (load-theme 'modus-operandi)
  ;; (setq my-mode-list-contrast '(tty-menu-disabled-face show-paren-match  modus-themes-intense-red shadow))
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    ;; ----- previous value "Ioevka"
    (set-face-attribute (car face) nil :font "Arial" :weight 'medium :height (cdr face)))
  
  ;; ----- becoz we cant decide what we need for org-mode, our org is still ugly
  (set-face-attribute 'org-level-1 nil :font "Georgia:line-spacing:100" :weight 'medium :height 1.8)
  (set-face-attribute 'org-level-2 nil :font "Garamond" :weight 'medium :height 1.4)
  (set-face-attribute 'org-level-3 nil :font "Georgia" :weight 'medium :height 1.2)
  (set-face-attribute 'org-level-4 nil :font "Georgia" :weight 'medium :height 1.1))

