#lang racket
(require "tda-train.rkt")
(require "tda-driver.rkt")
(require "tda-line.rkt")
(require "tda-section.rkt")

;Dom: id (int) X nombre (string) -> Rec: subway
(define subway
  (lambda(id nombre)
    (list id nombre)))

; emplear algún tipo de recursividad
; IDEA: utilizar definición de list para implementar rf.
; LISTA: (cons (cons (cons... )))
;Dom: sub (subway) X train+ -> Rec: subway
(define subway-add-train
  (lambda(sub . train)
    (cond
      [(null? train) sub]
      [(cons )])))

; no usar recursividad
;Dom: sub (subway) X line+ -> Rec: subway
(define subway-add-line
  (lambda(sub . line)
    (list sub line)))
 
; no usar recursividad
;Dom: sub (subway) X driver+ -> Rec: subway
(define subway-add-driver
  (lambda(sub . driver)
    (list sub driver)))

;Dom: sub (subway) -> string
(define subway->string
  (lambda(sub)
    (string-join (map symbol->string sub) " ")))

(define sw0 (subway 0 "Metro Santiago"))
(define sw1 (subway-add-line sw0 l1))
