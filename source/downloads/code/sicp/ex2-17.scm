;; Happy hacking Yuez - Emacs ♥ you!

(define (last-pair items)
  (if (= (length items) 1)
      items
      (last-pair (cdr items))))
