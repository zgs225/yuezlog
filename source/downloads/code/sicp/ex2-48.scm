(define (make-segment vect1 vect2)
  (cons (ycor-vect vect1)
        (ycor-vect vect2)))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))
