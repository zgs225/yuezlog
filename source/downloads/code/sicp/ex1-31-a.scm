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
  (define (dec k) (- k 1))

  (define (inc k) (+ k 1))

  (define (term k)
    (* (/ (dec k) k)
       (/ (inc k) k)))

  (define (next k) (+ k 2.0))

  (* 4 (product term 3.0 n next)))
