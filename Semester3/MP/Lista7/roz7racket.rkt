#lang racket

; [zad 3]

(define/contract (suffixes xs)
  (parametric->/c [a] (-> (listof a) (listof (listof a))))
  (if (null? xs)
      '(())
      (cons xs (suffixes (cdr xs)))))

; [zad 4]

( define/contract (sublists xs)
   (parametric->/c [a] (-> (listof a) (listof (listof a))))
   ( if ( null? xs )
        ( list null )
        ( append-map
          ( lambda ( ys ) ( list ( cons ( car xs ) ys ) ys ) )
          ( sublists ( cdr xs )))))

; [zad 5 ]

(define/contract (out num pos)
  ( parametric->/c [ a b ] (-> a b a ) )  
  num)


;[ zad 6]
   ( define/contract ( foldl-map f a xs )
      (parametric->/c [a b c] (-> (-> a b (cons/c c b)) b (listof a) (cons/c (listof c) b))) 
      ( define ( it a xs ys )
         ( if ( null? xs )
              ( cons ( reverse ys ) a )
              ( let [( p ( f ( car xs ) a ) ) ]
                 ( it ( cdr p )
                      ( cdr xs )
                      ( cons ( car p ) ys ) ) ) ) )
      ( it a xs null ) )
      
             


