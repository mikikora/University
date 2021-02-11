#lang racket

;; struktury z których budujemy drzewa binarne

(struct node (v l r) #:transparent)
(struct leaf () #:transparent)

;; predykat: czy dana wartość jest drzewem binarnym?

(define (tree? t)
  (match t
    [(leaf) true]
    ; wzorzec _ dopasowuje się do każdej wartości
    [(node _ l r) (and (tree? l) (tree? r))]
    ; inaczej niż w (cond ...), jeśli żaden wzorzec się nie dopasował, match kończy się błędem
    [_ false]))

;; przykładowe użycie dopasowania wzorca

(define (insert-bst v t)
  (match t
    [(leaf) (node v (leaf) (leaf))]
    [(node w l r)
     (if (< v w)
         (node w (insert-bst v l) r)
         (node w l (insert-bst v r)))]))


;;zadanie 2
(define (paths t)
  (match t
    [(node v l r) (map (lambda (x) (cons v x)) (append (paths l) (paths r)))]
    [(leaf) (list (list '*))]))

;; definicja wyrażeń arytmetycznych

(struct const (val) #:transparent)
(struct op (symb l r) #:transparent)

(define (expr? e)
  (match e
    [(const n) (number? n)]
    [(op s l r) (and (member s '(+ *))
                     (expr? l)
                     (expr? r))]
    [_ false]))

;; przykładowe wyrażenie

(define e1 (op '* (op '+ (const 2) (const 2))
               (const 2)))

;; ewaluator wyrażeń arytmetycznych

(define (eval e)
  (match e
    [(const n) n]
    [(op '+ l r) (+ (eval l) (eval r))]
    [(op '* l r) (* (eval l) (eval r))]))

;; kompilator wyrażeń arytmetycznych do odwrotnej notacji polskiej

(define (to-rpn e)
  (match e
    [(const n) (list n)]
    [(op s l r) (append (to-rpn l)
                        (to-rpn r)
                        (list s))]))

;;zadanie 3
(define (+or* wz)
  (define (pom wz pluses mults)
    (match wz
      [(const n) (list 0 0)]
      [(op s l r) (let* [(wl (pom l pluses mults))
                         (wr (pom r pluses mults))
                         (new-pluses (+ (first wl) (first wr)))
                         (new-mults (+ (second wl) (second wr)))]
                    (if (equal? s '+)
                        (list (+ 1 new-pluses) new-mults)
                        (list new-pluses (+ 1 new-mults))))]))
  (let [(result (pom wz 0 0))]
    (if (< (first result) (second result))
        '*
        (if (> (first result) (second result))
            '+
            '+*))))

(+or* (op '* (op '* (op '+ (const 2) (const 3)) (const 4)) (op '* (const 1) (const 10))))

;;zadanie 4

(struct doc (tytul autor rozdzialy) #:transparent)
(struct chapter (tytul UChorPph) #:transparent)
(struct paragraph (strings) #:transparent)

(define (paragraph?? a)
  (and (not (null? a))
       (list? (paragraph-strings a))
       (andmap string? (paragraph-strings a))))

(define (chapter?? a)
  (and (chapter? a)
       (string? (chapter-tytul a))
       (list (chapter-UChorPph a))
       (andmap (lambda (x) (or (chapter?? x)
                               (paragraph?? x)))
               (chapter-UChorPph a))))

(define (doc?? a)
  (and (string? (doc-tytul a))
       (string? (doc-autor a))
       (list? (doc-rozdzialy a))
       (andmap chapter?? (doc-rozdzialy a))))




(doc?? (doc "abc" "abc" (list (chapter "abc" (list (paragraph (list "abc")))))))
































