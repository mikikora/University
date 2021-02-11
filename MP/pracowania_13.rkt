#lang racket
(require rackunit)

;; definicja wyrażeń

(struct variable     (x)        #:transparent)
(struct const        (val)      #:transparent)
(struct op           (symb l r) #:transparent)
(struct let-expr     (x e1 e2)  #:transparent)
(struct if-expr      (b t e)    #:transparent)
(struct cons-expr    (l r)      #:transparent)
(struct car-expr     (p)        #:transparent)
(struct cdr-expr     (p)        #:transparent)
(struct pair?-expr   (p)        #:transparent)
(struct null-expr    ()         #:transparent)
(struct null?-expr   (e)        #:transparent)
(struct symbol-expr  (v)        #:transparent)
(struct symbol?-expr (e)        #:transparent)
(struct lambda-expr  (xs b)     #:transparent)
(struct app-expr     (f es)     #:transparent)
(struct apply-expr   (f e)      #:transparent)
(struct closure      (xs k env))

(define (expr? e)
  (match e
    [(variable s)       (symbol? s)]
    [(const n)          (or (number? n)
                            (boolean? n))]
    [(op s l r)         (and (member s '(+ *))
                             (expr? l)
                             (expr? r))]
    [(let-expr x e1 e2) (and (symbol? x)
                             (expr? e1)
                             (expr? e2))]
    [(if-expr b t e)    (andmap expr? (list b t e))]
    [(cons-expr l r)    (andmap expr? (list l r))]
    [(car-expr p)       (expr? p)]
    [(cdr-expr p)       (expr? p)]
    [(pair?-expr p)     (expr? p)]
    [(null-expr)        true]
    [(null?-expr p)     (expr? p)]
    [(symbol-expr v)    (symbol? v)]
    [(symbol?-expr p)   (expr? p)]
    [(lambda-expr xs b) (and (list? xs)
                             (andmap symbol? xs)
                             (expr? b)
                             (not (check-duplicates xs)))]
    [(app-expr f es)    (and (expr? f)
                             (list? es)
                             (andmap expr? es))]
    [(apply-expr f e)   (and (expr? f)
                             (expr? e))]
    [(closure xs k env) (and (list? xs)
                             (expr? k)
                             (env? env))]
    [_                  false]))

;; wartości zwracane przez interpreter

(struct val-symbol (s)   #:transparent)

(define (my-value? v)
  (or (number? v)
      (boolean? v)
      (and (pair? v)
           (my-value? (car v))
           (my-value? (cdr v)))
      ; null-a reprezentujemy symbolem (a nie racketowym
      ; nullem) bez wyraźnej przyczyny
      (and (symbol? v) (eq? v 'null))
      (and ((val-symbol? v) (symbol? (val-symbol-s v))))
      (and (closure? v) (expr? v))))

;; wyszukiwanie wartości dla klucza na liście asocjacyjnej
;; dwuelementowych list

(define (lookup x xs)
  (cond
    [(null? xs)
     (error x "unknown identifier :(")]
    [(eq? (caar xs) x) (cadar xs)]
    [else (lookup x (cdr xs))]))

;; kilka operatorów do wykorzystania w interpreterze

(define (op-to-proc x)
  (lookup x `(
              (+ ,+)
              (* ,*)
              (- ,-)
              (/ ,/)
              (> ,>)
              (>= ,>=)
              (< ,<)
              (<= ,<=)
              (= ,=)
              (eq? ,(lambda (x y) (eq? (val-symbol-s x)
                                       (val-symbol-s y))))
              (^ ,expt)
              )))

;; interfejs do obsługi środowisk

(define (env-empty) null)
(define env-lookup lookup)
(define (env-add x v env) (cons (list x v) env))

(define (env? e)
  (and (list? e)
       (andmap (lambda (xs) (and (list? e)
                                 (= (length e) 2)
                                 (symbol? (first e)))))))

(define (env-add-list xs es env)
  (if (null? xs)
      env
      (env-add-list (cdr xs) (cdr es) (env-add (car xs) (eval (car es) env) env))))

(define (abstract-list-to-list es)
  (define (pom es xs)
    (if (null-expr? es)
        xs
        (pom (cons-expr-r es) (cons (cons-expr-l es) xs))))
  (pom es null))

;; interpretacja wyrażeń

(define (eval e env)
  (match e
    [(const n) n]
    [(op s l r)
     ((op-to-proc s) (eval l env)
                     (eval r env))]
    [(let-expr x e1 e2)
     (let ((v1 (eval e1 env)))
       (eval e2 (env-add x v1 env)))]
    [(variable x) (env-lookup x env)]
    [(if-expr b t e) (if (eval b env)
                         (eval t env)
                         (eval e env))]
    [(cons-expr l r)
     (let ((vl (eval l env))
           (vr (eval r env)))
       (cons vl vr))]
    [(car-expr p)      (car (eval p env))]
    [(cdr-expr p)      (cdr (eval p env))]
    [(pair?-expr p)    (pair? (eval p env))]
    [(null-expr)       'null]
    [(null?-expr e)    (eq? (eval e env) 'null)]
    [(symbol-expr v)   (val-symbol v)]
    [(lambda-expr xs b) (closure xs b env)]
    [(app-expr f es) (let ((vf (eval f env)))
                       (match vf
                         [(closure xs b env) (if (= (length es) (length xs))
                                                 (eval b (env-add-list xs es env))
                                                 (error "This funktion takes diffrent amout of arguments"))]
                         [_ (error "Expected function here")]))]
    [(apply-expr f e) (let [(es (abstract-list-to-list e))]
                        (eval (app-expr f es) env))]))

(define (run e)
  (eval e (env-empty)))

;;odleglosc euklidesowa

(define distance
  (lambda-expr '(x1 x2 y1 y2)
                         (op '^ (op '+
                             (let-expr 'a (op '- (variable 'x1) (variable 'y1))
                                       (op '* (variable 'a) (variable 'a)))
                             (let-expr 'b (op '- (variable 'x2) (variable 'y2))
                                       (op '* (variable 'b) (variable 'b)))) (op '/ (const 1) (const 2)))))

;; srednie arytmetyczna i geometryczna
(define average-arythmetical
  (lambda-expr '(x y z)
               (let-expr 'a (op '+ (variable 'x) (op '+ (variable 'y) (variable 'z)))
                         (op '/ (variable 'a) (const 3)))))

(define average-geometrical
  (lambda-expr '(x y z)
               (let-expr 'a (op '* (variable 'x) (op '* (variable 'y) (variable 'z)))
                         (op '^ (variable 'a) (op '/ (const 1) (const 3))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;testy

(define testy
  (test-suite "Tests of new eval funktion with lambda-expr, app-expr and apply-expr"
              ;;tutaj testy distance
              (let [(f1 (run (apply-expr distance (cons-expr (const 1) (cons-expr (const 1) (cons-expr (const 2) (cons-expr (const 2) (null-expr))))))))
                    (f2 (run (apply-expr distance (cons-expr (const 0) (cons-expr (const 5) (cons-expr (const 5) (cons-expr (const 5) (null-expr))))))))
                    (f3 (run (apply-expr distance (cons-expr (const 0) (cons-expr (const 0) (cons-expr (const 0) (cons-expr (const 0) (null-expr))))))))]
                (test-case "" (check-equal? #t (my-value? f1)))
                (test-case "" (check-equal? (expt 2 (/ 1 2)) f1))
                (test-case "" (check-equal? true (my-value? f2)))
                (test-case "" (check-equal? 5 f2))
                (test-case "" (check-equal? true (my-value? f3)))
                (test-case "" (check-equal? 0 f3)))
              ;;tutaj testy average-arythmetical
              (let [(f1 (run (apply-expr average-arythmetical (cons-expr (const -5) (cons-expr (const 0) (cons-expr (const 5) (null-expr)))))))
                    (f2 (run (apply-expr average-arythmetical (cons-expr (const 100) (cons-expr (const 125) (cons-expr (const 150) (null-expr)))))))
                    (f3 (run (apply-expr average-arythmetical (cons-expr (const 2) (cons-expr (const 0) (cons-expr (const 0) (null-expr)))))))]
                (test-case "" (check-equal? true (my-value? f1)))
                (test-case "" (check-equal? 0 f1))
                (test-case "" (check-equal? true (my-value? f2)))
                (test-case "" (check-equal? 125 f2))
                (test-case "" (check-equal? true (my-value? f3)))
                (test-case "" (check-equal? (/ 2 3) f3)))
              ;;tutaj testy average-geometrical
              (let [(f1 (run (apply-expr average-geometrical (cons-expr (const 1) (cons-expr (const 1) (cons-expr (const 1) (null-expr)))))))
                    (f2 (run (apply-expr average-geometrical (cons-expr (const 0) (cons-expr (const 100) (cons-expr (const -3) (null-expr)))))))
                    (f3 (run (apply-expr average-geometrical (cons-expr (const -20) (cons-expr (const 4) (cons-expr (const 7) (null-expr)))))))]
                (test-case "" (check-equal? true (my-value? f1)))
                (test-case "" (check-equal? 1 f1))
                (test-case "" (check-equal? true (my-value? f2)))
                (test-case "" (check-equal? 0 f2))
                (test-case "" (check-equal? true (my-value? f3)))
                (test-case "" (check-equal? (expt (* -20 4 7) (/ 1 3)) f3)))))
