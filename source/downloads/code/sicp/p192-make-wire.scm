(define (make-wire)
  (let ((signal-value 0) (action-procedures '()))
    (define (set-my-signal! new-value)
      (if (not (= signal-value new-value))
          (begin (set! signal-value new-value)
                 (call-each action-producres))
          'done))

    (define (accept-action-procedure! proc)
      (set! action-producres (cons proc action-producres))
      (proc))

    (define (dispatch m)
      (cond ((eq? m 'get-signal) signal-value)
            ((eq? m 'set-signal!) set-my-signal!)
            ((eq? m 'add-action!) accept-action-procedure!)
            (else (error "Unkwon operation -- WIRE" m))))
    dispatch))

(define (call-each producres)
  (if (null? producres)
      'done
      (begin
        ((car producres))
        (call-each (cdr producres)))))

(define (get-signal wire)
  (wire 'get-signal))

(define (set-signal! wire new-value)
  ((wire 'set-my-signal!) new-value))

(define (add-action! wire action-producre)
  ((wire 'add-action!) action-producre))
