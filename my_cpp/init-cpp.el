

(defun ardie/add-semicolon-at-cpp ()
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





(add-hook 'c++-mode-hook
          (lambda () (local-set-key (kbd "M-<return>") 'ardie/add-semicolon-at-cpp)))



;; ==================================================
;; ===== we REALLY need to change this ==============
;; ==================================================
(add-hook 'c-mode-hook
          (lambda () (local-set-key (kbd "M-<return>") 'ardie/add-semicolon-at-cpp)))

(use-package c++-mode
  :hook
  (c++-mode . electric-pair-mode)
  ;; (c++-mode . ardie/c++-add-electric-pairs)

  ;; ===== why init works here? for offset, why? check docs, weird
  :init								  
  
  
  (setq c-basic-offset 2)



  
  )
