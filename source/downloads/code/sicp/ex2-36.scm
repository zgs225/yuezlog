;; Happy hacking Yuez - Emacs ♥ you!

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map (lambda (lst) (car lst)) seqs))
            (accumulate-n op init (map (lambda (lst) (cdr lst)) seqs)))))
