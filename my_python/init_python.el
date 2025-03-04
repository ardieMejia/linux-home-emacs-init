

(defun my-flush-lines ()
  (interactive)
  (flush-lines "^$")
  )




;; (add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'elpy-mode)
(elpy-enable)


(setq elpy-rpc-python-command "/home/ardie/python-emacs-workspace/project_delete_1/myenv/bin/python")

(setq elpy-rpc-virtualenv-path "/home/ardie/python-emacs-workspace/project_delete_1/myenv")


(setq projectile-globally-ignored-file-suffixes '(".exe" ".png" ".jpg" ".gif" ".woff" ".woff2" ".ttf" ".cache"))
