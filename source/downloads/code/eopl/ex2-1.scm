; 实现以 10 为底的 bigint
(define zero
  (lambda () '()))

(define is-zero?
  (lambda (n) (null? n)))

(define is-one?
  (lambda (n) (equal? (simplify n) '(1))))

(define successor
  (lambda (n)
    (if (is-zero? n)
        (cons 1 '())
        (if (= (+ (car n) 1) 10)
            (simplify (cons 0 (successor (cdr n))))
            (simplify (cons (+ (car n) 1) (cdr n)))))))

(define predecessor
  (lambda (n)
    (if (is-zero? n)
        '()
        (if (= (car n) 0)
            (simplify (cons 9 (predecessor (cdr n))))
            (simplify (cons (- (car n) 1) (cdr n)))))))

(define plus
  (lambda (x y)
    (if (is-zero? x)
        y
        (successor (plus (predecessor x) y)))))

; 化简 bigint，除去不必要的 0
; 比如将 '(0) 化简成 '()
(define simplify
  (lambda (n)
    (if (null? n)
        '()
        (if (and (= (car n) 0)
                 (null? (simplify (cdr n))))
            '()
            (cons (car n) (simplify (cdr n)))))))

; 乘法可以使用如下的递归方式描述
; n x m ::= m + (n - 1) x m
(define multiply
  (lambda (x y)
    (if (or (is-zero? x)
            (is-zero? y))
        (zero)
        (plus (multiply (predecessor x) y) y))))

(define factorial
  (lambda (n)
    (if (is-one? n)
        n
        (multiply n (factorial (predecessor n))))))
