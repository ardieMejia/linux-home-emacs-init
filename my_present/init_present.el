

;; ========== I accidentally deleted some shit, please recheck how system-crafters set their presentation below, again...

(setq visual-fill-column-width 110
      visual-fill-column-center-text t)


(defun my-org-present-start ()
  ;; Center the presentation and wrap lines
  (visual-fill-column-mode 1)
  (visual-line-mode 1))

(defun my-org-present-end ()
  ;; Stop centering the document
  (visual-fill-column-mode 0)
  (visual-line-mode 0))


(add-hook 'org-present-mode-hook 'my-org-present-start)
(add-hook 'org-present-mode-quit-hook 'my-org-present-end)
