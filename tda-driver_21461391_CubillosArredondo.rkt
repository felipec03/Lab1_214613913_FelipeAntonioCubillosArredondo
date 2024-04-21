#lang racket
(provide (all-defined-out))
(define driver
  (lambda (id name train-maker)
    (list id name train-maker)))

(define d0 (driver 0 "name0" "CAF"))
(define d1 (driver 1 "name1" "CAF"))
