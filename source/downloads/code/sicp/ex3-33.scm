(define (average a b c)
  (let ((coef (make-connector))
        (temp (make-connector)))
    (adder a b temp)
    (constant 2 coef)
    (multiplier coef c temp)
    'ok))
