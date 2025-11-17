(defun ardie/table--read-minibuffer ()
  (let (nothing)
    (list
    (string-to-number (read-from-minibuffer "sEnter Columns"))
    (string-to-number (read-from-minibuffer "sEnter Rows"))
    (read-from-minibuffer "sEnter cell leng as characters:")
    (read-from-minibuffer "sEnter row hight as characters:"))))


(defun table-insert (columns rows stringLength stringHeight)
  (interactive (progn (ardie/table--read-minibuffer)))

  ;; (print columns)

  

  ;; (interactive
  ;; (let ((string (read-string "Foo: ")))
  ;;  string)
  ;;  )
  ;; (interactive (list nil))
  (let ((cell-width (length stringLength))
	(cell-height (length stringHeight)))
    
    (beginning-of-line)
    (setq current-col (current-column))
    (setq current-row (count-lines (point-min) (point)))
    (setq current-coordinate (cons current-col current-row))

    
    (dotimes (row-i rows)
      ;; prefabricate the building blocks border-str and cell-str.
	;; construct border-str
	(insert table-cell-intersection-char)
	(setq cw cell-width)
	(setq i 0)


	(setq table-cell-horizontal-char ?\-)
	(setq table-cell-vertical-char ?\|)
	(setq table-cell-intersection-char ?\+)

	
	
	(dotimes (number columns)
	  (insert (make-string cw table-cell-horizontal-char) table-cell-intersection-char)

	  )
	(newline 1)
	
	;; (setq border-str (buffer-substring (point-min) (point-max)))
	;; construct cell-str

	(setq cw cell-width)


	(dotimes (number-cell-height cell-height)
	  (insert table-cell-vertical-char)
	  (dotimes (number columns)
	    (insert (make-string cell-width ?\ ))
	    (insert table-cell-vertical-char)
	    )
	  (newline 1)
	  )

	

      ;; if the construction site has an empty border push that border down.
	)
    	(insert table-cell-intersection-char)
    	(dotimes (number columns)
	  (insert (make-string cw table-cell-horizontal-char) table-cell-intersection-char)
	  
	  )
    ))