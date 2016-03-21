;; Happy hacking Yuez - Emacs ♥ you!

(define (for-each operator items)
  (cond ((not (null? items))
         (operator (car items))
         (for-each operator (cdr items)))))

