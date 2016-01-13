;;; Iterate product
(define (product term a b next)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result))))

  (iter a 1))

(define (factorial n)
  (define (term x) x)

  (define (next x) (+ x 1))

  (product term 1 n next))

(define (wallis-pi n)
  (define (numerator-term k)
    (if (even? k)
        (* 2 (+ (/ k 2) 1))
        (* 2 (+ (/ (- k 1) 2) 1))))

  (define (denominator-term k)
    (if (even? k)
        (+ k 1)
        (+ k 2)))

  (define (next k) (+ k 1))

  (exact->inexact
   (* 4 (/ (product numerator-term 1 n next)
           (product denominator-term 1 n next)))))
