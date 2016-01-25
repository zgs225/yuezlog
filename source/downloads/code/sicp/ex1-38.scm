(define (cont-frac-e k)
  (define (d i)
    (define (meet-condition? i)
      (= 0
         (remainder (- i 2) 3)))

    (define (satisfaction i)
      (* 2.0
         (/ (- i 2) 3)))

    (if (meet-condition? i)
        (satisfaction i)
        1))

  (+ 2
     (cont-frac (lambda (i) 1.0)
                d
                k)))
