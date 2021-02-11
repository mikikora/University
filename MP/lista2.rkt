#lang racket

(define (compose f g)
  (lambda (n)
    (f (g n))))

(define (square x)
  (* x x))

(define (inc i)
  (+ i 1))

((compose square inc) 5)

((compose inc square) 5)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (repeated p n)
  (if (= n 0)
      identity
      (compose (repeated p (- n 1)) p)
  ))

((repeated inc 5) 3)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (product val next start end)
  (if (> start end)
      1
      (* (val start)
         (product val next (next start) end))))

(product identity (lambda (n) (+ n 1)) 1 5)

(define (dwa-ulamki n) (* (/ (- n 1) n) (/ (+ n 1) n)))

(define pi
  (product dwa-ulamki (lambda (n) (+ n 2)) 3.0 150))

pi
(* pi 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (accumulate combiner null-value term start next end)
  (if (> start end)
      null-value
      (combiner (term start)
                (accumulate combiner null-value term (next start) next end))))

(accumulate * 1 identity 1 (lambda (n) (+ 1 n)) 5)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (cont-frac num den k)
  (define (cont i)
    (if (> i k)
        0
        (/ (num i) (+ (den i) (cont (+ i 1))))))
  (cont 0))

(cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 50)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(+ 3 (cont-frac (lambda (x) (square (+ (* 2 x) 1))) (lambda (x) 6.0) 13))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

