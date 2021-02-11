#lang racket

(provide (all-defined-out))

;; definicja wyrażeń

(struct variable     (x)        #:transparent)
(struct const        (val)      #:transparent)
(struct op           (symb l r) #:transparent)
(struct let-expr     (x e1 e2)  #:transparent)
(struct letrec-expr  (x e1 e2)  #:transparent)
(struct if-expr      (b t e)    #:transparent)
(struct cons-expr    (l r)      #:transparent)
(struct car-expr     (p)        #:transparent)
(struct cdr-expr     (p)        #:transparent)
(struct pair?-expr   (p)        #:transparent)
(struct null-expr    ()         #:transparent)
(struct null?-expr   (e)        #:transparent)
(struct symbol-expr  (v)        #:transparent)
(struct symbol?-expr (e)        #:transparent)
(struct lambda-expr  (x b)      #:transparent)
(struct app-expr     (f e)      #:transparent)
(struct set!-expr    (x v)      #:transparent)

;; wartości zwracane przez interpreter

(struct val-symbol (s)   #:transparent)
(struct closure (x b e)) ; Racket nie jest transparentny w tym miejscu,
                         ; to my też nie będziemy
(struct blackhole ()) ; lepiej tzrymać się z daleka!

;; wyszukiwanie wartości dla klucza na liście asocjacyjnej
;; dwuelementowych list

(define (lookup x xs)
  (cond
    [(null? xs)
     (error x "unknown identifier :(")]
    [(eq? (caar xs) x) (cadar xs)]
    [else (lookup x (cdr xs))]))

(define (mlookup x xs)
  (cond
    [(null? xs)
     (error x "unknown identifier :(")]
    [(eq? (mcar (mcar xs)) x)
     (match (mcar (mcdr (mcar xs)))
       [(blackhole) (error "Stuck in a black hole :(")]
       [x x])]
    [else (mlookup x (mcdr xs))]))

(define (mupdate! x v xs)
  (define (update! ys)
    (cond
      [(null? ys) (error x "unknown identifier :(")]
      [(eq? x (mcar (mcar ys)))
       (set-mcar! (mcdr (mcar ys)) v)]
      [else (update! (mcdr ys))]))
  (begin (update! xs) xs))

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
              (% ,modulo)
              (!= ,(lambda (x y) (not (= x y)))) 
              (&& ,(lambda (x y) (and x y)))
              (|| ,(lambda (x y) (or x y)))
              (eq? ,(lambda (x y) (eq? (val-symbol-s x)
                                       (val-symbol-s y))))
              )))

;; interfejs do obsługi środowisk

(define (env-empty) null)
(define env-lookup mlookup)
(define (env-add x v env)
  (mcons (mcons x (mcons v null)) env))
(define env-update! mupdate!)


(define (make-closure x b env)
  (define (in a xs)
    (if (null? xs)
        false
        (if (eq? a (car xs))
            true
            (in a (cdr xs)))))
  (define (pom b)
    (match b
      [(variable x) (list x)]
      [(op s l r) (append (pom l) (pom r))]
      [(let-expr x e1 e2) (append (pom e1) (pom e2))]
      [(letrec-expr x e1 e2) (append (list x) (pom e1) (pom e2))]
      [(if-expr i t e) (append (pom i) (pom t) (pom e))]
      [(cons-expr l r) (append (pom l) (pom r))]
      [(car-expr p) (pom p)]
      [(cdr-expr p) (pom p)]
      [(pair?-expr p) (pom p)]
      [(null?-expr e) (pom e)]
      [(lambda-expr x1 b1) (append (pom x1) (pom b1))]
      [(app-expr f e) (append (pom f) (pom e))]
      [_ null]))
  (define (pom2 xs new-env old-env)
    (if (null? old-env)
        new-env
        (if (in (mcar (mcar old-env)) xs)
            (pom2 xs (env-add (mcar (mcar old-env)) (mcar (mcdr (mcar old-env))) new-env) (mcdr old-env))
            (pom2 xs new-env (mcdr old-env)))))
  (closure x b (pom2 (pom b) (env-empty) env)))
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
    [(letrec-expr x e1 e2)
     (let* ((new-env (env-add x (blackhole) env))
            (v1 (eval e1 new-env)))
       (eval e2 (env-update! x v1 new-env)))]
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
    [(lambda-expr x b) (make-closure x b env) #;(closure x b env)]
    [(app-expr f e)    (let ((vf (eval f env))
                             (ve (eval e env)))
                         (match vf
                           [(closure x b c-env)
                            (eval b (env-add x ve c-env))]
                           [_ (error "application: not a function :(")]))]
    [(set!-expr x e)
     (env-update! x (eval e env) env)]
    ))

(define (run e)
  (eval e (env-empty)))

;; przykład

(define fact-in-expr
  (letrec-expr 'fact (lambda-expr 'n
     (if-expr (op '= (const 0) (variable 'n))
              (const 1)
              (op '* (variable 'n)
                  (app-expr (variable 'fact)
                            (op '- (variable 'n)
                                   (const 1))))))
     (app-expr (variable 'fact)
               (const 5))))


(define append-in-expr
  (letrec-expr 'append (lambda-expr 'xs (lambda-expr 'ys
                                                     (if-expr (null?-expr (variable 'xs))
                                                              (variable 'ys)
                                                              (cons-expr (car-expr (variable 'xs))
                                                                         (app-expr (app-expr (variable 'append)
                                                                                             (cdr-expr (variable 'xs)))
                                                                                   (variable 'ys))))))
               (app-expr (app-expr (variable 'append)
                                   (cons-expr (const 1) (null-expr)))
                         (cons-expr (const 2) (cons-expr (const 3) (null-expr))))))

(define (map f xs)
  (if (null? xs)
      null
      (cons (f (car xs)) (map f (cdr xs)))))


(define map-in-expr
  (letrec-expr 'map (lambda-expr 'f (lambda-expr 'xs
                                                 (if-expr (null?-expr (variable 'xs))
                                                          (null-expr)
                                                          (cons-expr (app-expr (variable 'f) (car-expr (variable 'xs)))
                                                                     (app-expr (app-expr (variable 'map)
                                                                                         (variable 'f))
                                                                               (cdr-expr (variable 'xs)))))))
               (app-expr (app-expr (variable 'map)
                                   (lambda-expr 'x (op '+ (variable 'x) (const 1))))
                         (cons-expr (const 1) (cons-expr (const 2) (null-expr))))))


(define (reverse xs)
  (define (rev xs acc)
    (if (null? xs)
        acc
        (rev (cdr xs) (cons (car xs) acc))))
  (rev xs null))


(define reverse-in-expr
  (letrec-expr 'reverse (lambda-expr 'xs (lambda-expr 'acc
                                                      (if-expr (null?-expr (variable 'xs))
                                                               (variable 'acc)
                                                               (app-expr (app-expr (variable 'reverse)
                                                                                   (cdr-expr (variable 'xs)))
                                                                         (cons-expr (car-expr (variable 'xs)) (variable 'acc))))))
               (app-expr (app-expr (variable 'reverse)
                                   (cons-expr (const 1) (cons-expr (const 2) (null-expr))))
                         (null-expr))))






















