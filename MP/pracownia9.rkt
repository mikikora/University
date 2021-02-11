#lang racket

(require rackunit)
(require rackunit/text-ui)

;; definicja wyrażeń arytmetycznych z jedną zmienną

(struct const (val) #:transparent)
(struct op (symb l r) #:transparent)
(struct variable () #:transparent)
(struct derivative (f) #:transparent)

(define (expr? e)
  (match e
    [(variable) true]
    [(const n)  (number? n)]
    [(op s l r) (and (member s '(+ *))
                     (expr? l)
                     (expr? r))]
    [(derivative f) (expr? f)]
    [_          false]))

;; przykładowe wyrażenie

#;(define f (op '* (op '* (variable) (variable))
                 (variable)))

;; pochodna funkcji

(define (∂ f)
  (match f
    [(const n)   (const 0)]
    [(variable)  (const 1)]
    [(op '+ f g) (op '+ (∂ f) (∂ g))]
    [(op '* f g) (op '+ (op '* (∂ f) g)
                        (op '* f (∂ g)))]))

;; przykładowe użycie

;;(define df (∂ f))
;;(define ddf (∂ (∂ f)))
;;(define dddf (∂ (∂ (∂ f))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; eval

(define (eval f var)
  (match f
    [(const n) n]
    [(variable) var]
    [(op '+ r l) (+ (eval l var) (eval r var))]
    [(op '* r l) (* (eval l var) (eval r var))]
    [(derivative fun) (eval (∂ fun) var)]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; testy

(define f1 (op '+ (const 2) (variable))) ;; 2 + x
(define f2 (op '+ (op '* (const 2) (variable)) (derivative (op '+ (op '* (variable) (variable)) (variable))))) ;; 2x + ∂(x^2 + x)
(define f3 (op '* (derivative (op '+ (op '* (const 8) (variable)) (op '* (variable) (op '* (variable) (variable)))))
               (op '+ (op '* (const 34) (variable)) (variable)))) ;; ∂(8x + x^3) * (34x + x)
(define f4 (op '* (op '+ (op '* (const 5) (op '* (variable) (variable))) (op '* (const 2) (variable)))
               (derivative (op '+ (op '* (variable) (op '* (variable) (variable))) (op '+ (op '* (const 7) (variable)) (const 1)))))) ;; (5x^2 + 2x) * ∂(x^3 + 7x + 1)
(define f5 (op '* (op '+ (op '* (const 17) (op '* (variable) (op '* (variable) (variable))))
                      (op '+ (op '* (const 10) (variable)) (const 4))) (op '* (const 9) (derivative (op '+ (variable) (const 4)))))) ;; (17x^3 + 10x + 4) * 9 * ∂(10x + 4)


(define testy
  (test-suite "tests for eval function"
              (test-suite "checking if my functions are tru for predicate expr?"
                          (test-case "" (check-equal? true (expr? f1)))
                          (test-case "" (check-equal? true (expr? f2)))
                          (test-case "" (check-equal? true (expr? f3)))
                          (test-case "" (check-equal? true (expr? f4)))
                          (test-case "" (check-equal? true (expr? f5))))
              (test-suite "checking if eval gives number?"
                          (test-case "" (check-equal? true (number? (eval f1 1))))
                          (test-case "" (check-equal? true (number? (eval f2 1))))
                          (test-case "" (check-equal? true (number? (eval f3 1))))
                          (test-case "" (check-equal? true (number? (eval f4 1))))
                          (test-case "" (check-equal? true (number? (eval f5 1)))))
              (test-suite "checking if eval gives good results"
                          (test-case "" (check-equal? 5 (eval f1 3)))
                          (test-case "" (check-equal? 65 (eval f2 16)))
                          (test-case "" (check-equal? 1400 (eval f3 2)))
                          (test-case "" (check-equal? 107800 (eval f3 10)))
                          (test-case "" (check-equal? 456 (eval f4 2)))
                          (test-case "" (check-equal? 39886 (eval f4 7)))
                          (test-case "" (check-equal? 1440 (eval f5 2)))
                          (test-case "" (check-equal? 33624 (eval f5 6))))))

(run-tests testy)










