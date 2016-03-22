;; Happy hacking Yuez - Emacs ♥ you!

(define (deep-reverse items)
  (define (reverse-iter remain-items result)
    (cond ((null? remain-items) result)
          ((pair? (car remain-items))
           (reverse-iter (cdr remain-items)
                         (cons (deep-reverse (car remain-items)) result)))
          (else (reverse-iter (cdr remain-items)
                              (cons (car remain-items) result)))))

  (reverse-iter items (list)))
