#lang racket
(require "tda-section.rkt")
(require "tda-station.rkt")

(provide (all-defined-out))

(define natural-list-sum
  (lambda(lista)
    (cond
      [(null? lista) 0]
      [else
       (= (car lista) (natural-list-sum (cdr lista)))])))

(define get-sub-section
  (lambda(line s1 s2)
    line))

; Dom: id (int) X name (string) X rail-type (string) X section* (* señala que se pueden agregar 0 o más tramos) -> Rec: line
; Para el parametro section, tendria sentido pasar una lista de estaciones
(define line
  (lambda (id name rail-type . sections)
    (list id name rail-type sections)))

(define e0 (station 1 "los heroes" c 10))
(define e1 (station 2 "republica" r 10))
(define e2 (station 3 "ula" r 10))
(define e3 (station 4 "estacion central" r 10))

(define s0 (section e0 e1 100 230))
(define s1 (section e1 e2 100 230))
(define s2 (section e2 e3 100 230))

(define l1 (line 1 "Linea 1" "SCP123" s0 s1 s2))

; MAS FUNCIONES PARA TDA LINE:

; Dom: line -> Rec: positive-number
; !! DEBE DE SER SIN RECURSION, SOLO DECLARATIVA !!
; IDEA: Revisar la distancia por seccion entre estaciones y sumar todas las distancias
(define line-length
  (lambda(line)
    (define get-sections
      (lambda(line)
        cdr(cdr(cdr(cdr line)))))
    (apply +
           (map (lambda (x) (get-length x)) (car (get-sections l1))))))

(define line-section-length
  (lambda (line)
    line))

; Dom: line -> Rec: positive-number U {0}
; RESOLVER CON RECURISÓN NATURAL
; Re-implementar map y apply
(define line-cost
  (lambda (line)
    line))

; Dom: line (line) X station1-name (String) X station2-name (String) -> Rec: positive-number U {0}
; RESOLVER CON RECURSION DE COLA
(define line-section-cost
  (lambda (line station1 station2)
    line))

; Dom: line (line) X section (section) -> Rec: line
; RESOLVER CON RECURSION NATURAL
(define line-add-section
  (lambda(line section)
    line))

; Dom: line -> Rec: boolean
(define line?
  (lambda(line)
    #t))