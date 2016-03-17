;; Happy hacking Yuez - Emacs ♥ you!

(define (same-parity . numbers)
  (let ((operator (if (even? (car numbers)) even? odd?)))
    (define (iter remains result)
      (if (null? remains)
          (reverse result)
          (if (operator (car remains))
              (iter (cdr remains) (cons (car remains) result))
              (iter (cdr remains) result))))

    (iter (cdr numbers) (list))))
