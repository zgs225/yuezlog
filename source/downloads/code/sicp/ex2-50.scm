(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1.0 0)
                     (make-vect 0 0)
                     (make-vect 1.0 1.0)))

(define (rotate180 painter)
  (flip-vert painter))

(define (rotate270 painter)
  (transform-painter painter
                     (make-vect 0 1.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0 0)))
