#lang racket
(require "tda-station.rkt")
(provide (all-defined-out))

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

(define get-distance
  (lambda (section)
    car(car(cdr(cdr section)))))