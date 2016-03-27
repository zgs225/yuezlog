;; Happy hacking Yuez - Emacs ♥ you!

(define (square-tree-nomap tree)
  (cond ((null? tree) (list))
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree-nomap (car tree))
                    (square-tree-nomap (cdr tree))))))

(define (square-tree-map tree)
  (map (lambda (sub-tree)
         (if (not (pair? sub-tree))
             (square sub-tree)
             (square-tree-map sub-tree)))
       tree))
