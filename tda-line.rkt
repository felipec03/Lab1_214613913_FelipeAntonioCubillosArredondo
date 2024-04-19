#lang racket
(require "tda-station.rkt")
(require "tda-section.rkt")


(provide (all-defined-out))

(define natural-list-sum
  (lambda(lista)
    (cond
      [(null? lista) 0]
      [else
       (= (car lista) (natural-list-sum (cdr lista)))])))

; Dom: id (int) X name (string) X rail-type (string) X section* (* señala que se pueden agregar 0 o más tramos) -> Rec: line
; Para el parametro section, tendria sentido pasar una lista de estaciones
(define line
  (lambda (id name rail-type . sections)
    (list id name rail-type sections)))

; GETTERS
; Dom: line -> Rec: station+ (1 o màs)
(define get-line-stations
  (lambda(line)
    (car (reverse line))))

; Dom: line -> Rec: station+ (1 o màs)
(define get-subsection
  (lambda (line point1 point2)
    (define wrapper-get-subsection
      (lambda(stations point1 point2)
        (reverse(member point2 (reverse(member point1 stations))))))
    (wrapper-get-subsection (get-line-stations line) point1 point2)))

; REQUISITOS FUNCIONALES:

; Dom: line -> Rec: positive-number
; !! DEBE DE SER SIN RECURSION, SOLO DECLARATIVA !!
; IDEA: Revisar la distancia por seccion entre estaciones y sumar todas las distancias
(define line-length
  (lambda (line)
    (define wrapper-line-length
      (lambda(stations)
        (apply + (map (lambda(s) (get-distance s)) stations))))
    (wrapper-line-length (get-line-stations line))))

; Dom: line x station1 x station2 -> Rec: positive-number
(define line-section-length
  (lambda(line station1 station2)
    (apply + (map(lambda(s) (get-distance s)) (get-subsection line station1 station2)))))

; Dom: line -> Rec: positive-number U {0}
; RESOLVER CON RECURISÓN NATURAL
; Re-implementar map y apply
(define line-cost
  (lambda (line)
    (define wrapper-line-cost
      (lambda (sections)
        (cond
          [(null? sections) 0]
          [(+ (get-cost(car sections)) (wrapper-line-cost (cdr sections)))])))
    (wrapper-line-cost (get-line-stations line))))

; Dom: line (line) X station1-name (String) X station2-name (String) -> Rec: positive-number U {0}
; RESOLVER CON RECURSION DE COLA
(define line-section-cost
  (lambda(line station1 station2)
    (define wrapper-line-section-cost
      (lambda (stations station1 station2 output)
        (cond
          [(null? stations) output]
          [(wrapper-line-section-cost (cdr stations) station1 station2 (+ output (get-cost(car stations))))])))
    (wrapper-line-section-cost (get-subsection line station1 station2) station1 station2 0)))


; Dom: line (line) X section (section) -> Rec: line
; RESOLVER CON RECURSION NATURAL
(define line-add-section
  (lambda(line section)
    (define wrapper-add-section
      (lambda(stations section)
        (cond
          [(null? stations) ])))
    (wrapper-add-section (get-line-stations line) section)))

; Dom: line -> Rec: boolean
; Emplear algún tipo de recursividad

(define line?
  (lambda(line)
    (define wrapper-line?
      (lambda(stations)
        stations))
    (wrapper-line? (get-line-stations line))))