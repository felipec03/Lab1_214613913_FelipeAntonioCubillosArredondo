#lang racket
(require "tda-section.rkt")
(require "tda-station.rkt")

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
    line))

; Dom: line -> Rec: boolean
(define line?
  (lambda(line)
    #t))

(define e0 (station 1 "USACH" c 30))
(define e1 (station 2 "Estación Central" c 45))
(define e2 (station 3 "ULA" r 45))
(define e3 (station 3 "República" r 45))
(define e4 (station 4 "Los Héroes" c 60))
(define e5 (station 5 "Toesca" r 40))
(define e6 (station 6 "La Moneda" r 40))
(define e7 (station 7 "Cochera" m 3600))
(define e8 (station 8 "Parque OHiggins" r 30))
(define e9 (station 9 "San Pablo" t 40))
(define e10 (station 10 "Los Dominicos" t 60))

(define s0 (section e0 e1 2 50))
(define s1 (section e1 e2 2.5 55))
(define s2 (section e2 e3 1.5  30))
(define s3 (section e3 e4 3  45))
(define s4 (section e4 e5 3  45))
(define s5 (section e4 e6 1.4  50))
(define s6 (section e5 e8 2  40))
(define s7 (section e0 e7 3  0))
(define s8 (section e0 e9 7  100))
(define s9 (section e6 e10 15  250))

(define l0 (line 0 "Línea 0" "UIC 60 ASCE"))
(define l1 (line 1 "Línea 1" "100 R.E." s0 s1 s2 s3 s5 s7 s8 s9))