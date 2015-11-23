; 使用递归计算过程
(define (f n)
  (if (< n 3) 1
      (+ (f (- n 1))
         (* 2 (f (- n 2)))
         (* 3 (f (- n 3))))))

; 使用迭代计算过程
(define (f2 n)
  (define (f2-iter x y z count)
    (if (< count 3) x
        (f2-iter (+ x (* 2 y) (* 3 z))
                 x
                 y
                 (- count 1))))
  (f2-iter 1 1 1 n))
