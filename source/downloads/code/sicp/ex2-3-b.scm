(define (other-make-rect w-segment h-segment)
  (cons w-segment h-segment))

(define (width rect)
  (abs (- (x-point (start-segment (car rect)))
          (x-point (end-segment (car rect))))))

(define (height rect)
  (abs (- (y-point (start-segment (cdr rect)))
          (y-point (end-segment (cdr rect))))))
