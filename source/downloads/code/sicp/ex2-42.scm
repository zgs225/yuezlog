;; Happy hacking, Yuez - Emacs ♥ you!

(define (queens board-size)
  (define empty-board '())

  (define (safe? k positions)
    (define (item-check row-of-new-queen rest-of-queens i)
      (if (null? rest-of-queens)
          #t
          (let ((row-of-current-queen (car rest-of-queens)))
            (if (or (= row-of-new-queen row-of-current-queen)
                    (= row-of-new-queen (+ row-of-current-queen i))
                    (= row-of-new-queen (- row-of-current-queen i)))
                #f
                (item-check row-of-new-queen
                            (cdr rest-of-queens)
                            (+ i 1))))))
    (item-check (car positions)
                (cdr positions)
                1))

  (define (adjoin-position new-row k rest-of-queens)
    (cons new-row rest-of-queens))

  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))

  (queen-cols board-size))
