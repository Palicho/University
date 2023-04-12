#lang racket

(define (list->mlist xs)
    (cond [(null? xs) null]
          [else (mcons (car xs) (list->mlist (cdr xs)))]))
(define l (list->mlist '(1 2 3 4)))
(define p (list->mlist '(1 2 3 4 5 6 7)))

(define (mreverse! mxs)
  (define (find-last mys)
    (if (null? (mcdr mys))
        mys
        (find-last (mcdr mys))))
  (define (aux mys prev)
    (if (null? (mcdr mys))
        (set-mcdr! mxs prev)
        (let ([next (mcdr mys)])
          (set-mcdr! mys prev)
          (aux next mys))))
  (cond [(not (or (null? mxs)
                  (null? (mcdr mxs))))
         (let ([tmp (mcar mxs)]
               [lst (find-last mxs)])
           
             (set-mcar! mxs (mcar lst))
             (set-mcar! lst tmp)
             (aux (mcdr mxs) lst))]))


      
        
               
