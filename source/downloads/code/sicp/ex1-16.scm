(define (fast-expt b n)
  (define (even? n)
    (= (remainder n 2) 0))

  (define (fast-expt-iter b n product)
    (cond ((= n 0) product)
          ((even? n) (fast-expt-iter (square b) (/ n 2) product))
          (else (fast-expt-iter b (- n 1) (* product b)))))

  (fast-expt-iter b n 1))
