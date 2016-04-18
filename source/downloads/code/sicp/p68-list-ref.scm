;; Happy hacking, Yuez - Emacs ♥ you!

;; Return nth element of a list
(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))
