;; ===== this .el NOT checked between ver.28 and ver.29


;; https://ddavis.io/blog/emacs-python-lsp/
;; https://fredrikmeyer.net/2020/08/26/emacs-python-venv.html
(use-package pyvenv
  :ensure t
  :init
  (setenv "WORKON_HOME" "~/.pyenv/versions"))



(defun my-flush-lines ()
  (interactive)
  (flush-lines "^$")
  )




;; (add-hook 'python-mode-hook 'anaconda-mode)
;; ===== we are disabling elpy coz its slower than company-mode. It doesnt matter completions are over-rated anyway.
;; (add-hook 'python-mode-hook 'elpy-mode)
;; (elpy-enable)


;; ===== elpy uses this python for completion,
;; ===== but apparently this is just for completion, and tree-sitter is not dependednt, and it will help this flexibly
;; ===== this is independent of virtual env, so Emacs will try to use system Python, but we can also use virtual env Python interpreter if desired
(setq elpy-rpc-python-command "/home/ardie/python-emacs-workspace/project_delete_1/myenv/bin/python")
(setq elpy-rpc-virtualenv-path "/home/ardie/python-emacs-workspace/project_delete_1/myenv")


(setq projectile-globally-ignored-file-suffixes '(".exe" ".png" ".jpg" ".gif" ".woff" ".woff2" ".ttf" ".cache"))






;; ;; ========== not exactly a Python specific thing. But all I have for now
;; (global-set-key (kbd "<drag-mouse-9>")  'ardie/fun-project-shell-command)
;; (global-set-key (kbd "<mouse-9>") 'ardie/fun-project-shell-command)
;; (defun ardie/fun-project-shell-command ()
;;   (interactive)
;;   (save-buffer)
;;   ;; (project-shell-command)
;;   (condition-case error
;;       ;; (shell-command ardie/project-shell-command)
;;       (compile ardie/project-shell-command)
;;     ('error (message "ardie/project-shell-command not defined")))
;;   )



(use-package python
  ;; (org-mode . visual-line-mode)
  :config
  ;; (require-theme 'modus-themes)
  (define-key inferior-python-mode-map (kbd "<up>") #'comint-previous-input)
  (define-key inferior-python-mode-map (kbd "<down>") #'comint-next-input)

  ;; (load-theme 'modus-vivendi)

  ;; (define-key global-map (kbd "<f5>") #'modus-themes-toggle)
  )
