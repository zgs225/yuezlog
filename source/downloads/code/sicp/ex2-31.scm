;; Happy hacking Yuez - Emacs ♥ you!

(define (tree-map process tree)
  (map (lambda (sub-tree)
         (if (not (pair? sub-tree))
             (process sub-tree)
             (tree-map process sub-tree)))
       tree))
