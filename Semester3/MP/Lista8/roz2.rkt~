#lang racket

(provide
 mqueue?
 nonempty-mqueue/c
 (contract-out
  [mqueue-empty? (-> mqueue? boolean?)]
  [mqueue-make   (-> mqueue?)]
  [mqueue-push   (-> mqueue? any/c any/c)]
  [mqueue-push-front   (-> mqueue? any/c any/c)]
  [mqueue-pop    (-> nonempty-mqueue/c any/c)]
  [mqueue-pop-back    (-> nonempty-mqueue/c any/c)]
  [mqueue-peek   (-> nonempty-mqueue/c any/c)]
  [mqueue-peek-back   (-> nonempty-mqueue/c any/c)]))

(struct block
  ([prev #:mutable] [val #:mutable] [next #:mutable]))

(struct mqueue
  ([front #:mutable] [back #:mutable]))

(define (mqueue-empty? q)
  (null? (mqueue-front q)))

(define nonempty-mqueue/c
  (and/c mqueue? (not/c mqueue-empty?)))

(define (mqueue-make)
  (mqueue null null))

(define (mqueue-push q x)
  (define p (block (mqueue-back q) x null))
  (if (mqueue-empty? q)
      (set-mqueue-front! q p)
      (set-block-next! (mqueue-back q) p))
  (set-mqueue-back! q p))

(define (mqueue-push-front q x)
  (define p (block null x (mqueue-front q)))
  (if (mqueue-empty? q)
      (set-mqueue-front! q p)
      (set-block-prev! (mqueue-front q) p))
  (set-mqueue-front! q p))

(define/contract (mqueue-pop q)
  (-> nonempty-mqueue/c any/c)
  (define p (mqueue-front q))
  (set-mqueue-front! q (block-next p))
  (if (mqueue-empty? q)
      (void)
      (set-block-prev! (mqueue-front q) null)))

(define/contract (mqueue-pop-back q)
  (-> nonempty-mqueue/c any/c)
  (define p (mqueue-back q))
  (if (eq? (mqueue-front q) (mqueue-back q))
      (set-mqueue-front! q null)
      (void))
  (set-mqueue-back! q (block-prev p))
  (if (mqueue-empty? q)
      (void)
      (set-block-next! (mqueue-back q) null)))

(define (mqueue-peek q)
  (block-val (mqueue-front q)))

(define (mqueue-peek-back q)
  (block-val (mqueue-back q)))