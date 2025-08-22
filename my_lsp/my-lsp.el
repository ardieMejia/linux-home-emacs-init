

(use-package pyvenv
  ;; to make this all work, we just need to pyvenv-workon (use default), and then activate eglot or lsp
  ;; eglot better coz its more lightweight
  ;; we can ignore more garbage by adding setup.cfg, but eglot maybe doesnt need that
  :ensure t
  :defer t
  :diminish
  :config
  
  (setenv "WORKON_HOME" "/home/ardie/Documents/fiverr/terry_nonFiverr/myenv/")
					; Show python venv name in modeline
  (setq pyvenv-mode-line-indicator '(pyvenv-virtual-env-name ("[venv:" pyvenv-virtual-env-name "] ")))
  (pyvenv-mode t))



