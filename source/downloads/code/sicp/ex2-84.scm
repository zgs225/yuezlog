(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (if (not (eq? type1 type2))
                    (cond ((is-parent (contents a1) a2)
                           (apply-generic op a1 (raise a2)))
                          ((is-parent (contents a2) a1)
                           (apply-generic op (raise a1) a2))
                          (else
                            (let ((t1->t2 (get-coercion type1 type2))
                                  (t2->t1 (get-coercion type2 type1)))
                              (cond (t1->t2
                                      (apply-generic op (t1->t2 a1) a2))
                                    (t2->t1
                                      (apply-generic op a1 (t2->t1 a2)))
                                    (else
                                      (error "No method for these types"
                                            (list op type-tags)))))))
                    (error "No method for these types"
                           (list op type-tags))))
              (error "No method for these types"
                     (list op type-tags)))))))

(define (is-parent arg1 arg2)
  (cond ((not (pair? arg1)) #f)
        ((eq? (type-tag arg1) (type-tag arg2)) #t)
        (else (is-parent (contents arg1) arg2))))
