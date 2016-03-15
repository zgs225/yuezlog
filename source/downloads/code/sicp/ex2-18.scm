;; Happy hacking Yuez - Emacs ♥ you!

(define (reverse items)
  (define (reverse-iter remain-items result)
    (if (null? remain-items)
	result
	(reverse-iter (cdr remain-items)
		      (cons (car remain-items) result))))
  (reverse-iter items (list)))

