(defun my-java-enter ()
  (interactive)
  (insert ";")
  (newline)
  (c-indent-line-or-region)
)

(add-hook 'java-mode-hook
          (lambda () (local-set-key (kbd "M-<return>") 'my-java-enter)))
