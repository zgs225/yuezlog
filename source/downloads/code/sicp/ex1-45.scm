(define (repeated-average-damp f n)
  ((repeated average-damp n) f))

(define (damped-nth-root n times)
  (define (f x)
    (lambda (y)
      (/ x (fast-expt y (- n 1)))))

  (lambda (x)
    (fixed-point (repeated-average-damp (f x) times)
                 1.0)))

(define (average-damped-times n)
  (if (= n 1)
      1
      (floor (/ (log n) (log 2)))))

(define (nth-root n)
  (damped-nth-root n (average-damped-times n)))
