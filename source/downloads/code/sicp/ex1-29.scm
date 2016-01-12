;;; Load p38-sum.scm
(define (simpson-integral f a b n)
  (define h (/ (- b a) n))

  (define (factory k)
    (cond ((or (= k 0) (= k n)) 1)
          ((even? k) 2)
          (else 4)))

  (define (y k)
    (f (+ a (* k h))))

  (define (term k)
    (* (factory k)
       (y k)))

  (define (next k)
    (+ k 1))

  (* (/ h 3)
     (sum term 0 next n)))
