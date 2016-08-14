(define (stream-enumerate-interval low high)
  (if (> low high)
      (stream)
      (cons-stream
       low
       (stream-enumerate-interval (+ low 1) high))))
