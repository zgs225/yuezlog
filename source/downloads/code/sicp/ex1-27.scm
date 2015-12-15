(define (carmichael-test? a n)
  (= (expmod a n n) a))

(define (carmichael-prime? n)
  (define (carmichael-prime-iter a)
    (cond ((= a 0) true)
          ((carmichael-test? a n) (carmichael-prime-iter (- a 1)))
          (else false)))

  (carmichael-prime-iter (- n 1)))
