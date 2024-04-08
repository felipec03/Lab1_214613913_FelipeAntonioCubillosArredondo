#lang racket
; Implementación de tipo de estación
; Uso string para dar mas detalle a los tipos.
(provide station)
(provide get-station-type)
(provide c)
(provide r)
(provide m)
(provide t)

(define station-type
  (lambda (type-name)
    (list type-name)))

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
    (car(car(cdr (cdr station))))))

(define e0 (station 1 "los heroes" c 10))
(define e2 (station 2 "error estation" c 0))