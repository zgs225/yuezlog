(define (integrate-series stream)
  (stream-map (lambda (a n)
                      (* a (/ 1 n)))
              stream
              integers))
