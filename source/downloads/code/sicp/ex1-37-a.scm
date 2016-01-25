(define (cont-frac n d k)
  (define (iter i)
    (if (= k i)
        (/ (n i)
           (d i))
        (/ (n i)
           (+ (d i) (iter (+ i 1))))))

  (iter 1))
