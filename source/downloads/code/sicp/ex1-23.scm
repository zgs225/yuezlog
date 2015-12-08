(define (divisor? test-divisor n)
  (= (remainder n test-divisor) 0))

(define (next n)
  (if (odd? n)
      (+ n 2)
      (+ n 1)))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divisor? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (prime? n)
  (= n (smallest-divisor n)))
