#lang plait

(module+ test
  (print-only-errors #t))

;; abstract syntax -------------------------------

(define-type Exp
  (numE [n : Number])
  (ifE [b : Exp] [l : Exp] [r : Exp])
  (varE [x : Symbol])
  (letE [x : Symbol] [e1 : Exp] [e2 : Exp])
  (lamE [x : Symbol] [e : Exp])
  (appE [e1 : Exp] [e2 : Exp])
  (letrecE [x : Symbol] [e1 : Exp] [e2 : Exp])
  (beginE [e1 : Exp] [e2 : Exp])
  (setE [x : Symbol] [e : Exp]))

;; parse ----------------------------------------

(define (parse [s : S-Exp]) : Exp
  (cond
    [(s-exp-match? `NUMBER s)
     (numE (s-exp->number s))]
    [(s-exp-match? `{lambda {SYMBOL} ANY} s)
     (lamE (s-exp->symbol
            (first (s-exp->list 
                    (second (s-exp->list s)))))
           (parse (third (s-exp->list s))))]
    [(s-exp-match? `{if ANY ANY ANY} s)
     (ifE (parse (second (s-exp->list s)))
          (parse (third (s-exp->list s)))
          (parse (fourth (s-exp->list s))))]
    [(s-exp-match? `SYMBOL s)
     (varE (s-exp->symbol s))]
    [(s-exp-match? `{let SYMBOL ANY ANY} s)
     (letE (s-exp->symbol (second (s-exp->list s)))
           (parse (third (s-exp->list s)))
           (parse (fourth (s-exp->list s))))]
    [(s-exp-match? `{begin ANY ANY} s)
     (beginE(parse (second (s-exp->list s)))
            (parse (third (s-exp->list s))))]
    [(s-exp-match? `{set! SYMBOL ANY} s)
     (setE (s-exp->symbol (second (s-exp->list s)))
           (parse (third (s-exp->list s))))]
    [(s-exp-match? `{letrec SYMBOL ANY ANY} s)
     (letrecE (s-exp->symbol (second (s-exp->list s)))
              (parse (third (s-exp->list s)))
              (parse (fourth (s-exp->list s))))]
    [(s-exp-match? `{SYMBOL ANY ANY} s)
     (appE (appE (varE (parse-op (s-exp->symbol (first (s-exp->list s)))))
                 (parse (second (s-exp->list s))))
           (parse (third (s-exp->list s))))]
    [(s-exp-match? `{ANY ANY} s)
     (appE (parse (first (s-exp->list s)))
           (parse (second (s-exp->list s))))]
    [else (error 'parse "invalid input")]))

(define prim-ops '(+ - * / = <=))

(define (parse-op [op : Symbol]) : Symbol
  (if (member op prim-ops)
      op 
      (error 'parse "unknown operator")))

(module+ test
  (test (parse `2)
        (numE 2))
  (test (parse `2)
        (numE 2))
  (test (parse `{+ 2 1})
        (appE (appE (varE '+) (numE 2)) (numE 1)))
  (test (parse `{* 3 4})
        (appE (appE (varE '*) (numE 3)) (numE 4)))
  (test/exn (parse `{{+ 1 2}})
            "invalid input")
  (test (parse `{+ 1})
        (appE (varE '+) (numE 1)))
  (test/exn (parse `{^ 1 2})
            "unknown operator")
  (test (parse `{lambda {x} 9})
        (lamE 'x (numE 9)))
  (test (parse `{double 9})
        (appE (varE 'double) (numE 9))))

;; eval --------------------------------------

;; values

(define-type Value
  (numV [n : Number])
  (boolV [b : Boolean])
  (funV [x : Symbol] [e : Exp] [env : Env])
  (primopV [f : (Value -> Value)])
  (voidV))

;; environments

(define-type Storable
  (valS [v : Value])
  (undefS))

(define-type Binding
  (bind [name : Symbol]
        [ref : (Boxof Storable)]))

(define-type-alias Env (Listof Binding))

(define mt-env empty)

(define (extend-env-undef [env : Env] [x : Symbol]) : Env
  (cons (bind x (box (undefS))) env))

(define (extend-env [env : Env] [x : Symbol] [v : Value]) : Env
  (cons (bind x (box (valS v))) env))

(define (find-var [env : Env] [x : Symbol]) : (Boxof Storable)
  (type-case (Listof Binding) env
    [empty (error 'lookup "unbound variable")]
    [(cons b rst-env) (cond
                        [(eq? x (bind-name b))
                         (bind-ref b)]
                        [else
                         (find-var rst-env x)])]))
  
(define (lookup-env [x : Symbol] [env : Env]) : Value
  (type-case Storable (unbox (find-var env x))
    [(valS v) v]
    [(undefS) (error 'lookup-env "undefined object")]))
   
(define (update-env! [env : Env] [x : Symbol] [v : Value]) : Void
  (set-box! (find-var env x) (valS v)))


;; primitive operations

(define (op-num-num->value [f : (Number Number -> Number)]) : Value 
  (primopV
   (λ (v1)
     (type-case Value v1
       [(numV n1)
        (primopV
         (λ (v2)
           (type-case Value v2
             [(numV n2)
              (numV (f n1 n2))]
             [else
              (error 'eval "type error")])))]
       [else
        (error 'eval "type error")]))))

(define (op-num-bool->value [f : (Number Number -> Boolean)]) : Value 
  (primopV
   (λ (v1)
     (type-case Value v1
       [(numV n1)
        (primopV
         (λ (v2)
           (type-case Value v2
             [(numV n2)
              (boolV (f n1 n2))]
             [else
              (error 'eval "type error")])))]
       [else
        (error 'eval "type error")]))))

(define init-env 
  (foldr (λ (b env) (extend-env env (fst b) (snd b)))
         mt-env 
         (list (pair '+ (op-num-num->value +))
               (pair '- (op-num-num->value -))
               (pair '* (op-num-num->value *))
               (pair '/ (op-num-num->value /))
               (pair '= (op-num-bool->value =))
               (pair '<= (op-num-bool->value <=)))))

;; evaluation function (eval/apply)

(define (eval [e : Exp] [env : Env] [k : (Value -> 'a)]) : 'a
  (type-case Exp e
    [(numE n)
     (k (numV n))]
    [(ifE b l r)
     (eval b env
           (λ (u)
             (type-case Value u 
               [(boolV v)
                (if v (eval l env k) (eval r env k))]
               [else
                (error 'eval "type error")])))]
    [(varE x)
     (k (lookup-env x env))]
    [(letE x e1 e2)
     (eval e1 env
           (λ (v1)
             (eval e2 (extend-env env x v1) k)))]
    [(lamE x b)
     (k (funV x b env))]
    [(setE x e)
     (begin
       (update-env! env x (eval e env (λ (x) x)))
       (k (voidV)))]
    [(beginE e1 e2)
     (begin
       (eval e1 env k)
       (eval e2 env k))]
    [(appE e1 e2)
     (eval e1 env
           (λ (v1)
             (eval e2 env
                   (λ (v2)
                     (apply v1 v2 k)))))]
    [(letrecE x e1 e2)
     (let ([new-env (extend-env-undef env x)])
       (eval e1 new-env
             (λ (v1)
               (begin (update-env! new-env x v1) 
                      (eval e2 new-env k)))))]))

(define (apply [v1 : Value] [v2 : Value] [k : (Value -> 'a)]) : 'a
  (type-case Value v1
    [(funV x b env)
     (eval b (extend-env env x v2) k)]
    [(primopV f)
     (k (f v2))]
    [else (error 'apply "not a function")]))

(define (run [e : S-Exp]) : Value
  (eval (parse e) init-env (λ (v) v)))

(module+ test
  (test (run `2)
        (numV 2))
  (test (run `{+ 2 1})
        (numV 3))
  (test (run `{* 2 1})
        (numV 2))
  (test (run `{+ {* 2 3} {+ 5 8}})
        (numV 19))
  (test (run `{= 0 1})
        (boolV #f))
  (test (run `{if {= 0 1} {* 3 4} 8})
        (numV 8))
  (test (run `{let x 1 {+ x 1}})
        (numV 2))
  (test (run `{let x 1 {+ x {let y 2 {* x y}}}})
        (numV 3))
  (test (run `{let x 1
                {+ x {let x {+ x 1}
                       {* x 3}}}})
        (numV 7))
  (test (run `{{lambda {x} {+ x 1}} 5})
        (numV 6))
  (test (run `{letrec fact {lambda {n}
                             {if {= n 0}
                                 1
                                 {* n {fact {- n 1}}}}}
                {fact 5}})
        (numV 120)))

;; printer ———————————————————————————————————-

(define (value->string [v : Value]) : String
  (type-case Value v
    [(numV n) (to-string n)]
    [(boolV b) (if b "true" "false")]
    [(funV x e env) "#<procedure>"]
    [(primopV f) "#<primop>"]
    [(voidV) ....]))

(define (print-value [v : Value]) : Void
  (display (value->string v)))

(define (main [e : S-Exp]) : Void
  (eval (parse e) mt-env print-value))