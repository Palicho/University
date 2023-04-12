#lang plait

; [zad 1 ]

; P (xs) := (map f (map g xs)) ≡ (map ( λ (x) (f (g x)) xs)

; i)
; P(empty)
; L ≡ (map f (g empty)) ≡ (f ( g empty))
; R ≡ (map ( λ ( x ) (f (g x)) empty) ≡ ( f ( g empty))

; ii) 
;     


( define-type ( NNF 'v )
   ( nnf-lit [ polarity : Boolean ] [ var : 'v ])
   ( nnf-conj [ l : ( NNF 'v ) ] [ r : ( NNF 'v ) ])
   ( nnf-disj [ l : ( NNF 'v ) ] [ r : ( NNF 'v ) ]) )



;[ Zad 4* ]

(define (neg-nnf a)
  (cond [(nnf-lit? a)  (nnf-lit (not (nnf-lit-polarity a)) (nnf-lit-var a))]
        [(nnf-conj? a) (nnf-disj (neg-nnf (nnf-conj-l a)) (neg-nnf (nnf-conj-r a)))]
        [(nnf-disj? a) (nnf-conj (neg-nnf (nnf-disj-l a)) (neg-nnf (nnf-disj-r a)))]))

;[ Zad 3 ]

(define (implication p q)
  (nnf-disj (neg-nnf p) q))

;[ Zad 5 ]

(define (eval-nnf f  nnf)
  (cond [(nnf-lit? nnf)
         (if (nnf-lit-polarity nnf)
             (not ( f (nnf-lit-var nnf)))
             (f (nnf-lit-var nnf)))]
        [(nnf-conj? nnf) (and ( eval-nnf f (nnf-conj-l nnf)) (eval-nnf f (nnf-conj-r nnf)))]
        [(nnf-disj? nnf) (or ( eval-nnf f (nnf-disj-l nnf)) (eval-nnf f (nnf-disj-r nnf)))]))


;[ Zad 6 ]

( define-type ( Formula 'v )
( var [ var : 'v ])
( neg [ f : ( Formula 'v ) ])
( conj [ l : ( Formula 'v ) ] [ r : ( Formula 'v ) ])
( disj [ l : ( Formula 'v ) ] [ r : ( Formula 'v ) ]) )

(define (to-nnf f)
  (cond [(var? f) (nnf-lit #f (var-var f))]
        [(neg? f) (neg-nnf (to-nnf (neg-f f)))]
        [(conj? f) (nnf-conj (to-nnf (conj-l f)) (to-nnf (conj-r f)))]
        [(disj? f) (nnf-disj (to-nnf (disj-l f)) (to-nnf (disj-r f)))]))

;[ Zad 7 ]


(define (eval-formula f formula)
  (cond [(var? formula)  (f (var-var formula))]
        [(neg? formula)  (not (eval-formula f (neg-f formula)))]
        [(conj? formula) (and  (eval-formula f (conj-l formula))  (eval-formula f (conj-r formula)))]
        [(disj? formula) (or (eval-formula f (disj-l formula))  (eval-formula f (disj-r formula))) ]))

;[ Zad 8 ]

