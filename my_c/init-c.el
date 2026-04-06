

(defun ardie/add-semicolon-at-c ()
  (interactive)
  (insert ";")
  ;; (c-indent-line-or-region)
  )
(defun ardie/add-semicolon-at-c-eol ()
  (interactive)
  (move-end-of-line 1)
  (insert ";")
  ;; (c-indent-line-or-region)
  )



(use-package cc-mode
  :hook
  (c-mode . electric-pair-mode)

  :config
  ;; cc settings are local, which is problematic
  ;; these dont work, instead, we can either use a hook, or in our case, a derived mode
  ;; and put our variable/settings there
  (setq c-basic-offset 4)
  (setq c-indentation-style "k&r")

  :bind
  (
   :map c-mode-map
   ("M-;" . nil)
   ("M-;" . ardie/add-semicolon-at-c)
   ("<M-return>" . ardie/add-semicolon-at-c-eol)
   )

  )

