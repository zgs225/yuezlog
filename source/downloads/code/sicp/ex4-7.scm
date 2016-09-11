(define (let*->nested-lets exp env)
  (define (inner let*-exps)
    (if (null? (cdr let*-exps))
        (make-let (car let*-exps)
                  (let*-body exp))
        (make-let (car let*-exps)
                  (inner (cdr let*-exps)))))
  (inner (let*-exps exp)))

(define (let*-exps exp) (cadr exp))

(define (let*-body exp) (caddr exp))

(define (make-let let-params let-body)
  ('let let-params let-body))
