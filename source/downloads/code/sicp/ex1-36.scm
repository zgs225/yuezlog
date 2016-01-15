(define tolerance 0.00001)

(define (displayed-fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))

  (define (fixed-point-log point count)
    (newline)
    (display "Find a fixed point: ")
    (display point)
    (newline)
    (display "Total steps: ")
    (display count))

  (define (try guess count)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          (fixed-point-log next count)
          (try next (1+ count)))))

  (try first-guess 1))
