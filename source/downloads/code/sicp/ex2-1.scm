(define (make-rat n d)
  (define (rat-operator)
    (if (or (and (< n 0) (> d 0))
            (and (> n 0) (< d 0)))
        -
        +))
  (let ((g (gcd n d)))
        (cons ((rat-operator) (abs (/ n g)))
              (abs (/ d g)))))
