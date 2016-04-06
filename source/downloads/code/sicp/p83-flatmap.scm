;; Happy hacking, Yuez - Emacs ♥ you!

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))
