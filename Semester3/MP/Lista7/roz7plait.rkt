#lang plait


(define-type (2-3Tree 'a )
  (leaf)
  (2-node (l : (2-3Tree 'a)) (p : (2-3Tree 'a))  (a : 'a))
  (3-node (l : (2-3Tree 'a)) (s : (2-3Tree 'a)) (p : (2-3Tree 'a)) (a : 'a) (b : 'a)))


