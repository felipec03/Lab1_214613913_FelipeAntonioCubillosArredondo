#lang racket
(provide c)
(provide t)

(provide pcar)
(provide get-pcar-type)
(provide get-pcar-capacity)

; Implementación de tipo de carro
; Uso string para dar mas detalle a los tipos.
(define car-type
  (lambda(car-type)
    (list car-type)))

(define c (car-type "central"))
(define t (car-type "terminal"))

;Dom: id (int) X capacity (positive integer) X model (string) X type (car-type) -> Rec: pcar
(define pcar
  (lambda (id capacity model type)
    (list id capacity model type)))

(define pc0 (pcar 0 100 "NS-74" c))

(define get-pcar-type
  (lambda(pcar)
    (car(car (cdddr pcar)))))

(define get-pcar-capacity
  (lambda (pcar)
    (cond
      [(null? pcar) 0]
      [else (car(cdr pcar))])
    ))