;; ==================== programmatically not as fun as calling hydras temporarily, such as this https://github.com/abo-abo/hydra/wiki/Nesting-Hydras
;; ----- one day we'll use this cool example
;; (defhydra my-s-hydra-child
;;   (:color blue)
;;   "select hydra"
;;   ("q" hydra-pop "exit everything")    
;;     ("b" (progn
;;          (my-s-hydra-child/body)
;;          (hydra-push '(my-s-hydra/body)))))


(defvar hydra-stack nil)

(defun hydra-push (expr)
  (push `(lambda () ,expr) hydra-stack))

(defun hydra-pop ()
  (interactive)    
  (let ((x (pop hydra-stack)))
    (when x
      (funcall x))))



(defhydra my-fh-hydra
  (:color blue)
  "file hydra"
  (";" (insert ";") :column "insert ;")
  ("q" nil "quit")    
  ("t" my-open-transient-todo "my-open-transient-todo" :column "files" )
  ("i" my-open-init-28  "init_28.el")
  ("j" my-open-daily-java "daily_java.org")
  ("p" my-open-python-diary "Python Diary")
  ("r" my-open-general-zoho "Zoho" :column "sites")
  ("w" my-open-word-convert "word convert from html")
  ("y" my-open-yammer "yammer")
  ("g" my-open-ge "ge")
  ("l" my-open-alteia-docs :column "alteia docs")
  ("a" my-open-alteia :column "alteia")
  ("." my-c-hydra/body :column "copy hydras")
  ("x" read-only-mode "read-only-mode")     
  )


(defhydra my-b-hydra
  (:color blue)
  "buffer hydra"
  ("q" nil "quit")
  (";" nil "quit")
  ("b" (progn
	 (switch-to-buffer (other-buffer))
	 (my-b-hydra/body)
	 )   
   "open last visited buffer" :column "navigation 1")
  ;; read only doesnt work properly,  not sure why it works for the original code
  ;; ("x" (progn
  ;; 	 (read-only-mode buffer-file-name)
  ;; 	 (my-b-hydra/body))
  ;; 	 "read-only-mode"
  ;; 	 )
  ("k" (kill-buffer)
   "kill buffer")
  ("h" (progn
	 (mark-whole-buffer)
	 (my-b-hydra/body))
   "mark whole buffer"
   )
  ("w" (progn
	 (kill-ring-save (region-beginning) (region-end))
	 (my-b-hydra/body))
   "mark whole buffer")
  ("y" (progn
	 (yank)
	 (my-b-hydra/body))
   "yank" :column "navigation 2")
  ("<down>" (progn
	      (next-line)
	      (my-b-hydra/body))
   "")
  ("<up>" (progn
	    (previous-line)
	    (my-b-hydra/body))
   "")
  ("<prior>" (progn
	       (scroll-down-command)
	       (my-b-hydra/body))
   "")
  ("<next>" (progn
	      (scroll-up-command)
	      (my-b-hydra/body))
   "" :column "navigation 3")
  ("RET" (progn
	   (newline)
	   (my-b-hydra/body))
   "")
  ;; TODO: this doesnt work with progn
  ("x" read-only-mode "read-only-mode")
  ("0" delete-window "delete current window")
  )


(defhydra my-c-hydra 
  (:color blue)
  "copy hydra"
  ("." (insert ".") :column "insert .")
  ("q" nil "quit")    
  ("c" my-copy-password "copy word/passwords/etc.." :column "text copies")
  ("f" my-magik-copy-defun "copy magik method")
  ("l" my-copy-line "copy line")
  )


(defhydra my-s-hydra 
  (:color blue)
  "select hydra"
  ("'" (insert "'") :column "insert '")
  ("q" hydra-pop "exit everything")    
  ("s" (progn
	 (my-mark-line)
	 (my-s-hydra/body)
	 )

   "select line forward" :column "1")

  ("<down>" (progn
	      (drag-stuff-down 1)
	      (my-s-hydra/body))
   "")
  ("<up>" (progn
	    (drag-stuff-up 1)
	    (my-s-hydra/body))
   "")
  
  ("e" (progn
	 (my-end-to-line)
	 )
   "from point to EOL" :column "2")
  ("u" (progn
	 (my-unmark-line)
	 (my-s-hydra/body)
	 )
   "unselect reverse" :column "3")
  ("w" (progn
	 (kill-ring-save (region-beginning) (region-end))
	 nil
	 )
   "save to ring")

  ("y" 
   (if mark-active
       (progn
	 (if buffer-read-only
	     (read-only-mode -1)
	   nil
	   )
	 (kill-ring-save (region-beginning) (region-end))
	 (move-end-of-line 1)
	 (newline)
	 (yank)
	 ))
   "duplicate into after reg" :column "4")

  

  ("k" (progn
	 (if buffer-read-only
	     (read-only-mode -1)
	   nil
	   )
	 (kill-region (region-beginning) (region-end))
	 ;; (kill-line)
	 nil
	 )
   "kill")
  ("c" ;; (comment-region (region-beginning) (region-end))
   (progn
     (if buffer-read-only
	 (read-only-mode -1)
       nil
       )
     (comment-dwim nil)
     nil)
   "comment" :column "5")
  ("q" 
   (progn (pop-mark)
	  nil)
   "quit")    
  )






;; ==================== programmatically not as fun as calling hydras temporarily, such as this https://github.com/abo-abo/hydra/wiki/Nesting-Hydras

;;;###autoload
(define-minor-mode my-fh-mode
  "A minor mode so that my key settings override annoying major modes."
  ;; If init-value is not set to t, this mode does not get enabled in
  ;; `fundamental-mode' buffers even after doing \"(global-my-mode 1)\".
  ;; More info: http://emacs.stackexchange.com/q/16693/115
  :init-value t
  :lighter " my-fh"
  ;; :keymap '(((kbd "C-c ;") . #'my-basic-hydra/body))
  :keymap (let ((map (make-sparse-keymap)))
	    (define-key map
	      ;; (kbd "C-c ;")
	      (kbd "; ;")
	      'my-fh-hydra/body) map))

(define-minor-mode my-b-mode
  "A minor mode so that my key settings override annoying major modes."
  ;; If init-value is not set to t, this mode does not get enabled in
  ;; `fundamental-mode' buffers even after doing \"(global-my-mode 1)\".
  ;; More info: http://emacs.stackexchange.com/q/16693/115
  :init-value t
  :lighter " my-b"
  :keymap (let ((map (make-sparse-keymap)))
	    (define-key map
	      (kbd "; b")
	      'my-b-hydra/body) map))



;;;###autoload
(define-globalized-minor-mode global-my-fh-mode my-fh-mode my-fh-mode)

;; https://github.com/jwiegley/use-package/blob/master/bind-key.el
;; The keymaps in `emulation-mode-map-alists' take precedence over
;; `minor-mode-map-alist'
(add-to-list 'emulation-mode-map-alists `((my-fh-mode . my-file-fh-map)))

;; Turn off the minor mode in the minibuffer
(defun turn-off-my-fh-mode ()
  "Turn off my-mode."
  (my-fh-mode -1))
(add-hook 'minibuffer-setup-hook #'turn-off-my-fh-mode)

(provide 'my-fh-mode)

;; ========== copy hydra

;;;###autoload
(define-minor-mode my-c-mode
  "A minor mode so that my key settings override annoying major modes."
  ;; If init-value is not set to t, this mode does not get enabled in
  ;; `fundamental-mode' buffers even after doing \"(global-my-mode 1)\".
  ;; More info: http://emacs.stackexchange.com/q/16693/115
  :init-value t
  :lighter " my-c"
  ;; :keymap '(((kbd "C-c ;") . #'my-basic-hydra/body))
  :keymap (let ((map (make-sparse-keymap)))
	    (define-key map
	      ;; (kbd "C-c ;")
	      (kbd "; .")
	      'my-c-hydra/body) map))



;;;###autoload
(define-globalized-minor-mode global-my-c-mode my-c-mode my-c-mode)

;; https://github.com/jwiegley/use-package/blob/master/bind-key.el
;; The keymaps in `emulation-mode-map-alists' take precedence over
;; `minor-mode-map-alist'
(add-to-list 'emulation-mode-map-alists `((my-c-mode . my-c-map)))

;; Turn off the minor mode in the minibuffer
(defun turn-off-my-c-mode ()
  "Turn off my-c-mode."
  (my-c-mode -1))
(add-hook 'minibuffer-setup-hook #'turn-off-my-c-mode)

(provide 'my-c-mode)




;; ========== select hydra

;;;###autoload
(define-minor-mode my-s-mode
  "A minor mode so that my key settings override annoying major modes."
  ;; If init-value is not set to t, this mode does not get enabled in
  ;; `fundamental-mode' buffers even after doing \"(global-my-mode 1)\".
  ;; More info: http://emacs.stackexchange.com/q/16693/115
  :init-value t
  :lighter " my-s"
  ;; :keymap '(((kbd "C-c ;") . #'my-basic-hydra/body))
  :keymap (let ((map (make-sparse-keymap)))
	    (define-key map
	      ;; (kbd "C-c ;")
	      (kbd "; s")
	      'my-s-hydra/body) map))



;;;###autoload
(define-globalized-minor-mode global-my-s-mode my-s-mode my-s-mode)

;; https://github.com/jwiegley/use-package/blob/master/bind-key.el
;; The keymaps in `emulation-mode-map-alists' take precedence over
;; `minor-mode-map-alist'
(add-to-list 'emulation-mode-map-alists `((my-s-mode . my-s-map)))

;; Turn off the minor mode in the minibuffer
(defun turn-off-my-s-mode ()
  "Turn off my-s-mode."
  (my-s-mode -1))
(add-hook 'minibuffer-setup-hook #'turn-off-my-s-mode)

(provide 'my-s-mode)






;; New web-mode only hydras. The first of many to come ====================

(defhydra my-custom-web-hydra (:color blue) 
  "file hydra"
  (";" (insert ";") :column "insert ;")
  ("q" nil "quit")    
  ("a" (progn
	 (web-mode-attribute-select)
	 (my-custom-web-hydra/body))
   
   "attribute" :column "select")
  ("e" (progn
	 (web-mode-element-select)
	 (my-custom-web-hydra/body))
   "element")
  ("k" (if mark-active
	   (progn
	     (if buffer-read-only (read-only-mode -1) nil)
	     (kill-region (region-beginning) (region-end))
	     nil)
	 nil)
   "kill")  
  ("w" (if mark-active
	   (kill-ring-save (region-beginning) (region-end))
	 nil)
   "save to ring")
  )




(define-minor-mode my-custom-web-mode
  "A minor mode so that my key settings override annoying major modes."
  ;; If init-value is not set to t, this mode does not get enabled in
  ;; `fundamental-mode' buffers even after doing \"(global-my-mode 1)\".
  ;; More info: http://emacs.stackexchange.com/q/16693/115
  :init-value nil
  :global nil	
  :lighter " my-custom-web"
  :keymap (let ((map (make-sparse-keymap)))
	    (define-key map (kbd "; w") #'my-custom-web-hydra/body) ;; putting the # by habit
	    (define-key map (kbd "TAB") #'my-web-indent)
	      	    map))

(add-hook 'web-mode-hook #'my-custom-web-mode)


