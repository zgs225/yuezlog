(define (let? exp)
  (tagged-list? exp 'let))

(define (let->combination exp env)
  (apply (make-lambda (let-params exp)
                      (let-body exp))
         (let-exps exp)))

(define (let-params exp)
  (map car (cadr exp)))

(define (let-exps exp)
  (map cadr (cadr exp)))

(define (let-body exp)
  (caddr exp))
