#lang racket

; zadanie 1

(define/contract (suffixes xs)
  (parametric->/c [a] (-> (listof a) (listof (listof a))))
  (if (null? xs)
      null
      (cons (cdr xs) (suffixes (cdr xs)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; zadanie 3

; ( parametric- >/ c [ a b ] (- > a b a ) )

(define/contract (proc_a x y)
  (parametric->/c [a b] (-> a b a))
  x)

; ( parametric- >/ c [ a b c ] (- > (- > a b c ) (- > a b ) a c ) )

(define/contract (proc_b f1 f2 a)
  (parametric->/c [a b c] (-> (-> a b c) (-> a b) a c))
  (f1 a (f2 a)))

; ( parametric- >/ c [ a b c ] (- > (- > b c ) (- > a b ) (- > a c ) ) )

(define/contract (proc_c f1 f2)
  (parametric->/c [a b c] (-> (-> b c) (-> a b) (-> a c)))
  (compose f1 f2))

; ( parametric- >/ c [ a ] (- > (- > (- > a a ) a ) a ) )

(define/contract (proc_d f)
  (parametric->/c [a] (-> (-> (-> a a) a) a))
  (f identity))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; zadanie 4

; (parametric->/c [a b] (-> a b))


(define/contract (proc4 x)
  (parametric->/c [a b] (-> a b))
  (define/contract (pom x)
    (parametric->/c [a] (-> integer? a))
    (- x 1))
  (if (eq? x 0)
      0
      (proc4 (proc4 (pom x)))))











