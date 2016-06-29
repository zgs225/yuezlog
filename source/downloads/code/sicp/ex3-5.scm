(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (estimate-integral p x1 x2 y1 y2 trials)
  (define (test)
    (p (random-in-range x1 y2)
       (random-in-range x1 y2)))
  (* (- x2 x1) (- y2 y1) (monte-carlo trials test)))

(define (in-range? x y)
  (<= (+ (square (- x 1))
         (square (- y 1)))
      1))
