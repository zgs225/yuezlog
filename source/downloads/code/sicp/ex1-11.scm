; 使用递归计算过程
(define (f n)
  (if (< n 3) n
      (+ (f (- n 1))
         (* 2 (f (- n 2)))
         (* 3 (f (- n 3))))))

; 使用迭代计算过程
(define (f2 n)
  (define (f2-iter x y z count)
    (cond ((< count 2) count)
          ((= count 2) x)
          (else (f2-iter (+ x (* 2 y) (* 3 z)) x y (- count 1)))))
  (f2-iter 2 1 0 n))
