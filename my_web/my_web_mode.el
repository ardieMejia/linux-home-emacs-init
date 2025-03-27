

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


(defun my-web-indent ()
  (interactive)
  (indent-for-tab-command)
 (replace-regexp "[[:blank:]]>" ">" nil (line-beginning-position) (line-end-position))
 )
