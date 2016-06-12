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
                    (cond ((is-parent a1 (contents a2))
                           (drop (apply-generic op a1 (raise a2))))
                          ((is-parent a2 (contents a1))
                           (drop (apply-generic op (raise a1) a2)))
                          (else
                            (let ((t1->t2 (get-coercion type1 type2))
                                  (t2->t1 (get-coercion type2 type1)))
                              (cond (t1->t2
                                      (drop (apply-generic op (t1->t2 a1) a2)))
                                    (t2->t1
                                      (drop (apply-generic op a1 (t2->t1 a2))))
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

(define (drop arg)
  (if (equ? arg (raise (project arg)))
      (drop (project arg))
      arg))

(define (project arg)
  (apply-generic 'project arg))

(define (equ? x y) (apply-generic 'equ? x y))

(define (install-equ?-package)
  (put 'equ? '(scheme-number scheme-number)
       (lambda (x y) (= x y)))
  (put 'equ? '(rational rational)
       (lambda (x y) (and (= (numer x) (numer y))
                          (= (denom x) (denom y)))))
  (put 'equ? '(complex complex)
       (lambda (x y) (and (= (real-part x) (real-part y))
                          (= (imag-part x) (imag-part y)))))
  'done)

(define (install-project-package)
  (define (complex-project z)
    (make-rational (real-part z) 1))

  (define (rational-project x)
    (make-scheme-number (numer x)))

  (put 'project '(complex) complex-project)
  (put 'project '(rational) rational-project)

  'done)
