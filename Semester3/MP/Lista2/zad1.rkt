#lang racket


;zad 1

; zwykla rekursja
(define (fib n)
  (cond
    [(= n 0) 0]
    [(= n 1) 1]
    [else (+ (fib (- n 1)) (fib (- n 2)))]))

; rekursja ogonowa (iteracyjna)
(define (fib-iter n)
  (define ( it n fn-1 fn-2)
    (cond
      [(= n 0) fn-2]
      [(= n 1) fn-1]
      [else (it (- n 1) (+ fn-1 fn-2) fn-1)]))
  (it n 1 0))

;zad 2

; definicja struktury
(define-struct matrix (a1 a2 b1 b2))



(define (matrix-mult n m)
  (matrix (+ (* (matrix-a1 n) (matrix-a1 m))  (* (matrix-a2 n) (matrix-b1 m)))
          (+ (* (matrix-a1 n) (matrix-a2 m))  (* (matrix-a2 n) (matrix-b2 m)))
          (+ (* (matrix-b1 n) (matrix-a1 m))  (* (matrix-b2 n) (matrix-b1 m)))
          (+ (* (matrix-b1 n) (matrix-a2 m))  (* (matrix-b2 n) (matrix-b2 m)))))

(define matrix-id (matrix 1 0 0 1))

(define (matrix-expt n k)
  (define (help n m k )
  (if (= k 1) n (help (matrix-mult n  m) m (- k 1))))
  (help n n k ))

(define (fib-matrix k)
  (matrix-a2 (matrix-expt (matrix 1 1 1 0) k)))
  



(define x (matrix 2 3 4 6))
(define y (matrix -1 5 7 2))
(define xy (matrix-mult x matrix-id))

; zad 3

(define (matrix-expt-fast n k)
  (if (= k 1) n ((if (even? k) (matrix-expt (matrix-expt-fast n (/ k 2)) 2) (matrix-mult (matrix-expt-fast n (- k 1) n)))))) 

; zad 4
(define (elem? x xs)
  (if (equal? (cdr xs) null) #f (if (equal? (car xs) x) #t (elem? x (cdr xs)))))

;zad 5
;(define (maximum xs)
;  (define (help xs max)
;    (if (equal? (cdr xs) null) max (if (> (car xs) max) ( help (cdr xs) (car xs)) ( help (cdr xs) max)))))

;zad 8
;(define (delete x xs) ...)

(define (slect xs)
  (cons ( minimum xs ) ...))
        
(define (selection-sort xs)
  (if null ?> xs )
  null
  (let (( s (select xs))
        (cons ( car s ( selection-sort (cdr (s))))))))

;[zad 9]
(define (split xs)
  (cons (list-tail xs (floor(/ (2))))
        (list-tail ( reverse xs ) (ceiling ( / l 2)))))
(define (merge xs ys)
  (cond
    [(null? xs) y1]
    [(null? ys) x1]
    [else (if ( < (car xs) (car ys))
              (cons (car xs) (merge (cdr x)) ys)
              (cons (car y ) (merge xs ( xdr ys)))
        
                   