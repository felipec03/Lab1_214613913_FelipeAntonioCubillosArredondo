#lang racket
(require "tda-pcar_21461391_CubillosArredondo.rkt")

(provide (all-defined-out))

; El constructor permite determinar si el ensamblado de carros es correcto en base a la compatibilidad de
; estos según modelo y la coherencia de orden (i.e., tren con carros terminales en los extremos t-c-c-c-t).
; El órden de los carros se determina en base al orden de entrada.

;[(and (equal? (get-pcar-type(get-first-pcar train)) "terminal") (equal? (get-pcar-type(get-last-pcar train)) "terminal")) null]

; Dom: id (int) X maker (string) X rail-type (string) X speed (positive number) X station-stay-time (positive number U {0}) X pcar -> Rec: train
(define constructor-train
  (lambda (id maker rail-type speed station-stay-time . pcars)
    (cond
      [(not (positive? speed)) null]
      [else (list id maker rail-type speed (abs station-stay-time) pcars)])))

(define train
  (lambda (id maker rail-type speed station-stay-time . listapcars)
    (cond
      [(empty? (get-pcar-list (constructor-train id maker rail-type speed station-stay-time listapcars))) null]
      [(eq? (train? (constructor-train id maker rail-type speed station-stay-time listapcars)) #t) (constructor-train id maker rail-type speed station-stay-time listapcars)])))

; Capa Getters
(define get-train-id
  (lambda(train)
    (car train)))

(define get-train-maker
  (lambda(train)
    (car (cdr train))))

(define get-train-rail-type
  (lambda(train)
    (car (cddr train))))

(define get-train-speed
  (lambda(train)
    (car (cdddr train))))

(define get-train-station-stay-time
  (lambda(train)
    (car (cddddr train))))

; Dom: train -> Rec: pcar
(define get-first-pcar
  (lambda (train)
    (car(car(cddddr(cdr train))))))

; Dom: train -> Rec: pcar
(define get-last-pcar
  (lambda (train)
    (car(reverse(car(cdr(cddddr train)))))))

; Dom: train -> Rec: list (pcar)
(define get-pcar-list
  (lambda(train)
    (car(car(reverse train)))))

; Requisitos Funcionales
; Dom: train (train) X pcar (pcar) X position (positive-integer U {0}) -> Rec: train
; se debe usar recursividad
(define aux-train-add-car
  (lambda(pcar-list pcar position auxnum auxpair)
    (cond
      [(= position auxnum) (cons auxpair (cons pcar pcar-list))]
      [(aux-train-add-car (cdr pcar-list) pcar position (+ auxnum 1) (cons (car pcar-list) auxpair))])))

(define train-add-car
  (lambda(traina pcar position)
    (train (get-train-id traina) (get-train-maker traina) (get-train-rail-type traina) (get-train-speed traina) (get-train-station-stay-time traina) (aux-train-add-car (get-pcar-list traina) pcar position 0 '() ))))
; Dom: train (train) X pcar (pcar) X position (positive-integer U {0}) -> Rec: train
; se debe usar recursividad
(define outer-train-remove-car
  (lambda(train position)
    (define aux-train-remove-car
      (lambda(pcar-list position auxnum auxpair)
        (cond
          [(= position auxnum) (append auxpair (cdr pcar-list))]
          [(aux-train-remove-car (cdr pcar-list) position (+ 1 auxnum) (cons (car pcar-list) auxpair))])))
   (aux-train-remove-car (get-pcar-list train) position 0 '() )))

(define train-remove-car
  (lambda(traina position)
    (train (get-train-id traina) (get-train-maker traina) (get-train-rail-type traina) (get-train-speed traina) (get-train-station-stay-time traina) (outer-train-remove-car traina position) )))

; Dom: train -> Rec: boolean
; se debe usar recursividad
; FUNCION AUXILIAR PARA CONTAR LA CANTIDAD DE CARROS TERMINALES QUE HAY EN UN TREN!
(define aux-count
  (lambda(list element counter)
    (cond
      [(null? list) counter]
      [(if
        (equal? (car list) element) (aux-count (cdr list) element (+ 1 counter)) (aux-count (cdr list) element counter))])))

; El paso recursivo ocurre en la fimcopm aixpoñoar
(define train?
  (lambda(train)
    (cond
      [(empty? (get-pcar-list train)) #f]
      [else (and (equal? (get-pcar-type(car (get-pcar-list train))) "terminal") (equal? (get-pcar-type(car(reverse (get-pcar-list train)))) "terminal")
                 (= 2 (apply +(map (lambda(pcar) (aux-count pcar "terminal" 0)) (get-pcar-list train))))) #t])))

; Alguna recursividad; en este caso, natural.
; Dom: train -> Rec: positive-number U {0}
(define separate-train-capacity
  (lambda (train-car-list)
    (cond
      [(null? train-car-list)  0]
      [else (+ (get-pcar-capacity(car train-car-list)) (separate-train-capacity (cdr train-car-list)))])))

; Función auxiliar llamada con getter.
(define train-capacity
  (lambda(train)
    (separate-train-capacity (get-pcar-list train))))