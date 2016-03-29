;; Happy hacking Yuez - Emacs ♥ you!

(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (st) (cons (car s) st))
                          rest)))))
