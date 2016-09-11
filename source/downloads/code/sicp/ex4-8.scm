(define (let? exp)
  (tagged-list? exp 'let))

(define (let->combination exp)
  (cond ((list? (cadr exp))
         (make-lambda (let-params exp)
                      (let-body exp)))
        ((symbol? (cadr exp))
         (make-define (let-named-name exp)
                      (let-named-params exp)
                      (let-named-body exp)))
        (else (error "Unknown let -- LET->COMBINATION" exp))))

(define (make-define name params body)
  (list 'define (cons name params) body))

(define (let-named-name exp)
  (cadr exp))

(define (let-named-params exp)
  (map car (caddr exp)))

(define (let-named-body exp)
  (cadddr exp))

(define (let-params exp)
  (map car (cadr exp)))

(define (let-body exp)
  (caddr exp))
