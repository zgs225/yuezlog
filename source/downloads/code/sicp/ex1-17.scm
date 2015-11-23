(define (new-* a b)
  (define (double i)
    (+ i i))

  (define (even? i)
    (= (remainder i 2) 0))

  (define (halve i)
    (/ i 2))

  (define (new-*-iter a b sum)
    (if (= b 0) sum
        (if (even? b)
            (new-*-iter (double a) (halve b) sum)
            (new-*-iter a (- b 1) (+ sum a)))))

  (new-*-iter a b 0))
