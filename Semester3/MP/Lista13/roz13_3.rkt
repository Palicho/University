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
  (beginE [e1 : Exp] [e2 : Exp])
  (boxE [s : Symbol])
  (unboxE [s : Symbol])
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
    [(s-exp-match? `{SYMBOL ANY ANY} s)
     (appE (appE (varE (parse-op (s-exp->symbol (first (s-exp->list s)))))
                 (parse (second (s-exp->list s))))
           (parse (third (s-exp->list s))))]
    [(s-exp-match? `{box ANY} s)
     (boxE (s-exp->symbol (second (s-exp->list s))))]
    [(s-exp-match? `{unbox ANY} s)
     (unboxE (s-exp->symbol (second (s-exp->list s))))]
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
  (boxV [l : Location])
  (voidV))

;; storage (heap)

(define-type Storable
  (valS [v : Value])
  (undefS))

(define-type-alias Storage (Listof Storable))
(define-type-alias Location Number)

(define mt-sto : Storage empty)
(define (alloc-sto [sto : Storage] [u : Storable]) : (Location * Storage)
  (let ([next-free (length sto)])
    (pair next-free
          (append sto (list u)))))
(define (deref-sto [sto : Storage] [l : Location]) : Value
  (if (<= l (- (length sto) 1))
      (type-case Storable (list-ref sto l)
        [(valS v) v]
        [(undefS) (error 'lookup-env "undefined object")])
      (error 'deref "unknown location")))
(define (update-sto [sto : Storage] [l : Location] [u : Storable]) : Storage
  (local
    ((define (walk sto l)
       (if (= l 0)
           (cons u (rest sto))
           (cons (first sto)
                 (walk (rest sto) (- l 1))))))
    (if (<= l (- (length sto) 1))
        (walk sto l)
        (error 'deref "unknown location"))))

;; environments

(define-type Binding
  (bind [name : Symbol]
        [v : Value]))

(define-type-alias Env (Listof Binding))

(define mt-env empty)
(define (extend-env [env : Env] [x : Symbol] [r : Value]) : Env
  (cons (bind x r) env))
(define (lookup-env [env : Env] [x : Symbol]) : Value
  (type-case Env env
    [empty
     (error 'lookup-env "unbound variable")]
    [(cons b rst-env)
     (cond
       [(eq? x (bind-name b))
        (bind-v b)]
       [else
        (lookup-env rst-env x)])]))
  
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

(define (prim-op->value op)
  (cond [(eq? op '+) (op-num-num->value +)]
        [(eq? op '-) (op-num-num->value -)]
        [(eq? op '*) (op-num-num->value *)]
        [(eq? op '/) (op-num-num->value /)]
        [(eq? op '=) (op-num-bool->value =)]
        [(eq? op '<=) (op-num-bool->value <=)]))
 
(define init-env-sto
  (pair 
   (foldr (λ (b env) (extend-env env (fst b) (snd b)))
          mt-env 
          (list (pair '+ (op-num-num->value +))
                (pair '- (op-num-num->value -))
                (pair '* (op-num-num->value *))
                (pair '/ (op-num-num->value /))
                (pair '= (op-num-bool->value =))
                (pair '<= (op-num-bool->value <=))))
   mt-sto))

;; evaluation function (eval/apply)

(define-type Answer
  (v*s [v : Value] [s : Storage] [e : Env]))

(define-syntax-rule
  (with [(val sto env) call]
        body)
  (type-case Answer call
    [(v*s val sto env) body]))

(define (eval [e : Exp] [env : Env] [sto : Storage]) : Answer
  (type-case Exp e
    [(numE n)
     (v*s (numV n) sto env)]
    [(ifE b l r)
     (with [(v sto0 env0) (eval b env sto)]
           (type-case Value v
             [(boolV v0)
              (if v0 (eval l env sto0) (eval r env sto0))]
             [else
              (error 'eval "type error")]))]
    [(varE x)
     (let ([v (lookup-env env x)])
       (v*s v sto env))]
    [(letE x e1 e2)
     (let ([v1 (eval e1 env sto)])
       (eval e2 (extend-env env x (v*s-v v1)) (v*s-s v1)))]
    [(lamE x b)
     (v*s (funV x b env) sto env)]
    [(appE e1 e2)
     (with [(v1 sto1 env1) (eval e1 env sto)]
           (with [(v2 sto2 env2) (eval e2 env sto1)]
                 (apply v1 v2 sto2 env)))]
    [(boxE e)
     (let* ([l*s (alloc-sto sto (undefS))]
            [env1 (extend-env env e (boxV (fst l*s)))])
       (v*s (voidV) (snd l*s) env1))]
    [(unboxE e)
     (type-case Value (lookup-env env e)
       [(boxV l) (v*s (deref-sto sto l) sto env)]
       [else (error 'eval "unboxE")])]
    [(beginE e1 e2)
     (with [(v1 sto1 env1) (eval e1 env sto)]
           (eval e2 env1 sto1))]
    [(setE x e0)
     (with [(v0 sto0 env0) (eval e0 env sto)]
           (type-case Value (lookup-env env0 x)
             [(boxV l) 
              (let ([sto1 (update-sto sto0 l (valS v0))])
                (v*s (voidV) sto1 env0))]
             [else (error 'eval "setE")]))]))

(define (apply [v1 : Value] [v2 : Value] [sto : Storage] [e : Env]) : Answer
  (type-case Value v1
    [(funV x b env)
     (eval b (extend-env env x v2) sto)]
    [(primopV f)
     (v*s (f v2) sto e)]
    [else (error 'apply "not a function")]))

(define (run [e : S-Exp]) : Value
  (with [(v sto env)
         (eval (parse e) (fst init-env-sto) (snd init-env-sto))]
        v))

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
        (numV 6)))

;; printer ———————————————————————————————————-

(define (value->string [v : Value]) : String
  (type-case Value v
    [(numV n) (to-string n)]
    [(boolV b) (if b "true" "false")]
    [(funV x e env) "#<procedure>"]
    [(primopV f) "#<primop>"]
    [(boxV v) ....]
    [(voidV) ""]))

(define (print-value [v : Value]) : Void
  (display (value->string v)))

(define (main [e : S-Exp]) : Void
  (with [(v sto env)
         (eval (parse e) (fst init-env-sto) (snd init-env-sto))]
        (print-value v)))