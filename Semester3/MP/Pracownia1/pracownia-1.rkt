#lang racket


(provide (struct-out column-info)
         (struct-out table)
         (struct-out and-f)
         (struct-out or-f)
         (struct-out not-f)
         (struct-out eq-f)
         (struct-out eq2-f)
         (struct-out lt-f)
         table-insert
         table-project
         table-sort
         table-select
         table-rename
         table-cross-join
         table-natural-join)

(define-struct column-info (name type) #:transparent)

(define-struct table (schema rows) #:transparent)

(define cities
  (table
   (list (column-info 'city    'string)
         (column-info 'country 'string)
         (column-info 'area    'number)
         (column-info 'capital 'boolean))
   (list (list "Wrocław" "Poland"  293 #f)
         (list "Warsaw"  "Poland"  517 #t)
         (list "Poznań"  "Poland"  262 #f)
         (list "Berlin"  "Germany" 892 #t)
         (list "Munich"  "Germany" 310 #f)
         (list "Paris"   "France"  105 #t)
         (list "Rennes"  "France"   50 #f))))

(define countries
  (table
   (list (column-info 'country 'string)
         (column-info 'population 'number))
   (list (list "Poland" 38)
         (list "Germany" 83)
         (list "France" 67)
         (list "Spain" 47))))

(define (empty-table columns) (table columns '()))

; Wstawianie

;Sprawdzanie typu
(define (check-type val type)
  (cond [(equal? type 'string) (string? val)]
        [(equal? type 'number) (number? val)]
        [(equal? type 'boolean) (boolean? val)]
        [else #f]))

;
(define (valid-row? scheme row)
  (if (or (and (null? scheme) (not (null? row))) (and (not (null? scheme)) (null? row)))
      #f
      (if (and (null? scheme) (null? row))
          #t
          (let ([type (column-info-type (car scheme))]
                [val (car row)])
            (if (check-type val type)
                (valid-row? (cdr scheme) (cdr row))
                #f)))))
        
(define (table-insert row tab)
  (let ([s (table-schema tab)])
    (if (valid-row? s row)
        (append (list row) (table-rows tab))
        (raise(error "cos poszlo nie tak")))))

; Projekcja

(define (table-project cols tab)
  ;; uzupełnij
  )

; Sortowanie

(define (table-sort cols tab)
  ;; uzupełnij
  )

; Selekcja

(define-struct and-f (l r))
(define-struct or-f (l r))
(define-struct not-f (e))
(define-struct eq-f (name val))
(define-struct eq2-f (name name2))
(define-struct lt-f (name val))

(define (table-select form tab)
  ;; uzupełnij
  )

; Zmiana nazwy

(define (table-rename col ncol tab)
  ;; uzupełnij
  )

; Złączenie kartezjańskie

(define (table-cross-join tab1 tab2)
  ;; uzupełnij
  )

; Złączenie

(define (table-natural-join tab1 tab2)
  ;; uzupełnij
  )

