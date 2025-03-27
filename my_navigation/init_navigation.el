(drag-stuff-global-mode 1)


(defun my-grep-collective()
  "felt the need to use my own grep"
  (interactive)
  (let (
	(pattern (read-from-minibuffer "enter the pattern, no regexp, simple"))
	(fileExtension (read-from-minibuffer "enter file extension, no * or ."))
	)
    (compilation-start  (concat  "grep -ri \"" pattern "\" --include \*"  fileExtension " " default-directory) 'grep-mode)))

;; ====================



;; ========== we are not sure what this does ==========
;; ==========  TODO ==========

;; (defun my-add-nonascii-highlighting ()
;;   (interactive)
;;   (font-lock-add-keywords 'grep-mode
;;                           '(("^.*magik:" . 'font-lock-function-name-face))))




;; (add-hook 'grep-mode-hook #'my-add-nonascii-highlighting)


;; ========== we are not sure this will work ==========
;; ==========  TODO ==========

(global-set-key (kbd "C-c m g") 'my-grep-collective)




(defun my-find-collective ()
  "a find version of my-grep-collective"
  (interactive)
  (let (
        (pattern (read-from-minibuffer "enter the filename, simple regexp, like *sOmEnAmE*"))
	)
    (compilation-start  (concat  "find " default-directory " -iname \*" pattern "\*") 'grep-mode)))
    
  

(global-set-key (kbd "C-c m f") 'my-find-collective)


(fset 'yes-or-no-p 'y-or-n-p)



(defun my-copy-directory ()
  "get current directory into clipboard"
  (interactive)
  (kill-new default-directory)
  (print default-directory)
  )

(global-set-key (kbd "C-c m , d") 'my-copy-directory)

(defun my-mark-line ()
  (interactive)
  "my own mark lien"
  (if mark-active
      (progn
	(next-line)      
	(move-end-of-line 1))
    (progn
      (move-beginning-of-line 1)
      (set-mark (point))
      (move-end-of-line 1))))

(defun my-end-to-line ()
  (interactive)
  "my own mark lien"
  (progn
    (set-mark (point))
    (move-end-of-line 1)))


(defun my-unmark-line ()
  (interactive)
  (if mark-active
      (progn
	(previous-line)      
	(move-end-of-line 1))))
  


(global-set-key (kbd "C-c l") 'my-mark-line)


(defun my-kill ()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line))

(global-set-key (kbd "C-c k") 'my-kill)




(setq my-prev-buff-name "*scratch*")
(defun my-previous-buffer ()
  (interactive)
  "my previous buffer "
  ;; (find-file "c:/Users/ahmadardie.r/Documents/shared_emacs/my-org-files/misc/2023/stuff_i_installed_at_work.org"))
  ;; (save-excursion
  ;;     (switch-to-buffer (car (nthcdr 1 buffer-name-history)))
  ;;   )
  (switch-to-buffer (other-buffer))
  )
;; no global binding


;; ========== open work diary ==========
(defun my-open-transient-todo ()
  (interactive)
  "my transient to-do"
   (find-file "/home/ardie/Documents/my_notes/my-org-files/transient.org"))
;; no global binding


;; ========== open work diary ==========
(defun my-open-python-diary ()
  (interactive)
  "my transient to-do"
  (find-file "/home/ardie/Documents/my_notes/my-org-files/misc/2021/PythonDiary.org"))

;; no global binding


;; ========== open daily java ==========
(defun my-open-daily-java ()
  (interactive)
  "my daily java"
  (find-file "/home/ardie/Documents/my_notes/my-org-files/misc/2024/daily_java.org"))
;; no global binding




;; ========== we dont bind to function anymore ==========

(vertico-mode 1)
(marginalia-mode 1)

(setq read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t)


(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))


;; ========== TODO ==========
;; ========== Georgia font doesnt work with org, what do we do ==========
(defun my-emacs-writer ()
  (interactive)
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
  (set-face-attribute 'org-level-1 nil :font "Georgia" :weight 'medium :height 1.7 :foreground "LemonChiffon4")
  (set-face-attribute 'org-level-2 nil :font "Georgia" :weight 'medium :height 1.4)
  (set-face-attribute 'org-level-3 nil :font "Georgia" :weight 'medium :height 1.2)
  (set-face-attribute 'org-level-4 nil :font "Georgia" :weight 'medium :height 1.2)
  
  (set-frame-parameter (selected-frame) 'internal-border-width 0)
  (set-frame-parameter (selected-frame) 'left-fringe 40)
  (set-frame-parameter (selected-frame) 'right-fringe 40)
  (set-face-background 'fringe "purple1")
  (set-background-color "LemonChiffon"))



(defun my-emacs-mute ()
  (interactive)
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
  (set-face-attribute 'org-level-1 nil :font "Georgia:line-spacing:100" :weight 'medium :height 1.8 :foreground  "Orange3")
  (set-face-attribute 'org-level-2 nil :font "Garamond" :weight 'medium :height 1.4 :foreground "purple1")
  (set-face-attribute 'org-level-3 nil :font "Georgia" :weight 'medium :height 1.2 :foreground "LemonChiffon4")
  (set-face-attribute 'org-level-4 nil :font "Georgia" :weight 'medium :height 1.1)
  
  (set-frame-parameter (selected-frame) 'internal-border-width 0)
  (set-frame-parameter (selected-frame) 'left-fringe 25)
  (set-frame-parameter (selected-frame) 'right-fringe 25)
  (set-face-background 'fringe "aquamarine1")
  (set-background-color "LightCyan1"))



;; ========== TODO: we need to replace agency fb
;; (defun my-emacs-life ()
;;   (interactive)
  
;;   (dolist (face '((org-level-1 . 1.2)
;;                   (org-level-2 . 1.1)
;;                   (org-level-3 . 1.05)
;;                   (org-level-4 . 1.0)
;;                   (org-level-5 . 1.1)
;;                   (org-level-6 . 1.1)
;;                   (org-level-7 . 1.1)
;;                   (org-level-8 . 1.1)))
;;     ;; ----- previous value "Ioevka"
;;     (set-face-attribute (car face) nil :font "Jost" :weight 'medium :height (cdr face)))
  
;;   ;; ----- becoz we cant decide what we need for org-mode, our org is still ugly
;;   (set-face-attribute 'org-level-1 nil :font "Agency FB" :weight 'medium :height 2.3 :foreground "VioletRed4")
;;   (set-face-attribute 'org-level-2 nil :font "Agency FB" :weight 'medium :height 1.5 :foreground "DodgerBlue1")
;;   (set-face-attribute 'org-level-3 nil :font "Garamond" :weight 'medium :height 1.4 :foreground "VioletRed4")
;;   (set-face-attribute 'org-level-4 nil :font "Arial" :weight 'medium :height 1.1  :foreground "DodgerBlue1")
  
;;   (set-frame-parameter (selected-frame) 'internal-border-width 0)
;;   (set-frame-parameter (selected-frame) 'left-fringe 40)
;;   (set-frame-parameter (selected-frame) 'right-fringe 40)
;;   (set-face-background 'fringe "DarkOliveGreen3")
;;   (set-background-color "DarkSeaGreen1"))



(setq my-symbol-numvar '("fringe" "hi-green" "mouse-drag-and-drop-region" "hi-aquamarine" "show-paren-match" "diff-indicator-removed" "hi-salmon" ))
(defun my-symbol ()
  (interactive)
  (setq my-symbol-numvar (append (cdr my-symbol-numvar)  (list (pop my-symbol-numvar))))
  (setq var1 (buffer-substring-no-properties  (region-beginning) (region-end)))
  (setq var2 (string-replace ":" "" var1))
  (highlight-phrase var2 (car my-symbol-numvar)))

(global-set-key (kbd "C-c y") 'my-symbol)



(defun my-unsymbol ()
  (interactive)
  ;; (thing-at-point 'word 'no-properties)
  (setq var1 (buffer-substring-no-properties  (region-beginning) (region-end)))
  (setq var2 (string-replace ":" "" var1))
  (unhighlight-regexp var2)
)

(global-set-key (kbd "C-c u") 'my-unsymbol)



(set-face-attribute 'region nil :background "#666" :foreground "#ffffff")
