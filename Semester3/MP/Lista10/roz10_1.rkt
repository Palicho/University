#lang plait
(require (typed-in racket
                   (apply : ((Number Number -> Number) (Listof Number) -> Number))))
(module+ test
  (print-only-errors #t))

;; abstract syntax -------------------------------

(define-type Op
  (add)
  (sub)
  (mul)
  (div))

(define-type Exp
  (numE [n : Number])
  (opE [op : Op] [es : (Listof Exp)]))

;; parse ----------------------------------------

(define (parse [s : S-Exp]) : Exp
  (cond
    [(s-exp-match? `NUMBER s)
     (numE (s-exp->number s))]
    [(s-exp-match? `{SYMBOL ANY ...} s)
     (opE (parse-op (s-exp->symbol (first (s-exp->list s))))
          (parse-many (rest (s-exp->list s)) '() ))]
    [else (error 'parse  "invalid input")]))

(define (parse-many [ss : (Listof S-Exp)] [acc : (Listof Exp)]) : (Listof Exp)
  (if  (empty? ss)
       acc
       (cons (parse (first  ss)) (parse-many (rest ss) acc))))
  

(define (parse-op [op : Symbol]) : Op
  (cond
    [(eq? op '+) (add)]
    [(eq? op '-) (sub)]
    [(eq? op '*) (mul)]
    [(eq? op '/) (div)]
    [else (error 'parse "unknown operator")]))


(define-type-alias Value Number)

(define (op->proc [op : Op]) : (Value Value -> Value)
  (type-case Op op
    [(add) +]
    [(sub) -]
    [(mul) *]
    [(div) /]))

(define (eval [e : Exp]) : Value
  (type-case Exp e
    [(numE n) n]
    [(opE o es) (apply (op->proc o) (list-eval es '()))]))

(define (list-eval [es : (Listof Exp )] [acc : (Listof Value)]) : (Listof Value)
  (if (empty? es)
      acc
      (list-eval (rest es) (append acc (list (eval (first es)))))))
    
    
(define (run [e : S-Exp]) : Value
  (eval (parse e)))

(module+ test
  (test (run `2)
        2)
  (test (run `{+ 2 1})
        3)
  (test (run `{* 2 1})
        2)
  (test (run `{+ {* 2 3} {+ 5 8}})
        19))

;; printer ———————————————————————————————————-

(define (print-value [v : Value]) : Void
  (display v))

(define (main [e : S-Exp]) : Void
  (print-value (eval (parse e))))



