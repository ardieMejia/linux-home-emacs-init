






;; ===== electric-pair-pairs is not accessible unless electric-pair-mode is activated, this online example does not work
;; (defvar c++-electric-pairs '((?< . ?>)) "Electric pairs for ardie/c++-mode.")
;; (defun ardie/c++-add-electric-pairs ()		       	      				 
;;   (setq-local electric-pair-pairs (append electric-pair-pairs c++-electric-pairs)))
;; ==================================================





;; (add-hook 'rust-mode-hook 
;;           (lambda () (local-set-key (kbd "M-<return>") 'ardie/add-semicolon-at-rust)))

(use-package sly-mrepl
  :hook
  (sly-mrepl-mode-hook . electric-pair-mode)
  ;; (c++-mode . ardie/c++-add-electric-pairs)
  
  :bind (
	 :map sly-mrepl-mode-map
	      ("<up>" . (lambda () (interactive)(sly-mrepl-previous-input-or-button 1)))
	      ("<down>" . (lambda () (interactive) (sly-mrepl-next-input-or-button 1)))
	      ("C-c ," . (lambda () (interactive)(insert ",")))
	      ;; ("C-c c" . (lambda () (interactive)(insert "m")))
	      )
  )
