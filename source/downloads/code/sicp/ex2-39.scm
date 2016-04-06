;; Happy hacking, Yuez - Emacs ♥ you!

(define (reverse sequence)
  (accumulate (lambda (x y) (append y (list x))) '() sequence))

(define (reverse sequence)
  (fold-left (lambda (x y) (append (list y) x)) '() sequence))
