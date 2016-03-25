;; Happy hacking Yuez - Emacs ♥ you!

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

(define (total-weight mobile)
  (define (iter branch weight)
    (cond ((null? branch) weight)
          ((not (pair? branch))
           (+ branch weight))
          (else (iter (branch-structure (left-branch branch))
                      (iter (branch-structure (right-branch branch)) weight)))))
  (iter mobile 0))

(define (balance-mobile? mobile)
  (define (moment branch)
    (* (branch-length branch)
       (total-weight (branch-structure branch))))

  (cond ((not (pair? mobile)) #t)
        ((= (moment (left-branch mobile))
            (moment (right-branch mobile)))
         (and (balance-mobile? (branch-structure (left-branch mobile)))
              (balance-mobile? (branch-structure (right-branch mobile)))))
        (else #f)))
