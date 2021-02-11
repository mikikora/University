#lang racket

(define (good-enough? x y)
  (< (abs (- x y)) 0.0001))

(define (average x y)
  (/ (+ x y) 2))

(define (n-power x n)
  (define (iter k w)
    (if (= k 0)
        w
        (iter (- k 1) (* w x))))
  (iter n 1))

(define (repeated p n)
  (if (= n 0)
      identity
      (compose (repeated p (- n 1)) p)
  ))

(define (compose f g)
  (lambda (n)
    (f (g n))))

(define (fixed-point f s)
  (define (iter k)
    (let ((new-k (f k)))
      (if (good-enough? k new-k)
          k
          (iter new-k))))
  (iter s))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (n-root x n)
  (fixed-point ((repeated average-damp (floor(log n 2))) (λ (y) (/ x (n-power y (- n 1)))))1.0))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;testy

(n-root 4 2) ;;czy działa poprawnie
(n-root 16 4) ;;pokazanie tłumienia
(n-root 150 25) ;;to wymagało tłumienia
(n-root 150 13) ;;to również
(n-root 200 28)
(n-root 1000 5)