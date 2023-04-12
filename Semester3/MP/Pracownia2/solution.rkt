#lang racket
(require data/heap)

(provide sim? wire?
         (contract-out
          [make-sim        (-> sim?)]
          [sim-wait!       (-> sim? positive? void?)]
          [sim-time        (-> sim? real?)]
          [sim-add-action! (-> sim? positive? (-> any/c) void?)]

          [make-wire       (-> sim? wire?)]
          [wire-on-change! (-> wire? (-> any/c) void?)]
          [wire-value      (-> wire? boolean?)]
          [wire-set!       (-> wire? boolean? void?)]

          [bus-value (-> (listof wire?) natural?)]
          [bus-set!  (-> (listof wire?) natural? void?)]

          [gate-not  (-> wire? wire? void?)]
          [gate-and  (-> wire? wire? wire? void?)]
          [gate-nand (-> wire? wire? wire? void?)]
          [gate-or   (-> wire? wire? wire? void?)]
          [gate-nor  (-> wire? wire? wire? void?)]
          [gate-xor  (-> wire? wire? wire? void?)]

          [wire-not  (-> wire? wire?)]
          [wire-and  (-> wire? wire? wire?)]
          [wire-nand (-> wire? wire? wire?)]
          [wire-or   (-> wire? wire? wire?)]
          [wire-nor  (-> wire? wire? wire?)]
          [wire-xor  (-> wire? wire? wire?)]

          [flip-flop (-> wire? wire? wire? void?)]))

;==========================================================

(define-struct action (time  f))

(struct sim ([ time #:mutable] (queue #:mutable )))

(define (make-sim)
  (sim 0 (make-heap (lambda ( x y ) (< (action-time x) (action-time y) )))))

(define (sim-add-action! s t f )
  (heap-add! (sim-queue s) (action (+ (sim-time s) t) f)))


(define (sim-wait! s t)
  (begin
    (set-sim-time! s (+ (sim-time s) t))
    (if (not (= (heap-count (sim-queue s)) 0))
        (let ([ min (heap-min (sim-queue s))])
          (if (<= (action-time min) (sim-time s))
              (begin
                ((action-f min))
                (heap-remove-min! (sim-queue s))
                (sim-wait! s 0))
              (void))
          )
        (void))))
              
(struct wire ([value #:mutable] [actions #:mutable]  sim))

(define (make-wire s)
  (wire #f '() s))

(define (call-actions xs s)
  (if (null? xs)
      (void)
      (begin
        ((car xs))
        (call-actions (cdr xs) s))))


(define (wire-set! w v)
  (if (eq? v (wire-value w))
      (void)
      (begin
        (set-wire-value! w v)
        (call-actions (wire-actions w) (wire-sim w)))))

(define (wire-on-change! w f)
  (set-wire-actions! w (cons f (wire-actions w)))
  (f))

;===============================================================


(define (gate-nand c a b)
  (define (nand-action)
    (wire-set! c (not (and (wire-value a) (wire-value b)))))
  (wire-on-change! a (λ () (sim-add-action! (wire-sim c) 1 nand-action)))
  (wire-on-change! b (λ () (sim-add-action! (wire-sim c) 1 nand-action))))

(define (gate-not b a)
  (define ( not-action )
    (wire-set! b (not (wire-value a))))
  (wire-on-change! a (λ () (sim-add-action! (wire-sim a) 1 not-action))))

(define (gate-and c a b )
  (define (and-action)
    (wire-set! c (and (wire-value a) (wire-value b))))
  (wire-on-change! a (λ () (sim-add-action! (wire-sim a) 1 and-action)))
  (wire-on-change! b (λ () (sim-add-action! (wire-sim b) 1 and-action))))


(define (gate-or c a b)
  (define (or-action)
    (wire-set! c  (or (wire-value a) (wire-value b))))
  (wire-on-change! a (λ () (sim-add-action! (wire-sim a) 1 or-action)))
  (wire-on-change! b (λ () (sim-add-action! (wire-sim b) 1 or-action))))

(define (gate-nor c a b)
  (define (nor-action)
    (wire-set! c (not (or (wire-value a) (wire-value b)))))
  (wire-on-change! a (λ () (sim-add-action! (wire-sim a) 1 nor-action)))
  (wire-on-change! b (λ () (sim-add-action! (wire-sim b) 1 nor-action))))


(define (gate-xor c a b)
  (define (xor-action)
    (wire-set! c (and (or (wire-value a) (wire-value b)) (not (and (wire-value a) (wire-value b))))))
  (wire-on-change! a (λ () (sim-add-action! (wire-sim a) 2 xor-action)))
  (wire-on-change! b (λ () (sim-add-action! (wire-sim b) 2 xor-action))))


(define (wire-nand a b )
  (begin
    (define c (make-wire (wire-sim a)))
    (gate-nand c a b)
    c))

(define (wire-not a )
  (begin
    (define b (make-wire (wire-sim a)))
    (gate-not b a)
    b))

(define (wire-and a b )
  (begin
    (define c (make-wire (wire-sim a)) )
    (gate-and c a b)
    c))
  
(define (wire-or a b )
  (begin
    (define c (make-wire (wire-sim a)))
    (gate-or c a b)
    c))

(define (wire-xor a b )
  (begin
    (define c (make-wire (wire-sim a)))
    (gate-xor c a b)
    c))


(define (wire-nor a b )
  (begin
    (define c (make-wire (wire-sim a)))
    (gate-nor c a b)
    c))

;=============================================================


(define (bus-set! wires value)
  (match wires
    ['() (void)]
    [(cons w wires)
     (begin
       (wire-set! w (= (modulo value 2) 1))
       (bus-set! wires (quotient value 2)))]))

(define (bus-value ws)
  (foldr (lambda (w value) (+ (if (wire-value w) 1 0) (* 2 value)))
         0
         ws))

(define (flip-flop out clk data)
  (define sim (wire-sim data))
  (define w1  (make-wire sim))
  (define w2  (make-wire sim))
  (define w3  (wire-nand (wire-and w1 clk) w2))
  (gate-nand w1 clk (wire-nand w2 w1))
  (gate-nand w2 w3 data)
  (gate-nand out w1 (wire-nand out w3)))
