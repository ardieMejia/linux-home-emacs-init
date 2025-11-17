  (defun ardie/add-to-special-abbrev()
    (interactive)
    ;; (print (substring-no-properties (ispell-get-word nil)))
    (if mark-active
        (let ((after (substring-no-properties (buffer-substring (region-beginning)(region-end)))))
          (exchange-point-and-mark)
          (pop-mark)
          (backward-char)
          ;; (ispell-get-word nil)
          ;; (print (word-at-point))
          (let ((before (substring-no-properties (word-at-point))))
            (define-abbrev xx-abbrev-table before after)
            ))
      (let ((after (substring-no-properties (word-at-point))))
        (backward-word)
        (backward-char)
        ;; (ispell-get-word nil)
        ;; (print (word-at-point))
        (let ((before (substring-no-properties (word-at-point))))
          (define-abbrev xx-abbrev-table before after)
          ))
      )
    )

(define-derived-mode ardie/special-org org-mode "my special org"
  "Major mode for org super completion"
  :abbrev-table xx-abbrev-table
  (message "My Special Org Mode is active!")
  )

(add-hook 'ardie/special-org-hook 'abbrev-mode)
