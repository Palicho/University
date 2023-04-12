#lang racket

;; streams aka lazy lists ---------------------------------

;; delay and force

(define-syntax-rule
  (stream-cons v s)
  (cons v (delay s)))

(define stream-car car)


(define (square x)
  (* x x))


(define (stream-cdr s)
  (force (cdr s)))

(define stream-null null)

(define stream-null? null?)

(define (stream-filter p s)
  (if (stream-null? s)
      stream-null
      (if (p (stream-car s))
          (stream-cons (stream-car s)
                       (stream-filter p (stream-cdr s)))
          (stream-filter p (stream-cdr s)))))

(define (divides? a b)
  (= (remainder b a) 0))


(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (integers-from n)
  (stream-cons n (integers-from (+ n 1))))

(define (prime? n)
  (define (iter ps)
    (cond ((> (square (stream-car ps) ) n) #t)
          ((divides? n (stream-car ps)) #f)
          (else (iter (stream-cdr ps)))))
  (iter primes))

(define primes
  (stream-cons 2 (stream-filter prime? (integers-from 3))))

(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))
