
(setq my-mode-list-contrast '(eww-form-text hydra-face-blue  org-mode-line-clock-overrun diff-refine-added))


(defun my-mode-line-generic-1()
  (interactive)
(force-mode-line-update)

  (setq mode-line-format
	'(
	  (:eval 
	   ;; (if (buffer-read-only)
	   ;;     (propertize "Re" 'face 'shr-h1)
	   ;;   (propertize "Wr" 'face 'shr-h1))
	   (if buffer-read-only
	       (propertize "Re " 'face (car my-mode-list-contrast))
	     (propertize "Wr " 'face (nth 1 my-mode-list-contrast))
	     )
	   
	   )
	   
	  (:eval (propertize "%05b " 'face
		  (if (buffer-modified-p)
		      (nth 2 my-mode-list-contrast)
		    (nth 3 my-mode-list-contrast))))
	  " -- "
	  (:eval (propertize (symbol-name major-mode) 'face 'font-lock-string-face
			     ))
	  " -- "
	  (:eval global-mode-string)
	  " -- "
	  (:eval (propertize
		  (let ((default-dir default-directory))
		    (cond ((string-match "\/\/" default-dir)
			   (car (nthcdr 2
					(split-string default-dir "/"))))
			  ((string-match "ahmadardie" default-directory)
			   (string-replace "c:\/Users\/ahmadardie.r\/" "~/" default-dir)
			   )
			  (t default-directory)			  
			  )
		    )
		  'face 'org-list-dt)))))			  
	  
	





(add-hook 'prog-mode-hook 'my-mode-line-generic-1)



(add-hook 'org-mode-hook 'my-mode-line-generic-1)

(add-hook 'ardie/special-org-hook 'my-mode-line-generic-1)











