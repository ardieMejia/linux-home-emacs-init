(defun ardie/add-semicolon-at-cpp ()
  (interactive)
  (end-of-line)
  (insert ";")
  ;; (c-indent-line-or-region)
)

(add-hook 'c++-mode-hook
          (lambda () (local-set-key (kbd "M-<return>") 'ardie/add-semicolon-at-cpp)))

