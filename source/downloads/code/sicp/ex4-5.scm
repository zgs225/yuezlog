(define (cond-recipient-clause? clause)
  (eq? '=> (cadr clause)))

(define (expand-clauses clauses)
  (if (null? clauses)
      #f
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (cond ((cond-else-clause? first)
               (if (null? rest)
                   (sequence->exp (cond-actions first))
                   (error "ELSE clause isn't last -- COND->IF" clauses)))
              ((cond-recipient-clause? first)
               (let ((predicate (car clause))
                     (body (caddr clause))
                     (predicate-value (eval predicate)))
                 (make-if predicate-value
                          (apply body predicate-value)
                          (expand-clauses))))
              (else (make-if (cond-predicate first)
                             (sequence->exp (cond-actions first))
                             (expand-clauses rest)))))))