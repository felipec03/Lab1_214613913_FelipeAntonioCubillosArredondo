#lang racket
(require "tda-section_21461391_CubillosArredondo.rkt")
(require "tda-station_21461391_CubillosArredondo.rkt")
(provide (all-defined-out))

; Funcion auxiliar para facilitar comprensión de código
; Dom: list -> Rec: num
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

(define get-line-id
  (lambda(line)
    (car line)))

(define get-line-name
  (lambda(line)
    (car (cdr line))))

(define get-line-rail-type
  (lambda(line)
    (car (cddr line))))

; GETTERS
; Dom: line -> Rec: station+ (1 o màs)
(define get-line-stations
  (lambda(line)
    (car (reverse line))))

; Dom: line x station1 x station2 -> Rec: station+ (1 o màs)

(define get-first-section-by-name
  (lambda (station-list station-name)
    (cond
      [(equal? (car(cdr(car(car station-list)))) station-name) (car station-list)]
      [(get-first-section-by-name (cdr station-list) station-name)])))

; (second(car(cddr(reverse (car(get-line-stations mil0))))))
(define get-second-section-by-name
  (lambda (station-list station-name)
    (cond
      [(equal? (second(car(cddr(reverse (car station-list))))) station-name) (car station-list)]
      [(get-second-section-by-name (cdr station-list) station-name)])))


(define get-subsection
  (lambda (line point1 point2)
    (define wrapper-get-subsection
      (lambda(stations point1 point2)
        (reverse(member point2 (reverse(member point1 stations))))))
    (wrapper-get-subsection (get-line-stations line) (get-first-section-by-name (get-line-stations line) point1) (get-second-section-by-name (get-line-stations line) point2))))

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
; Se puede resolver con recusrividad
(define line-section-length
  (lambda (line station1 station2)
    (define wrapper-line-section-length
      (lambda (stations station1 station2)
        (cond
          [(null? stations) 0]
          [(+ (get-distance(car stations)) (wrapper-line-section-length (cdr stations) station1 station2))])))
    (wrapper-line-section-length (get-subsection line station1 station2)
                                 (get-first-section-by-name (get-line-stations line) station1) (get-second-section-by-name (get-line-stations line) station2))))

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
    (wrapper-line-section-cost (get-subsection line station1 station2)
                               (get-first-section-by-name (get-line-stations line) station1) (get-second-section-by-name (get-line-stations line) station2) 0)))

; Dom: line (line) X section (section) -> Rec: line
; RESOLVER CON RECURSION NATURAL

; Función auxiliar recursiva que determina si una sección está en una linea
; ACÁ ES EL PASO RECURSIVO NATURAL
; Dom: sections+ | null x section -> Rec: boolean
(define aux-section-in-line?
  (lambda(line-sections section)
    (cond
      [(empty? line-sections) #f]
      [(equal? (first line-sections) section) #t]
      [else (aux-section-in-line? (rest line-sections) section)])))

(define line-add-section
  (lambda(linea section)
    (define wrapper-line-add-section
      (lambda(sections section)
        (cond
          [(eq? #t (aux-section-in-line? sections section)) null]
          [else (cons section sections)])))
    (line (get-line-id linea) (get-line-name linea) (get-line-rail-type linea) (wrapper-line-add-section (get-line-stations linea) section))))
    
; Dom: line -> Rec: boolean
; Emplear algún tipo de recursividad
; FUNCION AUXILIAR PARA CONTAR LA CANTIDAD DE ESTACIONES TERMINALES QUE HAY EN UNA LÍNEA!!

(define line?
  (lambda(line)
    (cond
      [(empty? (get-line-stations line)) #f]
      [else (and (equal? (get-station-type(car(car(get-line-stations line)))) "terminal") (equal? (get-station-type(car(car(reverse (get-line-stations line))))) "terminal")) #t])))