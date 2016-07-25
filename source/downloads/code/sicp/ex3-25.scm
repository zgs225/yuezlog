(define (make-table)
  (let ((local-table (list '*table*)))
    (define (assoc key records)
      (cond ((null? records) #f)
            ((equal? key (caar records)) (car records))
            (else (assoc key (cdr records)))))
    (define (lookup keys)
      (define (iter table keys)
        (if (null? keys) table
            (let ((subtable (assoc (car keys) table)))
              (if subtable
                  (iter (cdr subtable) (cdr keys))
                  #f))))
      (iter (cdr local-table) keys))
    (define (insert! keys value)
      (define (iter table keys)
        (if (null? keys)
            'ok
            (let ((subtable (assoc (car keys) (cdr table))))
              (if (not subtable)
                  (begin
                    (set! subtable (cons (car keys) '()))
                    (set-cdr! table (cons subtable
                                          (cdr table)))))
              (if (null? (cdr keys))
                  (set-cdr! subtable value))
              (iter subtable (cdr keys)))))
      (iter local-table keys))
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define operation-table (make-table))

(define get (operation-table 'lookup-proc))

(define put (operation-table 'insert-proc!))
