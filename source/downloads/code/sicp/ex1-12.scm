; 求解帕斯卡三角问题
(define (f n)
  (define (min-num n)
    (+ 1 (/ (* n (- n 1)) 2)))

  (define (max-num n)
    (/ (* n (+ n 1)) 2))

  (define (get-deep n)
    (define (get-deep-iter n count)
      (if (and (>= n (min-num count)) (<= n (max-num count)))
          count
          (get-deep-iter n (+ count 1))))
    (get-deep-iter n 1))

  (define deep (get-deep n))

  (define on-edge
    (if (or (= n (min-num deep))
            (= n (max-num deep)))
        #t
        #f))

  (if on-edge
      1
      (+ (f (- n deep)) (f (- n deep -1)))))

; 计算阶乘
(define (factorial n)
  (define (fact-iter product counter max-count)
    (if (> counter max-count)
        product
        (fact-iter (* product counter)
                   (+ counter 1)
                   max-count)))
  (fact-iter 1 1 n))

; Pascal triangle
(define (pascal row col)
  (/ (factorial row)
     (* (factorial col)
        (factorial (- row col)))))
