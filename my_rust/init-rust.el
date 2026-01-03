

(defun ardie/add-semicolon-at-rust ()
  (interactive)
  (end-of-line)
  (insert ";")
  ;; (c-indent-line-or-region)
  )




;; ===== electric-pair-pairs is not accessible unless electric-pair-mode is activated, this online example does not work
;; (defvar c++-electric-pairs '((?< . ?>)) "Electric pairs for ardie/c++-mode.")
;; (defun ardie/c++-add-electric-pairs ()		       	      				 
;;   (setq-local electric-pair-pairs (append electric-pair-pairs c++-electric-pairs)))
;; ==================================================





;; (add-hook 'rust-mode-hook 
;;           (lambda () (local-set-key (kbd "M-<return>") 'ardie/add-semicolon-at-rust)))

(use-package rust-mode
  :hook
  (rust-mode . electric-pair-mode)
  ;; (c++-mode . ardie/c++-add-electric-pairs)

  :bind (
	 :map rust-mode-map
	 ("M-<return>" . ardie/add-semicolon-at-rust)
	 )


  
  




  
  )
