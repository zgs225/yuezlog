(define (cons a b)
  (* (expt 2 a)
     (expt 3 b)))

(define (car z)
  (define (f n c)
    (if (not (= (remainder n 2) 0))
        c
        (f (/ n 2) (+ c 1))))

  (f z 0))

(define (cdr z)
  (define (f n c)
    (if (not (= (remainder n 3) 0))
        c
        (f (/ n 3) (+ c 1))))

  (f z 0))
