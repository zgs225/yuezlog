;; Happy hacking, Yuez - Emacs ♥ you!

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))
