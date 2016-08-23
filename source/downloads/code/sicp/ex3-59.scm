(define (integrate-series stream)
  (stream-map (lambda (a n)
                      (* a (/ 1 n)))
              stream
              integers))

(define exp-series
  (cons-stream 1 (integrate-series exp-series)))

(define cosine-series
  (cons-stream 1 (stream-map - (integrate-series sine-series))))

(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))
