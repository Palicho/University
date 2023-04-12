#lang racket


;[ zad 2 ]

(define (my-pow xs)
  (foldl * 1 xs))

;[ zad 3]

;(( lambda ( x y ) (+ x (* x y ) ) ) 1 2)
; ( lambda (1 2))
; (+ 1 (* 1 2))
; (+ 1 3)
; 4


;(( lambda ( x ) x ) ( lambda ( x ) x ) )
; ( lambda ( x ) x ) x)
; lambda ( x )
; x


;(( lambda ( x ) ( x x ) ) ( lambda ( x ) x ) )4


;(( lambda ( x ) ( x x ) ) ( lambda ( x ) ( x x ) ) )

; [ zad 4 ]

(define (square x)
  (* x x))

(define (inc x)
  (+ x 1))

(define (my-compose f g) 
  (lambda (x) (f (g x))))

; [ zad 5 ]

( define (negatives n)
   (build-list n ( lambda ( x ) (* -1 (+ x 1)))))

(define (reciprocals n)
  (build-list n (lambda ( x ) (/ 1 (+ x 1)))))

(define (evens n)
  (build-list n (lambda ( x ) (* 2 (+ x 1)))))

(define (row n i)
  (if (= n 0)
      null
      (if (= n i)
          (cons 1 (row (- n 1) i))
          (cons 0 (row (- n 1) i)))))
                
(define (identityM n)
  (build-list n ( lambda ( x ) (row n (- n x)))))
                                   

; [ zad 6 ]

(define empty-set
  (lambda (x) #f ))

(define ( singleton a)
  (lambda (




  












