
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

(defhydra my-p-hydra 
  (:color blue)
  "projectile hydra"
  ("q" hydra-pop "exit everything")    
  ("p" (projectile-find-file)
   "projectile find file" :column "1"))


(defhydra my-fh-hydra
  (:color blue)
  "file hydra"
  (";" (insert ";") :column "insert ;")
  ("q" nil "quit")    
  ("t" my-open-transient-todo "my-open-transient-todo" :column "files" )
  ("i" my-open-init-28  "init_28.el")
  ("j" my-open-daily-java "daily_java.org")
  ("p" my-open-python-diary "Python Diary")
  ("n" my-open-non-python-diary "non-Python Diary")
  ("r" my-open-general-zoho "Zoho" :column "sites")
  ("w" my-open-word-convert "word convert from html")
  ("y" my-open-yammer "yammer")
  ("g" my-open-ge "ge")
  ("l" my-open-alteia-docs :column "alteia docs")
  ("a" my-open-alteia :column "alteia")
  ("x" read-only-mode "read-only-mode")     
  )


(defhydra my-x-hydra
  (:color blue)
  "buffer hydra"
  ("q" nil "quit")
  (";" nil "quit")
  ;; TODO: this doesnt work with progn
  ("x" read-only-mode "read-only-mode")
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


(defhydra my-word-hydra 
  (:color blue)
  "select hydra"
  ("'" (insert "'") :column "insert '")
  ;; ("q" hydra-pop "exit everything")
  ("q" 
   (progn (pop-mark)
	  nil)
   "quit") 
  ("r" (progn
	 (left-word)
	 (set-mark (point))
	 (right-word)
	 (my-word-hydra/body)
	 )

   "select word under point" :column "1")

  ("<left>"
   (if mark-active
       (progn
	 
	 (if (not (eq (point) (region-beginning)))
	     (exchange-point-and-mark)
	   )

	 (goto-char (region-beginning))
	 (left-word)

	   

	 (my-word-hydra/body)
	 )
     nil)
   "")

  
  ("<right>"
   (if mark-active
       (progn
	 

	 (if (not (eq (point) (region-end)))
	     (exchange-point-and-mark)
	   )

	 (goto-char (region-end))
	 (right-word)
	   

	 (my-word-hydra/body)
	 )
     nil)
   "")
  ("y" (progn
	 (my-symbol)
	 (keyboard-quit)
	 nil
	 )
   "")
  ("u" (progn
	 (my-unsymbol)
	 (keyboard-quit)
	 nil
	 )
   "")
  ("w" (progn
	 (kill-ring-save (region-beginning) (region-end))
	 nil
	 )
   "")
  )





;; ==================== programmatically not as fun as calling hydras temporarily, such as this https://github.com/abo-abo/hydra/wiki/Nesting-Hydras


;;;###autoload
(define-minor-mode my-p-mode
  "A minor mode so that my key settings override annoying major modes."
  ;; If init-value is not set to t, this mode does not get enabled in
  ;; `fundamental-mode' buffers even after doing \"(global-my-mode 1)\".
  ;; More info: http://emacs.stackexchange.com/q/16693/115
  :init-value t
  :lighter " my-p"
  ;; :keymap '(((kbd "C-c ;") . #'my-basic-hydra/body))
  :keymap (let ((map (make-sparse-keymap)))
	    (define-key map
	      (kbd "; p")
	      'my-p-hydra/body) map))


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

(define-minor-mode my-x-mode
  "A minor mode so that my key settings override annoying major modes."
  ;; If init-value is not set to t, this mode does not get enabled in
  ;; `fundamental-mode' buffers even after doing \"(global-my-mode 1)\".
  ;; More info: http://emacs.stackexchange.com/q/16693/115
  :init-value t
  :lighter " my-x"
  :keymap (let ((map (make-sparse-keymap)))
	    (define-key map
	      (kbd "; x")
	      'my-x-hydra/body) map))



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


;;;###autoload
(define-globalized-minor-mode global-my-p-mode my-p-mode my-p-mode)

;; https://github.com/jwiegley/use-package/blob/master/bind-key.el
;; The keymaps in `emulation-mode-map-alists' take precedence over
;; `minor-mode-map-alist'
(add-to-list 'emulation-mode-map-alists `((my-p-mode . my-p-map)))

;; Turn off the minor mode in the minibuffer
(defun turn-off-my-p-mode ()
  "Turn off my-p-mode."
  (my-p-mode -1))
(add-hook 'minibuffer-setup-hook #'turn-off-my-p-mode)

(provide 'my-p-mode)



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
  ("r" (if mark-active
	     (web-mode-element-wrap)
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






;; ========== global word minor mode for hydras.



;;;###autoload
(define-minor-mode my-word-mode
  "A minor mode so that my key settings override annoying major modes."
  ;; If init-value is not set to t, this mode does not get enabled in
  ;; `fundamental-mode' buffers even after doing \"(global-my-mode 1)\".
  ;; More info: http://emacs.stackexchange.com/q/16693/115
  :init-value t
  :lighter " my-word"
  :keymap (let ((map (make-sparse-keymap)))
	    (define-key map
	      ;; (kbd "C-c ;")
	      (kbd "; r")
	      'my-word-hydra/body) map))

;;;###autoload
(define-globalized-minor-mode global-my-word-mode my-word-mode my-word-mode)

;; https://github.com/jwiegley/use-package/blob/master/bind-key.el
;; The keymaps in `emulation-mode-map-alists' take precedence over
;; `minor-mode-map-alist'
(add-to-list 'emulation-mode-map-alists `((my-word-mode . my-word-map)))

;; Turn off the minor mode in the minibuffer
(defun turn-off-my-word-mode ()
  "Turn off my-word-mode."
  (my-word-mode -1))
(add-hook 'minibuffer-setup-hook #'turn-off-my-word-mode)

(provide 'my-word-mode)
