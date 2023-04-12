#lang racket
(define (get-i i xs)
  (if (= i 0)
      (first xs)
      (get-i (- i 1) (rest xs))))

(define (encode [e : ExpA] [lst : (Listof Symbol)]) : Exp
  (type-case ExpA e
    [(numA n)
     (numE n)]
    [(opA o l r)
     (opE o (encode l lst) (encode r lst))]
    [(ifA b l r)
     (ifE (encode b lst)
          (encode l lst)
          (encode r lst))]
    [(varA x)
     (varE (get-i x lst))]
    [(letA x e)
     (let ([s (gensym)])
       (letE s
             (encode x lst)
             (encode e (cons s lst))))]))