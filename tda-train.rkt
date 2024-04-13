#lang racket
(require "tda-pcar.rkt")

(provide (all-defined-out))

; El constructor permite determinar si el ensamblado de carros es correcto en base a la compatibilidad de
; estos según modelo y la coherencia de orden (i.e., tren con carros terminales en los extremos t-c-c-c-t).
; El órden de los carros se determina en base al orden de entrada.

;[(and (equal? (get-pcar-type(get-first-pcar train)) "terminal") (equal? (get-pcar-type(get-last-pcar train)) "terminal")) null]

; Dom: id (int) X maker (string) X rail-type (string) X speed (positive number) X station-stay-time (positive number U {0}) X pcar -> Rec: train
(define train
  (lambda (id maker rail-type speed station-stay-time . pcars)
    (cond
      [(not (positive? speed)) null]
      [else (list id maker rail-type speed (abs station-stay-time) pcars)])))

; Capa Getters 
; Dom: train -> Rec: pcar
(define get-first-pcar
  (lambda (train)
    (car(car(cddddr(cdr train))))))

; Dom: train -> Rec: pcar
(define get-last-pcar
  (lambda (train)
    (car(reverse(car(cdr(cddddr t1)))))))

; Dom: train -> Rec: list (pcar)
(define get-pcar-list
  (lambda(train)
    (car(reverse train))))

; Requisitos Funcionales
; Dom: train (train) X pcar (pcar) X position (positive-integer U {0}) -> Rec: train
; se debe usar recursividad
(define aux-train-add-car
  (lambda(pcar-list pcar position auxnum auxpair)
    (cond
      [(= position auxnum) (cons auxpair (cons pcar pcar-list))]
      [(aux-train-add-car (cdr pcar-list) pcar position (+ auxnum 1) (cons auxpair (car pcar-list)))])))

(define train-add-car
  (lambda(train pcar position)
    (aux-train-add-car (get-pcar-list train) pcar position 0 '())))

; Dom: train (train) X pcar (pcar) X position (positive-integer U {0}) -> Rec: train
; se debe usar recursividad
(define train-remove-car
  (lambda(train position)
    train))

; Dom: train -> Rec: boolean
; se debe usar recursividad
(define train?
  (lambda(train)
    #t))

; Alguna recursividad; en este caso, natural.
; Dom: train -> Rec: positive-number U {0}
(define separate-train-capacity
  (lambda (train-car-list)
    (cond
      [(null? train-car-list)  0]
      [else (+ (get-pcar-capacity(car train-car-list)) (separate-train-capacity (cdr train-car-list)))])))

; Función auxiliar llamada con getter.
(define train-capacity
  (lambda(train)
    (separate-train-capacity (get-pcar-list train))))


(define pc0 (pcar 0 100 "NS-74" ct))
(define pc1 (pcar 1 100 "NS-74" tr))
(define pc2 (pcar 2 150 "NS-74" tr))
(define pc3 (pcar 3 100 "NS-74" ct))
(define pc4 (pcar 4 100 "AS-2014" ct))
(define pc5 (pcar 5 120 "AS-2014" ct))


(define t1 (train 1 "CAF" "UIC 60 ASCE" 70 2 pc1 pc0 pc3 pc2 pc4))

(train-add-car t1 pc5 )