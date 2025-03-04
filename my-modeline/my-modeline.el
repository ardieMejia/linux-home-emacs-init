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
	       (propertize "Re " 'face 'ansi-color-bold)
	     (propertize "Wr " 'face 'hydra-face-blue)
	     )
	   
	   )
	   
	  (:eval (propertize "%05b " 'face
		  (if (buffer-modified-p)
		      'org-mode-line-clock-overrun
		    'diff-refine-added)))
	  " -- "
	  (:eval (propertize mode-name 'face 'font-lock-string-face
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
	  
	



(add-hook 'magik-mode-hook 'my-mode-line-generic-1)

(add-hook 'python-mode-hook 'my-mode-line-generic-1)

(add-hook 'org-mode-hook 'my-mode-line-generic-1)

(add-hook 'magik-product-mode-hook 'my-mode-line-generic-1)

(add-hook 'magik-module-mode-hook 'my-mode-line-generic-1)

(add-hook 'emacs-lisp-mode-hook 'my-mode-line-generic-1)

(add-hook 'fundamental-mode-hook 'my-mode-line-generic-1)

(add-hook 'nxml-mode-hook 'my-mode-line-generic-1)

(add-hook 'powershell-mode-hook 'my-mode-line-generic-1)

(add-hook 'mhtml-mode-hook 'my-mode-line-generic-1)

(add-hook 'bat-mode-hook 'my-mode-line-generic-1)

(add-hook 'java-mode-hook 'my-mode-line-generic-1)



