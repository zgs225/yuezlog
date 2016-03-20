;; Happy hacking Yuez - Emacs ♥ you!

;; 定义1
(define (square-list items)
  (if (null? items)
      (list)
      (cons (square (car items)) (square-list (cdr items)))))

;; 定义2
(define (square-list items)
  (map (lambda (x)
         (square x))
       items))
