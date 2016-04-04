;; Happy hacking Yuez - Emacs ♥ you!

(define (count-leaves t)
  (accumulate (lambda (x y) (+ 1 y))
              0
              (map (lambda (x) x)
                   (enumerate-tree t))))
