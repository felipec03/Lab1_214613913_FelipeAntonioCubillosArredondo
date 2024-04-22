#lang racket
(require "tda-train_21461391_CubillosArredondo.rkt")
(require "tda-driver_21461391_CubillosArredondo.rkt")
(require "tda-line_21461391_CubillosArredondo.rkt")
(provide (all-defined-out))

;Dom: id (int) X nombre (string) -> Rec: subway
(define subway
  (lambda(id nombre)
    (list id nombre null null null)))

(define subway-aux-constructor1
  (lambda(id nombre trains drivers lines)
    (list id nombre trains lines drivers)))

(define get-subway-id
  (lambda(sub)
    (car sub)))

(define get-subway-name
  (lambda(sub)
    (car (cddr sub))))

(define get-subway-trains
  (lambda(sub)
    (car (cddr sub))))
(define get-subway-lines
  (lambda(sub)
    (car (cdddr sub))))
(define get-subway-drivers
  (lambda(sub)
    (car (cdr sub))))

; emplear algún tipo de recursividad
; IDEA: utilizar definición de list para implementar rf.
; LISTA: (cons (cons (cons... )))
;Dom: sub (subway) X train+ -> Rec: subway
(define subway-add-train
  (lambda(sub . train)
    (define inner-add-train
      (lambda(sub aux)
        (cond
          [(empty? aux) sub]
          [else (inner-add-train (cons (get-subway-id sub)
                                  (cons (get-subway-name sub)
                                        (cons(cons (car aux) (get-subway-trains sub))
                                              (cons (get-subway-lines sub)
                                                    (cons (get-subway-drivers sub) null)))))
                            (cdr aux))])))
    (inner-add-train sub train)
    ))

; no usar recursividad
;Dom: sub (subway) X line+ -> Rec: subway
(define subway-add-line
  (lambda(sub . lines)
    (subway-aux-constructor1 (get-subway-id sub) (get-subway-name sub) (get-subway-trains sub) (get-subway-drivers sub) lines)))
 
; no usar recursividad
;Dom: sub (subway) X driver+ -> Rec: subway
(define subway-add-driver
  (lambda(sub . drivers)
    (subway-aux-constructor1 (get-subway-id sub) (get-subway-name sub) (get-subway-trains sub) drivers (get-subway-lines sub))))

;Dom: sub (subway) -> string
(define subway->string
  (lambda(sub)
    (~a sub)
    (string-join (map ~a sub) " ")))

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

; Dom: sub (subway) X trainId (int) X time (String en formato HH:MM:SS d 24 hrs) -> Rec: station
(define where-is-train
  (lambda(subway train-id time)
    1))

; Dom: sub (subway) X trainId (int) X time (String en formato HH:MM:SS d 24 hrs) -> Rec: list
(define subway-train-path
  (lambda(subway train-id time)
    1))
