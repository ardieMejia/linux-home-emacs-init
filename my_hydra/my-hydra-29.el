;; ==================== One day, all are hydras will use combobulate as a base


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
  ("r" my-open-random-reading "random reading" :column "random reading")
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
  ("q" hydra-pop "exit everything" :column "1")    
  ("s"
     (progn
       (my-mark-line)
       (my-s-hydra/body)
       )

   "select line forward" :column "2")

  ("<down>" (progn
	      (drag-stuff-down 1)
	      (my-s-hydra/body))
   "" :column "3")
  ("<up>" (progn
	    (drag-stuff-up 1)
	    (my-s-hydra/body))
   "" :column "4")
  

  ("y"
   (progn
     (my-symbol)
     )
   "my-symbol" :column "5"
   :exit t)
  ("u"
   (progn
     (my-unsymbol)
     (hydra-pop))
   "" :column "6"
   :exit t)
  ("w" (progn
	 (kill-ring-save (region-beginning) (region-end))
	 nil
	 )
   "save to ring" :column "7")

  ("p" 
   (if mark-active
       (progn
	 (if buffer-read-only
	     (read-only-mode -1)
	   nil
	   )
	 (exchange-point-and-mark)
	 (kill-ring-save (region-beginning) (region-end))
	 (newline)
	 (yank)
	 ))
   "duplicate into after reg" :column "8")

  

  ("k" (progn
	 (if buffer-read-only
	     (read-only-mode -1)
	   nil
	   )
	 (kill-region (region-beginning) (region-end))
	 ;; (kill-line)
	 nil
	 )
   "kill" :column "9")
  ("c" ;; (comment-region (region-beginning) (region-end))
   (progn
     (if buffer-read-only
	 (read-only-mode -1)
       nil
       )
     (comment-dwim nil)
     nil)
   "comment" :column "10")
  ("f" ;; (comment-region (region-beginning) (region-end))
   (if
       (or (eq major-mode 'python-ts-mode) (eq major-mode 'python-mode))
       (combobulate-python-envelope-nest-if-else)
     )
   ;; (progn
   ;;   (if buffer-read-only
   ;; 	 (read-only-mode -1)
   ;;     nil
   ;;     )
   ;;   (comment-dwim nil)
   ;;   nil)
   "python env if-else" :column "11")
  ("q" 
   (progn (pop-mark)
	  nil)
   "quit")    
  )



