;;; 迭代的
(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))

  (iter a null-value))

;;; 使用accumulate定义sum
(define (sum term a next b)
  (accumulate + 0 term a next b))

;;; 使用accumulate定义product
(define (product term a b next)
  (accumulate * 1 term a next b))
