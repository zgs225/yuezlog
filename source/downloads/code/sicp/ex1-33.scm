(define (filtered-accumulate combiner null-value filter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (if (filter a)
            (iter
             (next a)
             (combiner (term a)
                       result))
            (iter
             (next a)
             result))))

  (iter a null-value))

;;; Load 练习1.28 miller-rabin-test

;;; 实现在区间a和b之间所有素数之和
(define (primes-sum a b)

  (define (fast-prime? n)
    (miller-rabin-prime? n 10))

  (define (indentity x) x)

  (define (next x)
    (if (even? x)
        (+ x 1)
        (+ x 2)))

  (filtered-accumulate + 0 fast-prime? indentity a next b))

;;; GCD
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;;; 实现小于n所有与n互素的正整数之乘积
(define (coprimes-product n)
  (define (filter i)
    (= 1 (gcd i n)))

  (define (indentity x) x)

  (define (next x) (+ x 1))

  (filtered-accumulate * 1 filter indentity 1 next n))
