(define (adjoin x set)
  (cond ((null? set)
         (cons x set))
        ((= x (car set)) set)
        ((< x (car set)) (cons x set))
        (else (cons (car set) (adjoin x (cdr set))))))