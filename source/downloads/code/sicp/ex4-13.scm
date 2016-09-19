(define (make-unbound! var env)
  (let ((frame (frist-frame env))
        (define (scan vars vals new-vars new-vals)
          (cond ((null? vars)
                 (make-frame new-vars new-vals))
                ((eq? var (cdr vars))
                 (scan vars vals new-vars new-vals))
                (else (scan (cdr vars)
                            (cdr vals)
                            (cons (car vars) new-vars)
                            (cons (cdr vals) new-vals)))))
        (set-car! env (scan (frame-variables frame)
                            (frame-values frame)
                            '()
                            '()))
        'done)))
