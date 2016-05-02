(define (memq item lst)
  (cond ((null? lst) #t)
        ((eq? item (car lst)) lst)
        (else (memq item (cdr lst)))))
