#lang racket

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;zad1

#;(define (append . x)
  (define (pom L)
    (if (null? L)
        (aux (cdr x))
        (cons ))))

;;(append (list 1 2) (list 5 6) (list 1 2 3) null)

(define (tagged-list? len sym x)
  (and (list? x)
       (= (length x) len)
       (eq? (first x) sym)))

;; drzewa binarne etykietowane w wierzchołkach wewnętrznych

(define leaf 'leaf)

(define (leaf? x)
  (eq? x 'leaf))

(define (node e l r)
  (list 'node e l r))

(define (node? x)
  (tagged-list? 4 'node x))

(define (node-elem x)
  (second x))

(define (node-left x)
  (third x))

(define (node-right x)
  (fourth x))

(define (tree? x)
  (or (leaf? x)
      (and (node? x)
           (tree? (node-left  x))
           (tree? (node-right x)))))

;; operacje na drzewach BST

(define (find x t)
  (cond
    [(leaf? t)            false]
    [(= (node-elem t) x)  true]
    [(> (node-elem t) x)  (find x (node-left t))]
    [(< (node-elem t) x)  (find x (node-right t))]))

(define (insert x t)
  (cond
    [(leaf? t)            (node x leaf leaf)]
    [(= (node-elem t) x)  t]
    [(> (node-elem t) x)  (node (node-elem t)
                                (insert x (node-left t))
                                (node-right t))]
    [(< (node-elem t) x)  (node (node-elem t)
                                (node-left t)
                                (insert x (node-right t)))]))

(define empty leaf)


(define (mirror t)
  (if (eq? t 'leaf)
      'leaf
      (let ([LT (mirror (third t))] [RT (mirror (fourth t))])
        (list 'node (second t) RT LT))))

(mirror (insert 3 (insert 1 'leaf)))
(mirror '(node a (node b (node c leaf leaf) leaf) (node d leaf leaf)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;zadanie 3

#;(define (flatten t)
  (if (eq? t 'leaf)
      null
      (append (flatten (third t)) (list (second t)) (flatten (fourth t))))) ;;rozwiazanie z appendem

(define (flatten t)
  (define (helper t acc)
    (if (eq? 'leaf t)
        acc
        (helper (third t) (cons (second t) (helper (fourth t) acc)))))
  (helper t null))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;zadanie 4

(define (fold op nval xs)
  (if (null? xs)
      nval
      (op (car xs)
          (fold op nval (cdr xs)))))

#;(define (sort x)
  (define (buduj t x)
    (if (null? x)
        t
        (buduj (insert (car x) t) (cdr x))))
  (flatten (buduj 'leaf x)))

(define (treesort xs)
  (flatten (fold insert 'leaf xs)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;zadanie 5

#;(define (delete t x)
  (define (newval t)
    (if (eq? (third t) 'leaf)
        (second t)
        (newval (third t))))
  (define (bez t x)
    ) ;;tutaj dokończyć
  (define (usun t x)
    (cond ((= x (second t))
        (list 'node (newval (fourth t)) (third t) (bez (fourt t) (newval (fourth t)))))
        ((> x (second t)) (usun (fourth t) x))
        (else (usun (third t) x)))
    )
  (if (find x t)
      (usun t x)
      t))

(define (delete x t)
  
  (define (dfs t x newt)
    (cond
      [(eq? t 'leaf) newt]
      [(eq? (second t) x) (dfs (fourth t) x (dfs (third t) x newt))]
      [else (insert (second t) (dfs (fourth t) x (dfs (third t) x newt)))]))
    (dfs t x 'leaf))


;;22 godzina 10

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;zadanie 6

(define (concatMap f xs)
  (if (null? xs)
      null
      (append (f (car xs)) (concatMap f (cdr xs)))))

(define (from-to s e)
  (if (= s e)
      (list s)
      (cons s (from-to (+ s 1) e))))

(define (queens board-size)
  ;; Return the representation of a board with 0 queens inserted
  (define (empty-board)
    '())
  ;; Return the representation of a board with a new queen at
  ;; (row, col) added to the partial representation `rest'
  (define (adjoin-position row col rest)
    (define (iter k xs re)
      (if (null? re)
          xs
          (if (= k col)
              (iter (+ k 1) (append xs (list row)) (cdr re))
              (iter (+ k 1) (append xs (car re)) (cdr re)))
          ))
    (iter 1 null rest))
  ;; Return true if the queen in k-th column does not attack any of
  ;; the others
  (define (safe? k positions)
    (define (iter i poz pole)
      (if (null? pole)
          #f
          (if (= i k)
              (iter (+ i 1) poz (cdr pole))
              (or (= (car pole) poz)
                  (= (abs (- k i)) (abs (- (car poz) poz)))
                  (iter (+ 1 i) poz (cdr pole))))))
    (define (znajdz-poz i pole)
      (if (= i k)
          (car pole)
          (znajdz-poz (+ 1 i) (cdr pole))))
    (iter 1 (znajdz-poz 1 positions) positions))
  ;; Return a list of all possible solutions for k first columns
  (define (queen-cols k)
    (if (= k 0)
        (list (empty-board))
        (filter
         (lambda (positions) (safe? k positions))
         (concatMap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (from-to 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(queens 3)


















