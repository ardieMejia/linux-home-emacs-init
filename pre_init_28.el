(set-background-color "LemonChiffon")
(progn
  (custom-set-faces)
  (setq user-emacs-directory "~/.config/emacs/")
  ;;(add-to-list 'load-path (expand-file-name "elpa" user-emacs-directory))
  (setq package-user-dir "~/.config/emacs/elpa")

  (let ((default-directory "~/.config/emacs/elpa"))
    (normal-top-level-add-subdirs-to-load-path))
  ;; (custom-set-variables
  ;;  '(package-selected-packages
  ;;    '(magik-mode doom-themes modus-themes auto-complete multiple-cursors powershell marginalia vertico use-package)))
  

  (load-file "~/.config/emacs/init_28.el")
  )
