(setq my-list-org-sound '(
			    "/home/ardie/org_settings/mixkit-correct-answer-tone.wav"
			    ;; "C:/Users/ahmadardie.r/Desktop/org-clock/beeping.wav"
			    "/home/ardie/org_settings/mixkit-arabian-mystery-harp-notification.wav"
			    "/home/ardie/org_settings/mixkit-clear-announce-tones.wav"
			    "/home/ardie/org_settings/mixkit-confirmation-tone.wav"
			    "/home/ardie/org_settings/mixkit-correct-answer-reward.wav"
			    "/home/ardie/org_settings/mixkit-correct-answer-tone.wav"
			    "/home/ardie/org_settings/mixkit-happy-bells-notification.wav"
			    "/home/ardie/org_settings/mixkit-melodical-flute-music-notification.wav"
			    "/home/ardie/org_settings/mixkit-positive-notification.wav"
			    "/home/ardie/org_settings/mixkit-sci-fi-confirmation.wav"
			    "/home/ardie/org_settings/mixkit-software-interface-back.wav"
			    "/home/ardie/org_settings/mixkit-software-interface-remove.wav"
			    "/home/ardie/org_settings/mixkit-wrong-answer-fail-notification.wav"
			  ))


(defun my-org-sound-randomizer ()
  (interactive)
  (let ((my-n (1- (random (length my-list-org-sound)))))
    (setq org-clock-sound (car (nthcdr my-n my-list-org-sound)))
    )  
  )

