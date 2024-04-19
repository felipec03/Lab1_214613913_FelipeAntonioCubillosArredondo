#lang racket
(require "tda-subway.rkt")
(require "tda-station.rkt")
(require "tda-section.rkt")
(require "tda-line.rkt")
; TDA STATION
(define e0 (station 0 "Vespucio Norte" t 1))
(define e1 (station 1 "Zapadores" r 1))
(define e2 (station 2 "Dorsal" r 1))
(define e3 (station 3 "Einstein" r 1))
(define e4 (station 4 "Cementerios" r 1))
(define e5 (station 5 "Cerro Blanco" r 1))
(define e6 (station 6 "Patronato" r 1))
(define e7 (station 7 "Puente Cal y Canto" c 1))
(define e8 (station 8 "La Cisterna" t 1))

(define e9 (station 9 "Los Libertadores" t 1))
(define e10 (station 10 "Cardenal Caro" r 1))
(define e11 (station 11 "Vivaceta" r 1))
(define e12 (station 12 "Conchalí" r 1))
(define e13 (station 13 "Plaza Chacabuco" r 1))
(define e14 (station 14 "Hospitales" r 1))
(define e15 (station 15 "Puente Cal y Canto" c 1))
(define e16 (station 16 "Fernando Castillo Velasco" t 1))

(define e17 (station 17 "San Pablo" t 1))
(define e18 (station 18 "Universidad de Santiago" r 1))
(define e19 (station 19 "Estacion Central" r 1))
(define e20 (station 20 "Unión Latinoamericana" r 1))
(define e21 (station 21 "Republica" r 1))
(define e22 (station 22 "Los Heroes" c 1))
(define e23 (station 23 "Los Dominicos" t 1))


; TDA SECTION
(define s0 (section e0 e1 3.5 230))
(define s1 (section e1 e2 3.5 230))
(define s2 (section e2 e3 3.5 230))
(define s3 (section e3 e4 3.5 230))
(define s4 (section e4 e5 3.5 230))
(define s5 (section e5 e6 3.5 230))
(define s6 (section e6 e7 3.5 230))
(define s7 (section e7 e8 3.5 230))

(define s8 (section e9 e10 4.2 230))
(define s9 (section e10 e11 4.2 230))
(define s10 (section e10 e11 4.2 230))
(define s11 (section e11 e12 4.2 230))
(define s12 (section e12 e13 4.2 230))
(define s13 (section e13 e14 4.2 230))
(define s14 (section e14 e15 4.2 230))
(define s15 (section e15 e16 4.2 230))

(define s16 (section e16 e17 2.3 230))
(define s17 (section e17 e18 2.3 230))
(define s18 (section e18 e19 2.3 230))
(define s19 (section e19 e20 2.3 230))
(define s20 (section e20 e21 2.3 230))
(define s21 (section e21 e22 2.3 230))
(define s22 (section e22 e23 2.3 230))

; TDA LINE
(define l0 (line 2 "Linea 2" "100 RE" s0 s1 s2 s3 s4 s5 s6))
(define l1 (line 3 "Linea 3" "100 RE" s8 s9 s10 s11 s12 s14 s15))
(define l2 (line 1 "Linea 1" "100 RE" s16 s17 s18 s19 s20 s21 s22))
; TDA PCAR
; TDA TRAIN
; TDA DRIVER
; TDA SUBWAY