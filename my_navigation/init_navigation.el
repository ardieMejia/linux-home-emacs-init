(drag-stuff-global-mode 1)


(defun my-grep-collective()
  "felt the need to use my own grep"
  (interactive)
  (let (
	(pattern (read-from-minibuffer "enter the pattern, no regexp, simple"))
	(fileExtension (read-from-minibuffer "enter file extension, no * or ."))
	)
    (compilation-start  (concat  "grep -ri \"" pattern "\" --include \\*"  fileExtension " *") 'grep-mode)))

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
  (if (not (eq (point) (point-max)))
      (if mark-active
	  (progn
	    (next-line)      
	    (move-end-of-line 1))
	(progn
	  (move-beginning-of-line 1)
	  (set-mark (point))
	  (move-end-of-line 1)))
    )
  )



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
  "my python diary"
  (find-file "/home/ardie/Documents/my_notes/my-org-files/misc/2021/PythonDiary.org"))

;; no global binding

;; ========== open non python diary ==========
(defun my-open-non-python-diary ()
  (interactive)
  "my non-python diary"
  (find-file "/home/ardie/Documents/my_notes/my-org-files/misc/2025/nonPythonDiary.org"))

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







;; ==================== key-chords ====================
(require 'key-chord)
(key-chord-mode 1)

(key-chord-define-global "zx" 'previous-buffer)
(key-chord-define-global ",." 'next-buffer)
(key-chord-define-global "qw" 'undo)
(key-chord-define-global "pj" 'dabbrev-expand)
;; ===== stupid escaping slashes, my brain hurts
(key-chord-define-global "]\\" '(lambda ()
                                  (interactive)
                                  (if
                                      (and
				       (null (window-right (car (window-list))))
				       (not (null (window-right (nth 1 (window-list)))))
                                       )
                                      (delete-window)
				    (progn
				      (display-buffer (get-buffer-create "*ardie-scratch*"))
				      (other-window 1)
				      )
                                    )))

(key-chord-define-global "p[" '(lambda ()
                                 (interactive)
                                 (if
                                     (null (window-right (car (window-list))))
                                     (other-window 1)
                                   )))


(key-chord-define-global "[]" '(lambda ()
                                 (interactive)
                                 (if
                                     (null (window-right (nth 1 (window-list))))
                                     (other-window 1)
                                   )))

(setq key-chord-typing-speed-threshold 0.7)
;; ==================== key-chords ====================


;; ===== timestamp and datetime library TODO: to move somewhere else
(require 'ts)


;; ===== simple magick convert ===== Eg: direct from jpg to png
(defun my-magick-convert ()
  (interactive)
  (let ((ardie-len-list (length (dired-get-marked-files))))
    (if (eq 1 ardie-len-list)
	(if (member (file-name-extension (car (dired-get-marked-files)))
		    '("jpg" "png" "jpeg" "webp")		      
		    )
	    ;; (print " it workrs")
	    
	    ;; (call-process-shell-command
	    (progn
	      (let
		  (
		   (fileExtension (read-from-minibuffer "enter output img extension without . (Eg: jpg)"))
		   )
		
		(start-process
		 ;; "magick   /home/ardie/my-trash/temp_what/flask.png ~/Desktop/hahaha.png"
		 "my-magick"
		 "*my-magick*"
		 "magick"
		 (car (dired-get-marked-files))
		 (concat "/home/ardie/Pictures/"
			 (format "%s-%s-%s__" (ts-hour (ts-now)) (ts-minute (ts-now)) (ts-second (ts-now)))
			 (file-name-sans-extension (file-name-nondirectory (car (dired-get-marked-files))))
			 "."
			 fileExtension)
		 )
		)
	      (shell-command (concat "xdg-open /home/ardie/Pictures"))
	      )
	  (print "nope, wrong filetype as input")
	  )
      (print "command only works for single files")
      )
    )
  )



;; ========== TODO: one day we should also move this somewhere else

(setq delete-by-moving-to-trash t)
(setq trash-directory "/home/ardie/my-trash")
 

;; this is rather forceful, but we need to make Emacs more pleasant
(setq-default message-log-max nil)
(kill-buffer "*Messages*")



(use-package company
  :config (setq company-idle-delay 0
		company-minimum-prefix-length 1
		company-tooltip-align-annotations t))
(add-hook 'after-init-hook 'global-company-mode)
