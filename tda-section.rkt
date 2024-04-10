#lang racket
(require "tda-station.rkt")
(provide section)
(provide get-cost)
(provide get-length)

; Dom: point1 (station)  X point2 (station) X distance (positive-number) X cost (positive-number U {0}) -> Rec: section
(define section
  (lambda (point1 point2 distance cost)
    (cond
      [(equal? (get-station-type point1) "combinacion")(list point1 point2 (abs distance) (abs cost))]
      [(equal? (get-station-type point2) "combinacion")(list point1 point2 (abs distance) (abs cost))]
      [(equal? (get-station-type point1) "regular")(list point1 point2 (abs distance) (abs cost))]
      [(equal? (get-station-type point1) "regular")(list point1 point2 (abs distance) (abs cost))]
      [else null]
    )))

(define get-cost
  (lambda (section)
    car(car(cdr(cdr(cdr section))))))

(define get-length
  (lambda (section)
    car(car(cdr(cdr section)))))

(define e0 (station 1 "los heroes" c 10))
(define e1 (station 2 "republica" r 10))
(define e2 (station 3 "ula" r 10))
(define e3 (station 4 "estacion central" r 10))
(define e4 (station 5 "error station" m 10))

(define s0 (section e0 e1 100 230))
(define s1 (section e1 e2 100 230))
(define s2 (section e2 e3 100 230))
(define s3 (section e3 e4 100 230))