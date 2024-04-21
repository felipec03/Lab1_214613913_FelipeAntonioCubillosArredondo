#lang racket
(require "tda-train_21461391_CubillosArredondo.rkt")
(require "tda-driver_21461391_CubillosArredondo.rkt")
(require "tda-line_21461391_CubillosArredondo.rkt")

;Dom: id (int) X nombre (string) -> Rec: subway
(define subway
  (lambda(id nombre)
    (list id nombre null null null)))

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

; Dom: sub (subway) X function -> Rec: subway
(define subway-rise-section-cost
  (lambda(subway function)
    1))

; Dom: sub (subway) X stationName (String) X time -> Rec: subway
(define subway-set-station-stoptime
  (lambda(subway station-name time)
    1))

; Dom: sub (subway) X trainId (int) X lineID (int) -> Rec: subway
(define subway-assign-train-to-line
  (lambda(subway station-name time)
    1))

; Dom: sub (subway) X driverId (int) X trainId (int) X departureTime(String en formato HH:MM:SS de 24 hrs) X departure-station (String) X arrival-station (String) -> Rec: subway
(define subway-assign-driver-to-train
  (lambda(subway driver-id train-id departure-time departure-station arrival-station)
    1))