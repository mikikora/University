#lang racket

(define (good-enough? A-1 A0 B-1 B0)
  (< (abs (- (/ A-1 B-1) (/ A0 B0))) 0.000001))

(define (con-frac N D)
  (define (iter i A-1 A0 B-1 B0)
    (if (and (> i 1) (good-enough? A-1 A0 B-1 B0))
        (/ A0 B0)
        (iter (+ i 1) A0 (next i A0 A-1) B0 (next i B0 B-1))))
  (define (next i A0 A-1)
    (+ (* A0 (D i)) (* A-1 (N i))))
  (iter 1 1 0 0 1))

(define (squere x)
  (* x x))

(define pi
  (+ 3 (con-frac (λ (x) (squere(- (* 2 x) 1))) (λ (x) 6.0))))


(define (atan-cf x)
  (/ x (+ 1.0 (con-frac (λ (i) (squere (* x i))) (λ (i) (+ 1 (* 2 i)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;testy
 pi

(atan-cf 10)
(atan 10)

(atan 27)
(atan-cf 27)

(atan 127)
(atan-cf 127)

(atan 0.001)
(atan-cf 0.001)

(atan -4.7)
(atan-cf -4.7)