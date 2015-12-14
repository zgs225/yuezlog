(define (search-for-primes start count)
  (define (next-odd n)
    (if (odd? n) (+ n 2)
        (+ n 1)))

  (define (search-for-primes-iter current count)
    (cond ((= count 0) (display "are primes"))
          ((fast-prime? current 10)
           (display current)
           (newline)
           (search-for-primes-iter (next-odd current) (- count 1)))
          (else (search-for-primes-iter (next-odd current) count))))

  (search-for-primes-iter start count))

(define (timed-search-for-primes start-number count)
  (define start-time (real-time-clock))

  (search-for-primes start-number count)
  (newline)
  (display " *** ")
  (newline)
  (display "Time costed: ")
  (display (- (real-time-clock) start-time)))
