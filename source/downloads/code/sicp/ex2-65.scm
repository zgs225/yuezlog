(define (union-tree a-tree b-tree)
  (list->tree
    (union-set (tree->list-2 a-tree)
               (tree->list-2 b-tree))))

(define (intersection-tree a-tree b-tree)
  (list->tree
    (intersection-set (tree->list-2 a-tree)
                      (tree->list-2 b-tree))))
