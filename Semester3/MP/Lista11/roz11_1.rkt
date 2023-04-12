#lang racket

(define-syntax my-and
  (syntax-rules ()
    [ (my-and ())
      #t]
    [ (my-and a1 a2 ...)
      (if a1 (my-and a2 ...) #f)]))

(define-syntax  my-or
  (syntax-rules()
    [(my-or a1)
     #f]
    [(my-or a1 a2 ...)
     (if a1 #t (my-or a2 ...))]))

(define-syntax my-let
  [syntax-rules ()
    [ (my-let () a)
      a]
    [ (my-let ([x1 a1] [x2 a2] ...) a)
      (my-let ([x2 a2] ...) (λ ( x1 ) a) a)]])

(define-syntax my-let*
  (syntax-rules ()
    [ (my-let* ([x1 a1] [x2 a2] ...) a)
      ((λ (x1 )
        (my-let* ([ x2 a2 ] ...) a)) a1)]))
  
               
               
    