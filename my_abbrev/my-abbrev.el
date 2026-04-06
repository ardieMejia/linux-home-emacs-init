
;; ==================================================
;; ===== inspired by follow https://endlessparentheses.com/ispell-and-abbrev-the-perfect-auto-correct.html
;; ==================================================








  
(setq ardie/major-mode-abbrev-alist
      '(
	(ardie/special-org-mode . ardie/special-org-mode-abbrev-table)
	(ardie/c++-mode . ardie/c++-mode-abbrev-table)
	(ardie/c-mode . ardie/c-mode-abbrev-table)
	)
      )



;; ==================================================
;; ===== symbol-value makes this script work, coz we want the vector itself
;; ===== not the symbol itself, although it doesnt make sense at first,    
;; ===== its better to think of eLisp returning the pointer to that vector 
;; ==================================================			  
(defun ardie/add-to-our-abbrev-tables()
  (interactive)
  (if mark-active
      (let ((after (substring-no-properties (buffer-substring (region-beginning)(region-end)))))
        (exchange-point-and-mark)
        (pop-mark)
        (backward-char)
        (let ((before (substring-no-properties (word-at-point))))
	  (define-abbrev (symbol-value (alist-get major-mode ardie/major-mode-abbrev-alist)) before after)
          ))
    (let ((after (substring-no-properties (word-at-point))))
      (backward-word)
      (backward-char)
      (let ((before (substring-no-properties (word-at-point))))
	(define-abbrev (symbol-value (alist-get major-mode ardie/major-mode-abbrev-alist)) before after)
        ))
    )
  )



(define-derived-mode ardie/c++-mode c++-mode  "ardie's cpp"
  "Major mode for ardie's cpp completion"
  :abbrev-table ardie/c++-mode-abbrev-table
  (message "My c++ mode is active!")
  )

(define-derived-mode ardie/c-mode c-mode  "ardie's c mode"
  "Major mode for ardie's c completion"
  :abbrev-table ardie/c-mode-abbrev-table
  (message "Its Raylib time!")
  ;; ===== cc-mode variables are buffer-local, which is not what normal Emacs users are usually expecting
  ;; ===== so we do this:  
  (setq c-basic-offset 4)
  (setq c-indentation-style "k&r")
  (setq projectile-indexing-method 'native)
  )

;; (add-hook 'ardie/special-org-mode-hook 'abbrev-mode)


(define-derived-mode ardie/special-org-mode org-mode "my special org"
  "Major mode for org super completion"
  :abbrev-table ardie/special-org-mode-abbrev-table
  (message "My Special Org Mode is active!")
)

(use-package abbrev
  ;; :init code runs before the package is loaded.
  :init
  ;; Enable global abbrev mode when Emacs starts
  ;; Load the standard abbrev definitions file
  (read-abbrev-file "~/my-autocompletes/abbrev_defs")

  ;; :config code runs after the package is fully loaded (if lazy loading was used, 
  ;; but for a built-in like abbrev, it runs during startup).
  :config
  ;; Customize the file where abbreviations are saved
  (setq abbrev-file-name "~/my-autocompletes/abbrev_defs")
  ;; Automatically save changed abbreviations to the file
  (setq save-abbrevs t)
  :hook
  (ardie/special-org-mode . abbrev-mode)
  (ardie/c++-mode . abbrev-mode)
  (ardie/c-mode . abbrev-mode)
    )







