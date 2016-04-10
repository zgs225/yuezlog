;; Happy hacking, Yuez - Emacs ♥ you!

(define (sum-equal-tuple n s)
  (define (sum-tuple-equal-s? tuple)
    (= (+ (car tuple) (cadr tuple) (cadr (cdr tuple))) s))

  (filter sum-tuple-equal-s?
          (flatmap (lambda (i)
                     (map (lambda (j)
                            (cons i j))
                          (unique-pairs (- i 1))))
                   (enumerate-interval 1 n))))
