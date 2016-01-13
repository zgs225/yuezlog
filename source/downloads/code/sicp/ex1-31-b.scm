(define (product term a b next)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) b next))))
