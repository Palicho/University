#lang racket
(define frac (stream-cons 1 (map2 * frac (integers-from 1))))

(define (part-sum s) (stream-cons (stream-car s) (map2 + (part-sum s) (stream-cdr s))))

(define (scale n xs)
  (stream-cons
   (* n (stream-car xs))
   (scale n (stream-cdr xs))))

(define (merge xs ys)
  (cond [(= (stream-car xs) (stream-car ys))
         (stream-cons (stream-car xs) (merge (stream-cdr xs) (stream-cdr ys)))]
        [(< (stream-car xs) (stream-car ys))
         (stream-cons (stream-car xs) (merge (stream-cdr xs) ys))]
        [else
         (stream-cons (stream-car ys) (merge xs (stream-cdr ys)))]))


(define S (stream-cons 1 (merge (scale 5 S) (merge (scale 2 S) (scale 3 S)))))

(define (eval [e : Exp] [env : Env]) : Value
  (type-case Exp e
    [(numE n) (numV n)]
    [(ifE b l r)
     (type-case Value (eval b env)
       [(boolV v)
        (if v (eval l env) (eval r env))]
       [else
        (error 'eval "type error")])]
    [(varE x)
     (lookup-env x env)]
    [(letE x e1 e2)
     (let ([v1 (eval e1 env)])
       (eval e2 (extend-env env x v1)))]
    [(lamE x b)
     (funV x b env)]
    [(appE e1 e2)
     (apply (eval e1 env) (eval e2 env))]
    [(whileE e1 e2)
     (type-case Value (eval e1 env)
       [(boolV b)
        (if b
            (eval (beginE e2 (whileE e1 e2)) env)
            (voidV))]
       [else (error 'eval "not bool")])]
    [(letrecE x e1 e2)
     (let* ([new-env (extend-env-undef env x)]
            [v1 (eval e1 new-env)])
       (begin (update-env! new-env x v1) 
              (eval e2 new-env)))]
    [(beginE e1 e2)
     (begin (eval e1 env)
            (eval e2 env))]
    [(setE x e0)
     (begin 
       (update-env! env x (eval e0 env))
       (voidV))]))
