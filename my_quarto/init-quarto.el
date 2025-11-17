(defun ardie/test2 (backend)
  (insert "---")
    (insert "\n")
  (insert
   "title: \"My Awesome Presentation\"\n"
   "author: \"Your Name\"\n"
   "format: pptx\n"
   )
    (insert "---")
  (insert "\n")
  )


(add-hook 'org-export-before-processing-functions 'ardie/test2)



(org-publish-project "my-present" t)





(setq org-publish-project-alist
      '(("my-present"
	 :base-directory "/home/ardie/my-trash/delete/sph2/present/"
	 :recursive t
	 :publishing-function org-md-publish-to-md
	 :publishing-directory "/home/ardie/my-trash/delete/sph2/present/"
	 :base_extension "org"
	 :with-sub-superscript nil
	 :section-numbers nil
	 :base-extension "org"
	 :with-toc nil)))