(defhydra my-word-hydra 
  (:color purple)
  "my combobulate hydra"


  ;; I dont understand why 2 functions are allowed and still works
  ("q"
   (progn
   (hydra-pop)
   (pop-mark)
   (jump-to-register ?a)
     )
   :exit t)


  ("r" (progn
	 (set-register ?a (point-marker))
	 (forward-word)
	 (set-mark (point))
	 (backward-word)
	 (my-word-hydra/body)
	 )

   "select word under point" :column "1")
  ("SPC"

    (ardie/remove-trailing-leading-whitespace)


   

   "trim space" :column "2" :exit t)
  ("s" (if mark-active
	   (progn
	     (er/expand-region 1)
	     )
	 (my-word-hydra/body)
	 )

   "select word under point" :column "3")

  ("-" (progn
	 (if (replace-string-in-region "-" "_")
	     nil
	   (replace-string-in-region "_" "-")	   
	     )

	 )

   "select word under point" :column "5" :exit t)

    ("p" 
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
	 )
     nil)
   "duplicate into after reg" :column "6" :exit t)

  ("<left>"
   (if mark-active
       (progn
	 
	 (if (not (eq (point) (region-beginning)))
	     (exchange-point-and-mark)
	   )

	 (goto-char (region-beginning))
	 (if (or (eq ?\" (char-before))
		 (eq ?\( (char-before))
		 (eq ?\) (char-before))
		 (eq ?\; (char-before))
		 (eq ?\! (char-before))
		 (eq ?\/ (char-before))
		 )
	     (backward-char)
	   (backward-word)
	   )

	 (my-word-hydra/body)
	 )
     nil)
   "expand selection left" :column "7" )
  
  ("<right>"
   (if mark-active
       (progn
	 
	 (if (not (eq (point) (region-end)))
	     (exchange-point-and-mark)
	   )

	 (goto-char (region-end))
	 (if
	     (or (eq ?\" (char-after))
		 (eq ?\( (char-after))
		 (eq ?\) (char-after))
		 (eq ?\; (char-after))
		 (eq ?\! (char-after))
		 (eq ?\/ (char-after))
		 )
	     (forward-char)
	   (forward-word)
	   )


	 (my-word-hydra/body)
	 )
     nil)
   "expand selection right" :column "8" )
  ("y"
(progn
  (my-symbol-no-pop)
  (kill-ring-save (region-beginning) (region-end))
  (jump-to-register ?a)
     )
"my-symbol" :column "9"
   :exit t)
  ("u"
   (progn
     (my-unsymbol)
     (hydra-pop))
   :column "10"  :exit t)
  ;; ("u" (progn
  ;; 	 (my-unsymbol)
  ;; 	 (keyboard-quit)
  ;; 	 nil
  ;; 	 )
  ;;  "")
  ("w" (progn
	 (kill-ring-save (region-beginning) (region-end))
	 )
   "kill-save" :exit t)
    ("k" (progn
	 (if buffer-read-only
	     (read-only-mode -1)
	   nil
	   )
	 (kill-region (region-beginning) (region-end))
	 ;; (kill-line)
	 nil
	 )
   "kill" :exit t)
  ("c" ;; (comment-region (region-beginning) (region-end))
   (progn
     (if buffer-read-only
	 (read-only-mode -1)
       nil
       )
     (comment-dwim nil)
     nil)
   "comment" :column "11" :exit t)
  ("<down>" (progn
	      (drag-stuff-right 1)
	      nil)
   "right" )
  ("<up>" (progn
	    (drag-stuff-left 1)
	    nil)
   "left")
  )


(defhydra my-upper-hydra 
  (:color purple)
  "my UPPER hydra"

  ("q"
   (progn
     (hydra-pop)
     )
   :exit t)
    ("a" (progn
	   (left-word 1)
	   (upcase-word 1))
   "alto the word" :column "1" :exit t))


(defhydra my-capitalize-hydra 
  (:color purple)
  "my capitalize hydra"

  ("q"
   (progn
     (hydra-pop)
     )
   :exit t)

  ("z" (progn
	 (left-word 1)
	 (capitalize-word 1)
	 )
   "capitaliZe region" :column "1" :exit t))


(defhydra my-1-hydra 
  (:color purple)
  "my goto top"


  ("1" (progn
	 (goto-line 1)
	 )
   :exit t)
  )



(defhydra my-sexp-hydra 
  (:color purple)
  "mark-sexp based shortcut, no arrows just t"


  ;; options like :exit is funky, is not easy to find documentation, and took forever to figure out that :exit t, (instead of :exit nil) quits everything
  ("q"
   (progn
   (hydra-pop)
   (pop-mark)
   nil
     )
   :exit t)
    ;; ("q" hydra-pop "exit everything")    

  ("t"
   (if mark-active
       (progn	 
	 (forward-sexp)
	 (my-sexp-hydra/body)
	 )
     (progn
       (move-beginning-of-line nil)
       (set-mark (point))
       ;; (set-mark-command)
       (my-sexp-hydra/body)
       )
     )
   ;; (progn
   ;; 	 (backward-sexp)
   ;; 	 (set-mark (point))
   ;; 	 (forward-sexp)
   ;; 	 (my-sexp-hydra/body)
   ;; 	 )

   "select sexp under point" :column "1")

  ("k" (progn
	 (if buffer-read-only
	     (read-only-mode -1)
	   nil
	   )
	 (kill-region (region-beginning) (region-end))
	 ;; (kill-line)
	 nil
	 )
   "kill ":exit t)
  ("c" ;; (comment-region (region-beginning) (region-end))
   (progn
     (if buffer-read-only
	 (read-only-mode -1)
       nil
       )
     (comment-dwim nil)
     nil)
   "comment sexp" :column "2" :exit t)

  

  
  
  ("s"
   (progn
     (my-symbol)
     (hydra-pop))
   "symbol sexp" :exit t
   )
  ("p" 
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
   "duplicate into after reg" :column "4" :exit t)
    ("y"
   (progn
     (my-symbol)
     (hydra-pop))
   :exit t)
  ("u"
   (progn
     (my-unsymbol)
     (hydra-pop))
   "unsymbol sexp" :column "3")
  ;; ("u" (progn
  ;; 	 (my-unsymbol)
  ;; 	 (keyboard-quit)
  ;; 	 nil
  ;; 	 )
  ;;  "")
  ("w" (progn
	 (kill-ring-save (region-beginning) (region-end))
	 )
   :exit t)
  ("<down>"
   (when mark-active
     (progn
       (drag-stuff-down 1)
       (my-sexp-hydra/body)
       :exit t)
     )
   "down" :column "4")
  ("<up>"
   (when mark-active
     (progn
       (drag-stuff-up 1)
       (my-sexp-hydra/body))
     )
   "up")

  )


(defhydra my-kill-buffer-hydra 
  (:color purple)
  "kill-buffer hydra, only 1 so far"
  ("q"
   (progn
   (hydra-pop)
   nil
     )
   :exit t)

  ("k"
          (progn
	 (kill-buffer)
	 )
   "kill current buffer" :column "1")
  )



(defhydra my-swiper-hydra 
  (:color purple)
  "my swiper hydra"

  ("q" (pop-mark) (hydra-pop) :exit t) 

  ("i" (swiper-isearch (car swiper-history))
   "SWIPER only" :column "1"))



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



;; ========== global swiper minor mode for hydras.

;;;###autoload
(define-minor-mode my-swiper-mode
  "A minor mode so that my key settings override annoying major modes."
  ;; If init-value is not set to t, this mode does not get enabled in
  ;; `fundamental-mode' buffers even after doing \"(global-my-mode 1)\".
  ;; More info: http://emacs.stackexchange.com/q/16693/115
  :init-value t
  :lighter " my-swiper"
  :keymap (let ((map (make-sparse-keymap)))
	    (define-key map
	      ;; (kbd "C-c ;")
	      (kbd "; i")
	      'my-swiper-hydra/body) map))

(add-hook 'python-ts-mode-hook #'my-swiper-mode)




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
  ("c" (progn
	 (web-mode-element-content-select)
	 (my-custom-web-hydra/body))
   "content")
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
  ("r"
   (progn
     (move-beginning-of-line 1)
     (insert "\n")
     (save-excursion
       (web-mode-forward-sexp 1)
       (insert "\n")  
       )
     (previous-line)
     (set-mark (point))
     ;; (set-mark-command 1)
     (web-mode-forward-sexp 1)
     (next-line)
     (web-mode-element-wrap)
     )
   
   ;; (if mark-active
   ;; 	     (web-mode-element-wrap)
   ;; 	 nil)
   "wrap element with HACKY indentation")
  )


(defhydra my-reveal-hydra 
  (:color purple)
  "my combobulate hydra"


  ;; I dont understand why 2 functions are allowed and still works
  ("q"
   (progn
   (hydra-pop)
     )
   :exit t)

  
  ("v" (progn
	 (when (boundp 'ardie/is-org-present)
	   (org-reveal-export-to-html)
	   )
	 )
   
   "select word under point" :column "1" :exit t)
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




(add-hook 'python-ts-mode-hook #'my-word-mode)




;; ========== global UPPERCASE minor mode for hydras.



;;;###autoload
(define-minor-mode my-upper-mode
  "A minor mode so that my key settings override annoying major modes."
  ;; If init-value is not set to t, this mode does not get enabled in
  ;; `fundamental-mode' buffers even after doing \"(global-my-mode 1)\".
  ;; More info: http://emacs.stackexchange.com/q/16693/115
  :init-value t
  :lighter " my-upper"
  :keymap (let ((map (make-sparse-keymap)))
	    (define-key map
	      (kbd "; a")
	      'my-upper-hydra/body) map))




(add-hook 'python-ts-mode-hook #'my-upper-mode)




;; ========== global capitaliZe minor mode for hydras.



;;;###autoload
(define-minor-mode my-capitalize-mode
  "A minor mode so that my key settings override annoying major modes."
  ;; If init-value is not set to t, this mode does not get enabled in
  ;; `fundamental-mode' buffers even after doing \"(global-my-mode 1)\".
  ;; More info: http://emacs.stackexchange.com/q/16693/115
  :init-value t
  :lighter " my-capitalize"
  :keymap (let ((map (make-sparse-keymap)))
	    (define-key map
	      (kbd "; z")
	      'my-capitalize-hydra/body) map))




(add-hook 'python-ts-mode-hook #'my-capitalize-mode)










;; ========== global sexp minor mode for hydras.

;;;###autoload
(define-minor-mode my-sexp-mode
  "A minor mode so that my key settings override annoying major modes."
  ;; If init-value is not set to t, this mode does not get enabled in
  ;; `fundamental-mode' buffers even after doing \"(global-my-mode 1)\".
  ;; More info: http://emacs.stackexchange.com/q/16693/115
  :init-value t
  :lighter " my-sexp"
  :keymap (let ((map (make-sparse-keymap)))
	    (define-key map
	      ;; (kbd "C-c ;")
	      (kbd "; t")
	      'my-sexp-hydra/body) map))

(add-hook 'python-ts-mode-hook #'my-sexp-mode)






;; ========== global kill-buffer minor mode for hydras.

;;;###autoload
(define-minor-mode my-kill-buffer-mode
  "A minor mode so that my key settings override annoying major modes."
  ;; If init-value is not set to t, this mode does not get enabled in
  ;; `fundamental-mode' buffers even after doing \"(global-my-mode 1)\".
  ;; More info: http://emacs.stackexchange.com/q/16693/115
  :init-value t
  :lighter " my-kill-buffer"
  :keymap (let ((map (make-sparse-keymap)))
	    (define-key map
	      ;; (kbd "C-c ;")
	      (kbd "; k")
	      'my-kill-buffer-hydra/body) map))

(add-hook 'python-ts-mode-hook #'my-kill-buffer-mode)






;; ========== global goto1 minor mode for hydras.

;;;###autoload
(define-minor-mode my-1-mode
  "A minor mode so that my key settings override annoying major modes."
  ;; If init-value is not set to t, this mode does not get enabled in
  ;; `fundamental-mode' buffers even after doing \"(global-my-mode 1)\".
  ;; More info: http://emacs.stackexchange.com/q/16693/115
  :init-value t
  :lighter " my-1"
  :keymap (let ((map (make-sparse-keymap)))
	    (define-key map
	      ;; (kbd "C-c ;")
	      (kbd "; 1")
	      'my-1-hydra/body) map))

(add-hook 'python-ts-mode-hook #'my-1-mode)






(define-minor-mode my-reveal-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value nil
  :global nil
  :lighter " my-word"
  :keymap (let ((map (make-sparse-keymap)))
	    (define-key map
	      ;; (kbd "C-c ;")
	      (kbd "; v")
	      'my-reveal-hydra/body) map))

(add-hook 'org-mode-hook #'my-reveal-mode)
