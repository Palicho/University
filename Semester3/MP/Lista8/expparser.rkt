#lang racket

(provide parse-exp)

(define grammar
  `(("operator"
     ((+) ,op-add)
     ((-) ,op-sub)
     ((*) ,op-mul)
     ((/) ,op-div))
    
    ("expression"
     (("simple-expr" "operator" "simple-expr")
          ,(lambda (e1 op e2) (exp-op op e1 e2)))
     (("simple-expr") ,(lambda (e) e)))
    
    ("simple-expr"
     ((NUMBER)           ,exp-number)
     (( ("expression") ) ,(lambda (e) e)))))


(define (run-exp-parser se)
  (run-named-parser grammar "expression" (list se)))


(define (parse-exp se)
  (run-exp-parser (s-exp-content se)))