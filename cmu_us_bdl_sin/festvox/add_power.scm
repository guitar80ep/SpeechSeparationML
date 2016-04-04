;;;
;;;  add power 
;;;


(define (add_power datafile)
  (mapcar
   (lambda (f)
     (let ((utt (utt.load nil (format nil "festival/utts/%s.utt" (car f)))))
       (set! track (track.load (format nil "mcep/%s.mcep" (car f))))
       (set! phone (utt.relation.first utt 'Segment))
       (set! frame 0)
       (set! tracktime (track.get_time track frame))
       (while phone
	 (set! eee (item.feat phone "end"))
	 (set! cp 0.0)
	 (set! cf 0)
	 (while (< tracktime eee)
   	   (set! cp (+ cp (track.get track frame 0)))
	   (set! cf (+ 1 cf))
	   (set! frame (+ 1 frame))
	   (set! tracktime (track.get_time track frame)))
	 (item.set_feat phone "power" (/ cp cf))
	 (format t "%s %f\n" (item.name phone) 
		 (item.feat phone "power"))
         (set! phone (item.next phone)))
       (utt.save utt (format nil "festival/uttsp/%s.utt" (car f)))))
   (load datafile t))
  t
)