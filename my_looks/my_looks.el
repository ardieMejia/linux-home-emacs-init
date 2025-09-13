;; ==== personal reminder that this MIGHT NOT work in Emacs 28




(use-package emacs
  :hook
  (org-mode . visual-line-mode)
  (org-mode . electric-pair-mode)
  :config

  (global-set-key (kbd "C-<drag-mouse-9>") 'ardie/its-fuzzing-time)
  (global-set-key (kbd "C-<mouse-9>") 'ardie/its-fuzzing-time)

  ;; ===== on working Emacs
  (defun ardie/git-get-rev-parse(amend-output)
    (let
	((commit-hash  (shell-command-to-string "git rev-parse HEAD")))   
      (kill-new commit-hash)
      (print (concat amend-output "\n" commit-hash))))


  (defun ardie/its-fuzzing-time ()
    (interactive)
    (if (equal "working" (car (vc-git-branches)))
	;; (message "running amend and get hash")
	(ardie/add-all-amend-commit-rev-parse)
      (if
	  ;; (not (equal (car (vc-git-branches)) nil))
	  (member "fuzzing" (vc-git-branches))
	  ;; (message "running detached switc and revert buffer")
	  (ardie/switch-d)
	(message "not an interesting project"))))


  
  ;; ===== cool Reddit function: https://www.reddit.com/r/emacs/comments/x8u0bf/save_all_buffers_in_a_projectel_project_context/
  (defun ardie/project-save-all-buffers (&optional proj arg)
    "Save all file-visiting buffers in PROJ without asking.

Falls back to `project-current' if PROJ is not specified."
    (let* ((proj (or proj (project-current)))
           (buffers (project-buffers (project-current))))
      (dolist (buf buffers)
	;; Act on base buffer of indirect buffers, if needed.
	(with-current-buffer (or (buffer-base-buffer buf) buf)
          (when (and (buffer-file-name buf)   ; Ignore all non-file-visiting buffers.
                     (buffer-modified-p buf)) ; Ignore all unchanged buffers.
            (let ((buffer-save-without-query t))  ; Save silently.
              (save-buffer arg)
	      ))))))
  
  
  ;; ===== on working Emacs
  (defun ardie/add-all-amend-commit-rev-parse ()
    ;; (interactive)
    (ardie/project-save-all-buffers)
    ;; (print "asdasd")
    ;; (save-buffer)
    (let
	((current-commit-message (shell-command-to-string "git log -1 HEAD --format=%s")))
      (if (not (string-match-p "work and fuzz" current-commit-message))
	  (progn
	    (shell-command "git clean -fd")
	    (shell-command "git commit --allow-empty -m \"work and fuzz\""))))
    (vc-git-command standard-output 1 "--all" "add")
    ;; (print "we added")
    (let ((amend-output (shell-command-to-string "git commit --amend --no-edit")))
      (ardie/git-get-rev-parse amend-output)))
  
  
  ;; (defun ardie/switch-d()
  ;;   (let ((commit-hash (current-kill 0)))
  ;;     (let
  ;;         ((switch-result (shell-command-to-string (concat "git switch -d " commit-hash))))
  ;;       (print switch-result)
  ;;       (revert-buffer)
  ;;       )
      ;; ))
  
  (defun ardie/switch-d()
  (let ((commit-hash (current-kill 0)))
    (shell-command "git checkout .")
    (let
        ((switch-result (shell-command-to-string (concat "git switch -d " commit-hash))))
      (print switch-result)
      (revert-buffer))))

    ;; ===== discard short changes, back to current commit
  (global-set-key (kbd "C-<drag-mouse-8>") 'ardie/discard-unstaged-changes)
  (global-set-key (kbd "C-<mouse-8>") 'ardie/discard-unstaged-changes)
  
  (defun ardie/discard-unstaged-changes ()
    (interactive)
    
    (let
        ((current-branch (shell-command-to-string "git rev-parse --abbrev-ref HEAD")))
      (if (string-match-p "working" current-branch)
          (if (y-or-n-p "discard changes, so restart from current commit? (y or n) ")
              (let ((discard-change-output (shell-command-to-string "git checkout .")))
                (print discard-change-output))
            (print "action canceled"))
        (print "not working branch: nothing done"))))

  

  ;; ===== restarting furious work and fuzz session 
  (global-set-key (kbd "M-<drag-mouse-9>") 'ardie/back-to-square-one)
  (global-set-key (kbd "M-<mouse-9>") 'ardie/back-to-square-one)
  
  (defun ardie/back-to-square-one ()
    (interactive)
    (let
	((current-commit-message (shell-command-to-string "git log -1 HEAD~1 --format=%s")))
      ;; (print current-commit-message)
      (if
	  (y-or-n-p (concat "reset hard to \"" current-commit-message  "\" and create work and fuzz again? (y or n) "))
	  (progn
	    (let ((reset-hard-output (shell-command-to-string "git reset --hard HEAD~1")))
	      (message reset-hard-output))
	    (let ((new-commit-output (shell-command-to-string "git commit --allow-empty -m \"work and fuzz\"")))
	      (message new-commit-output))
	    (revert-buffer))
	(print "action canceled")
	)))


  
  ;; ========== not exactly a Python specific thing. But all I have for now
  (global-set-key (kbd "<drag-mouse-9>")  'ardie/fun-project-shell-command)
  (global-set-key (kbd "<mouse-9>") 'ardie/fun-project-shell-command)
  (defun ardie/fun-project-shell-command ()
    (interactive)
    (save-buffer)
    ;; (project-shell-command)
    (condition-case error
	;; (shell-command ardie/project-shell-command)
	(compile ardie/project-shell-command t)
      ('error (message "ardie/project-shell-command not defined"))))

  ;; (defun ardie/fun-project-shell-command ()
  ;;   (interactive)
  ;;   (save-buffer)
  ;;   (condition-case error
  ;; 	(progn
  ;; 	  (comint-simple-send "*terminal*" ardie/project-shell-command)
  ;; 	  (switch-to-buffer "*terminal*")
  ;; 	  )
  ;;     ('error (message "ardie/project-shell-command not defined"))
  ;;     )
  ;;   )
  
  
  (require-theme 'modus-themes) ; `require-theme' is ONLY for the built-in Modus themes

  ;; Add all your customizations prior to loading the themes
  ;; we are setting bold construct to t becoz our new screen is horrible
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs t)

  (setq modus-vivendi-palette-overrides
	modus-themes-preset-overrides-intense)

  ;; Maybe define some palette overrides, such as by using our presets
  (setq modus-themes-common-palette-overrides
        modus-themes-preset-overrides-cooler)

  ;; coz I want my comments visible, I use comments to make Python readable
  (setq modus-operandi-palette-overrides
	'(
	  (comment red-intense)
	  ;; the rest is for new screen, coz new screen is really bad
	  (builtin magenta-intense)
	  (variable cyan-intense)
	  ))
  



  ;; Load the theme of your choice.
  ;; (load-theme 'modus-vivendi)

  (define-key global-map (kbd "<f5>") #'modus-themes-toggle))

(defun my-emacs-modus-vivendi ()
  (interactive)
  (load-theme 'modus-vivendi)
  (setq my-mode-list-contrast '(tty-menu-disabled-face show-paren-match  modus-themes-intense-red shadow))


  (dolist (face '((org-level-1 . 1.4)
                  (org-level-2 . 1.2)
                  (org-level-3 . 1.1)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    ;; ----- previous value "Ioevka"
    (set-face-attribute (car face) nil :font "LiberationSerif" :weight 'medium :height (cdr face)))
  
  ;; ----- becoz we cant decide what we need for org-mode, our org is still ugly
  (set-face-attribute 'org-level-1 nil :font "LiberationSerif" :weight 'medium :height 1.4)
  (set-face-attribute 'org-level-2 nil :font "LiberationSerif" :weight 'medium :height 1.3)
  (set-face-attribute 'org-level-3 nil :font "Georgia" :weight 'medium :height 1.2)
  (set-face-attribute 'org-level-4 nil :font "Georgia" :weight 'medium :height 1.1))




(defun my-emacs-modus-operandi ()
  (interactive)
  (load-theme 'modus-operandi)
  ;; lv-separator
  ;; isearch
  ;; dired-flagged   ;; hi-red-b
  ;; web-mode-jsx-depth-5-face
  ;; (setq my-mode-list-contrast '(tty-menu-disabled-face show-paren-match  modus-themes-intense-red shadow))
  (setq my-mode-list-contrast '(lv-separator isearch combobulate-error-indicator-face web-mode-jsx-depth-5-face))
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
  (set-face-attribute 'org-level-1 nil :font "LiberationSerif" :weight 'medium :height 1.4)
  (set-face-attribute 'org-level-2 nil :font "LiberationSerif" :weight 'medium :height 1.3)
  (set-face-attribute 'org-level-3 nil :font "Georgia" :weight 'medium :height 1.2)
  (set-face-attribute 'org-level-4 nil :font "Georgia" :weight 'medium :height 1.1))


(defun my-emacs-modus-operandi-fuzz ()
  (interactive)
  (setq modus-operandi-palette-overrides
	'(
	  (comment red-intense)
	  (bg-main "#faddd9")
	  (builtin magenta-intense)
	  (variable cyan-intense)
	  ))
  (load-theme 'modus-operandi)
  ;; lv-separator
  ;; isearch
  ;; dired-flagged   ;; hi-red-b
  ;; web-mode-jsx-depth-5-face
  ;; (setq my-mode-list-contrast '(tty-menu-disabled-face show-paren-match  modus-themes-intense-red shadow))
  (setq my-mode-list-contrast '(lv-separator isearch combobulate-error-indicator-face web-mode-jsx-depth-5-face))
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
  (set-face-attribute 'org-level-1 nil :font "LiberationSerif" :weight 'medium :height 1.4)
  (set-face-attribute 'org-level-2 nil :font "LiberationSerif" :weight 'medium :height 1.3)
  (set-face-attribute 'org-level-3 nil :font "Georgia" :weight 'medium :height 1.2)
  (set-face-attribute 'org-level-4 nil :font "Georgia" :weight 'medium :height 1.1))


(defun my-emacs-modus-o-tinted ()
  (interactive)
  (load-theme 'modus-operandi-tinted)
  (setq my-mode-list-contrast '(tty-menu-disabled-face show-paren-match  cursor shadow))

  (dolist (face '((org-level-1 . 1.4)
                  (org-level-2 . 1.2)
                  (org-level-3 . 1.1)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    ;; ----- previous value "Ioevka"
    (set-face-attribute (car face) nil :font "LiberationSerif" :weight 'medium :height (cdr face)))
  ;; ----- becoz we cant decide what we need for org-mode, our org is still ugly
  )




(defun my-emacs-modus-haki ()
  (interactive)

  (setq my-mode-list-contrast '(tty-menu-disabled-face show-paren-match  modus-themes-intense-red shadow))

  (setq modus-themes-italic-constructs t)
  (setq modus-themes-bold-constructs t)
  (setq modus-themes-mixed-fonts t)
  (setq modus-themes-variable-pitch-ui t)
  (setq modus-themes-custom-auto-reload t)
  (setq modus-themes-disable-other-themes t)
  (setq modus-themes-prompts '(italic bold))
  (setq modus-themes-completions
        '((matches . (extrabold))
          (selection . (semibold italic text-also))))
  (setq modus-themes-org-blocks 'gray-background)

  (setq modus-themes-headings
        '((1 . (variable-pitch 1.5))
          (2 . (1.3))
          (agenda-date . (1.3))
          (agenda-structure . (variable-pitch light 1.8))
          (t . (1.1))))

  (setq modus-vivendi-palette-overrides
        '(

          (bg-main     "#000000")
          (bg-dim      "#111111")
          (bg-active   "#222222")
          (bg-inactive "#333333")

          (fg-main     "#ffffff")
          (fg-dim      )
          (bg-region "#288B57")
          (fg-region "#FFFFFF")

          (cursor      "#00ffff")
          (warning     "#fafad2")

          (bg-completion "#2e8b57")
          (bg-region     bg-active)
          (bg-tab-bar        bg-main)
          (bg-tab-current    bg-active)
          (bg-tab-other      bg-dim)
          (fringe unspecified)
          (bg-mode-line-active bg-dim)
          (border-mode-line-active unspecified)
          (bg-line-number-active  bg-main)
          (bg-line-number-inactive  bg-main)
          ))


  (dolist (face '((org-level-1 . 1.4)
                  (org-level-2 . 1.2)
                  (org-level-3 . 1.1)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    ;; ----- previous value "Ioevka"
    (set-face-attribute (car face) nil :font "LiberationSerif" :weight 'medium :height (cdr face)))

  ;; ----- becoz we cant decide what we need for org-mode, our org is still ugly
  (set-face-attribute 'org-level-1 nil :font "LiberationSerif" :weight 'medium :height 1.4)
  (set-face-attribute 'org-level-2 nil :font "LiberationSerif" :weight 'medium :height 1.3)
  (set-face-attribute 'org-level-3 nil :font "Georgia" :weight 'medium :height 1.2)
  (set-face-attribute 'org-level-4 nil :font "Georgia" :weight 'medium :height 1.1)


  (load-theme 'modus-vivendi))




(use-package display-line-numbers
  :hook
  (python-mode . display-line-numbers-mode)
  (c++-mode . display-line-numbers-mode)
  )
