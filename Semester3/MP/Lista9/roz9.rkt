#lang racket
(require "syntax.rkt")
(require (only-in plait s-exp-content))
(provide parse-exp)

(struct parse-ok (elems rest))

(define (parse-with-rule grammar rule toks)
  (match rule
    ['() (parse-ok '() toks)]
    [(cons item rule)
     (match (parse-item grammar item toks)
       [(parse-ok xs1 toks)
        (match (parse-with-rule grammar rule toks)
          [(parse-ok xs2 toks)
           (parse-ok (append xs1 xs2) toks)]
          [#f #f])]
       [#f #f])]))

(define (parse-item grammar item toks)
  (cond
    [(eq? item 'ANY)    (parse-token (lambda (x) #t) toks)]
    [(eq? item 'NUMBER) (parse-token number? toks)]
    [(eq? item 'SYMBOL) (parse-token symbol? toks)]
    [(symbol? item)
     (if (and (cons? toks) (eq? (car toks) item))
         (parse-ok '() (cdr toks))
         #f)]
    [(list? item)
     (if (and (cons? toks) (list? (car toks)))
         (match (parse-with-rule grammar item (car toks))
           [(parse-ok xs '()) (parse-ok xs (cdr toks))]
           [(parse-ok xs toks) #f]
           [#f #f])
         #f)]
    [(string? item)
     (match (parse-nonterminal grammar item toks)
       [(parse-ok x toks) (parse-ok (list x) toks)]
       [#f #f])]))

(define (parse-token p? toks)
  (if (and (cons? toks) (p? (car toks)))
      (parse-ok (list (car toks)) (cdr toks))
       #f))

(define (parse-nonterminal grammar name toks)
  (define def (assoc name grammar))
  (if def
      (parse-with-rules grammar (cdr def) toks)
      (error "Undefined nonterminal: " name)))

(define (parse-with-rules grammar rules toks)
  (match rules
    ['() #f]
    [(cons (list rule action) rules)
     (match (parse-with-rule grammar rule toks)
       [(parse-ok xs toks) (parse-ok (apply action xs) toks)]
       [#f (parse-with-rules grammar rules toks)])]))

(define (run-named-parser grammar name toks)
  (match (parse-nonterminal grammar name toks)
    [(parse-ok x '()) x]
    [else             (error "Syntax error")]))

; ====================================================
; Gramatyki bezkontekstowe

; * Terminale (tokeny)
; * Nieterminale (np. "expression", "operator")
; * Lista produkcji:
;   "expression" -> NUMBER
;   "expression" -> "expression" "operator" "expression"
;
;   "operator" -> +
;   "operator" -> -
;   "operator" -> *
;   "operator" -> /

; 2 + 2 + 2

; "expression" -> "expression" "add-operator" "mult-exp"
; "expression" -> "mult-exp"
; "mult-exp"   -> "mult-exp" "mult-operator" "atom-exp"
; "mult-exp"   -> "atom-exp"
; "atom-exp"   -> NUMBER
; "atom-exp"   -> ( "expression" )


; "expression" -> "pow-expr-rest" "pow-expr"
; "pow-expr-rest" -> NIL
; "pow-expr-rest" -> "pow-operator" "pow-expr" "pow-expr-rest"
; "pow-expr" -> "mult-expr" "expr-rest"
; "expr-rest" -> "add-operator" "mult-expr" "expr-rest"
; "expr-rest" -> NIL
; "mult-expr" -> "simple-expr" "mult-expr-rest"
; "mult-expr-rest" -> "mult-operator" "simple-expr" "mult-expr-rest"
; "mult-expr-rest" -> NIL
; "simple-expr" -> NUMBER
; "simple-expr" -> "expression"

; ====================================================

; DSL

; (e1 + e2) ....

(define (build-expr e1 xs)
  (match xs
    ['() e1]
    [(cons (cons op e2) xs)
     (build-expr (exp-op op e1 e2) xs)]))
    
    
(define ^ expt)

(define grammar
  `(("add-operator"
     ((+) ,op-add)
     ((-) ,op-sub))

    ("mult-operator"
     ((*) ,op-mul)
     ((/) ,op-div))
     
    ("pow-operator"
    ((^) ,op-pow))
     
    
    ("expression"
    (("pow-rest-expr" "pow-expr")  ,(lambda (f e1) (f e1))))
    
    ("pow-rest-expr"
     (("pow-operator" "pow-expr" "pow-expr-rest") 
                         ,(lambda (op e2 f) (lambda (e1)
                              (f (exp-op op e1 e2)))))
      (() ,(lambda () (lambda (e) e))))
    
    ("pow-expr"
     (("mult-expr" "expr-rest")
          ,(lambda (e1 f) (f e1))))

    ("expr-rest"
     (("add-operator" "mult-expr" "expr-rest")
         ,(lambda (op e2 f) (lambda (e1)
                              (f (exp-op op e1 e2)))))
     (() ,(lambda () (lambda (e) e))))

    ("mult-expr"
     (("simple-expr" "mult-expr-rest")
         ,(lambda (e1 f) (f e1))))

    ("mult-expr-rest"
     (("mult-operator" "simple-expr" "mult-expr-rest")
         ,(lambda (op e2 f) (lambda (e1)
                              (f (exp-op op e1 e2)))))
     (() ,(lambda () (lambda (e) e))))
    
    ("simple-expr"
     ((NUMBER)           ,exp-number)
     (( ("expression") ) ,(lambda (e) e)))))

(define (run-exp-parser se)
  (run-named-parser grammar "expression" (list se)))

(define (parse-exp se)
  (run-exp-parser (s-exp-content se)))