(define (make-deque) (cons '() '()))

(define (front-ptr deque) (car deque))

(define (rear-ptr deque) (cdr deque))

(define (empty-deque? deque) (null? (front-ptr deque)))

(define (front-deque deque)
  (if (empty-deque? deque)
      (error "FRONT with an empty deque." deque)
      (cdr (car (front-ptr deque)))))

(define (rear-deque deque)
  (if (empty-deque? deque)
      (error "REAR with an empty deque." deque)
      (cdr (car (rear-ptr deque)))))

(define (front-insert-deque! deque item)
  (let ((new-pair (cons (cons '() item) '())))
    (cond ((empty-deque? deque)
           (set-car! deque new-pair)
           (set-cdr! deque new-pair))
          (else
            (set-car! (car (front-ptr deque))
                      new-pair)
            (set-cdr! new-pair (front-ptr deque))
            (set-car! deque new-pair)))))

(define (rear-insert-deque! deque item)
  (let ((new-pair (cons (cons '() item) '())))
    (cond ((empty-deque? deque)
           (set-car! new-pair)
           (set-cdr! new-pair))
          (else
            (set-car! (car new-pair)
                      (rear-ptr deque))
            (set-cdr! (rear-ptr deque) new-pair)
            (set-cdr! deque new-pair)))))

(define (front-delete-deque! deque)
  (if (empty-deque? deque)
      (error "FRONT DELETE! with an empty deque." deque)
      (begin
        (set-car! deque (cdr (front-ptr deque)))
        (set-car! (car (front-ptr deque)) '()))))

(define (rear-delete-deque! deque)
  (if (empty-deque? deque)
      (error "REAR DELETE! with an empty deque." deque)
      (begin
        (set-cdr! deque (car (car (rear-ptr deque))))
        (set-cdr! (rear-ptr deque) '()))))

(define (print-deque deque)
  (define (print-iter items)
    (if (not (null? items))
      (begin
        (display (cdr (car items)))
        (display " ")
        (print-iter (cdr items)))))
  (display ";(")
  (print-iter (front-ptr deque))
  (display ")")
  (newline))
