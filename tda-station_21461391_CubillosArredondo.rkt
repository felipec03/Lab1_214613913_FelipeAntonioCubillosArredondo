#lang racket
; Implementación de tipo de estación
; Uso string para dar mas detalle a los tipos.
(provide (all-defined-out))

(define station-type
  (lambda (type-name)
    type-name))

(define c (station-type "combinacion"))
(define r (station-type "regular"))
(define m (station-type "mantención"))
(define t (station-type "terminal"))

;Dom: id (int) X name (String)  X type (station-type) X stop-time (positive integer) -> Rec: station
(define station
  (lambda (id name type stop-time)
    (cond
      [(zero? stop-time) null]
      [else (list id name type (abs stop-time))])))

(define get-station-type
  (lambda(station)
    (car(cdr (cdr station)))))