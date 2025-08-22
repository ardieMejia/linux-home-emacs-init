
;; ========== associate file
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))



;; ========== this one is from initial/default value auto-mode-alist
 ;; ("\\.[sx]?html?\\(\\.[a-zA-Z_]+\\)?\\'" . mhtml-mode) 


(setq web-mode-extra-auto-pairs
      '(
        ("html"  . (("{%" "%}")
                    ;; ("beg" "end")
		    )
	 )
	))



;; ========== if wondering, this is set in make-sparse-keymap in my-hydra.el
(defun my-web-indent ()
  (interactive)
  (indent-for-tab-command)
 (replace-regexp "[[:blank:]]>" ">" nil (line-beginning-position) (line-end-position))
 )




(setq web-mode-engines-alist '(("django" . "\\.html\\'") ))

(defun my-set-template-django()
  "set template as django"
  (interactive)
  ;; ========== can use this or web-mode-set-engine per-buffer
  (web-mode-set-engine "django")
  )

;; ========== one day should move all mode hook into one place? or not?
(add-hook 'web-mode-hook 'my-set-template-django)

				    

