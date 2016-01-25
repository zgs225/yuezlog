(define (repeated f n)
  (define (repeated-iter composer k)
    (if (= k 1)
        composer
        (repeated-iter (compose f composer) (- k 1))))

  (repeated-iter f n))
