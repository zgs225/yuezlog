(define (make-rect p w h)
  (cons p
        (cons w h)))

(define (width rect)
  (car (cdr rect)))

(define (height rect)
  (cdr (cdr rect)))

(define (perimeter rect)
  (* (+ (width rect)
        (height rect))
     2))

(define (area rect)
  (* (width rect)
     (height rect)))
