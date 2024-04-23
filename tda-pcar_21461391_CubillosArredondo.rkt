#lang racket
(provide (all-defined-out))

; Implementación de tipo de carro
; Uso string para dar mas detalle a los tipos.
(define car-type
  (lambda(car-type)
    car-type))

(define ct (car-type "central"))
(define tr (car-type "terminal"))

;Dom: id (int) X capacity (positive integer) X model (string) X type (car-type) -> Rec: pcar
(define pcar
  (lambda (id capacity model type)
    (list id capacity model type)))

(define pc0 (pcar 0 100 "NS-74" ct))

; Dom: pcar -> Rec: id (int)
(define get-pcar-id
  (lambda(pcar)
    (car pcar)))

; Dom: pcar -> Rec: pcar-type
(define get-pcar-type
  (lambda(pcar)
    (cdddr pcar)))

; Dom: pcar -> Rec: capacity (int)
(define get-pcar-capacity
  (lambda (pcar)
    (cond
      [(null? pcar) 0]
      [else (car(cdr pcar))])))
