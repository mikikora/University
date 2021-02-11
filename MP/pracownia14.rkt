#lang racket

;; sygnatura: grafy
(define-signature graph^
  ((contracted
    [graph        (-> list? (listof edge?) graph?)]
    [graph?       (-> any/c boolean?)]
    [graph-nodes  (-> graph? list?)]
    [graph-edges  (-> graph? (listof edge?))]
    [edge         (-> any/c any/c edge?)]
    [edge?        (-> any/c boolean?)]
    [edge-start   (-> edge? any/c)]
    [edge-end     (-> edge? any/c)]
    [has-node?    (-> graph? any/c boolean?)]
    [outnodes     (-> graph? any/c list?)]
    [remove-node  (-> graph? any/c graph?)]
    )))

;; prosta implementacja grafów
(define-unit simple-graph@
  (import)
  (export graph^)

  (define (graph? g)
    (and (list? g)
         (eq? (length g) 3)
         (eq? (car g) 'graph)))

  (define (edge? e)
    (and (list? e)
         (eq? (length e) 3)
         (eq? (car e) 'edge)))

  (define (graph-nodes g) (cadr g))

  (define (graph-edges g) (caddr g))

  (define (graph n e) (list 'graph n e))

  (define (edge n1 n2) (list 'edge n1 n2))

  (define (edge-start e) (cadr e))

  (define (edge-end e) (caddr e))

  (define (has-node? g n) (not (not (member n (graph-nodes g)))))
  
  (define (outnodes g n)
    (filter-map
     (lambda (e)
       (and (eq? (edge-start e) n)
            (edge-end e)))
     (graph-edges g)))

  (define (remove-node g n)
    (graph
     (remove n (graph-nodes g))
     (filter
      (lambda (e)
        (not (eq? (edge-start e) n)))
      (graph-edges g)))))

;; sygnatura dla struktury danych
(define-signature bag^
  ((contracted
    [bag?       (-> any/c boolean?)]
    [empty-bag  (and/c bag? bag-empty?)]
    [bag-empty? (-> bag? boolean?)]
    [bag-insert (-> bag? any/c (and/c bag? (not/c bag-empty?)))]
    [bag-peek   (-> (and/c bag? (not/c bag-empty?)) any/c)]
    [bag-remove (-> (and/c bag? (not/c bag-empty?)) bag?)])))

;; struktura danych - stos
(define-unit bag-stack@
  (import)
  (export bag^)

;; TODO: zaimplementuj stos

  (define (bag? b)
    (and (list? b)
         (eq? (length b) 2)
         (eq? (car b) 'stack)))

  (define empty-bag
    (list 'stack '()))

  (define (bag-empty? b)
    (null? (cadr b)))

  (define (bag-insert b x)
    (list 'stack (cons x (cadr b))))

  (define (bag-peek b)
    (caadr b))

  (define (bag-remove b)
    (list 'stack (cdadr b)))
)

;; struktura danych - kolejka FIFO
;; do zaimplementowania przez studentów
(define-unit bag-fifo@
  (import)
  (export bag^)
  
;; TODO: zaimplementuj kolejkę

  (define (bag? b)
    (and (list? b)
         (eq? (length b) 3)
         (eq? (car b) 'fifo)))

  (define empty-bag
    (list 'fifo '() '()))

  (define (bag-empty? b)
    (and (null? (cadr b))
         (null? (caddr b))))

  (define (bag-insert b x)
    (list 'fifo (cadr b) (cons x (caddr b))))

  (define (bag-peek b)
    (if (null? (cadr b))
        (bag-peek (list 'fifo (reverse (caddr b)) '()))
        (caadr b)))

  (define (bag-remove b)
    (if (null? (cadr b))
        (bag-remove (list 'fifo (reverse (caddr b)) '()))
        (list 'fifo (cdadr b) (caddr b))))
)

;; sygnatura dla przeszukiwania grafu
(define-signature graph-search^
  (search))

;; implementacja przeszukiwania grafu
;; uzależniona od implementacji grafu i struktury danych
(define-unit/contract graph-search@
  (import bag^ graph^)
  (export (graph-search^
           [search (-> graph? any/c (listof any/c))]))
  (define (search g n)
    (define (it g b l)
      (cond
        [(bag-empty? b) (reverse l)]
        [(has-node? g (bag-peek b))
         (it (remove-node g (bag-peek b))
             (foldl
              (lambda (n1 b1) (bag-insert b1 n1))
              (bag-remove b)
              (outnodes g (bag-peek b)))
             (cons (bag-peek b) l))]
        [else (it g (bag-remove b) l)]))
    (it g (bag-insert empty-bag n) '()))
  )

;; otwarcie komponentu grafu
(define-values/invoke-unit/infer simple-graph@)

;; graf testowy
(define test-graph
  (graph
   (list 1 2 3 4)
   (list (edge 1 3)
         (edge 1 2)
         (edge 2 4))))
;; TODO: napisz inne testowe grafy!

(define my-graph-1
  (graph
   (list 1 2 3 4 5 6 7 8 9 10)
   (list (edge 1 2)
         (edge 2 4)
         (edge 2 6)
         (edge 3 7)
         (edge 4 1)
         (edge 5 10)
         (edge 5 9)
         (edge 7 3)
         (edge 9 10)
         (edge 10 9))))

(define my-graph-2
  (graph
   (list 1 4 7 10)
   (list (edge 1 4)
         (edge 4 1)
         (edge 7 10)
         (edge 10 7))))

(define my-graph-3
  (graph
   (list 1 2 3 4)
   null))

;; otwarcie komponentu stosu
;  (define-values/invoke-unit/infer bag-stack@)
;; opcja 2: otwarcie komponentu kolejki
 (define-values/invoke-unit/infer bag-fifo@)

;; testy w Quickchecku
(require quickcheck)

;; test przykładowy: jeśli do pustej struktury dodamy element
;; i od razu go usuniemy, wynikowa struktura jest pusta
(quickcheck
 (property ([s arbitrary-symbol])
           (bag-empty? (bag-remove (bag-insert empty-bag s)))))
;; TODO: napisz inne własności do sprawdzenia!
(quickcheck
 (property ([s1 arbitrary-symbol]
            [s2 arbitrary-symbol])
           (bag? (bag-insert (bag-insert empty-bag s1) s2))))

(quickcheck
 (property ([s1 arbitrary-symbol]
            [s2 arbitrary-symbol])
           (bag? (bag-remove (bag-insert (bag-insert empty-bag s1) s2)))))

;;zaleznosci dla stosu
#;(quickcheck
 (property ([s1 arbitrary-symbol]
            [s2 arbitrary-symbol]
            [s3 arbitrary-symbol])
           (eq? s1 (bag-peek (bag-insert (bag-insert (bag-insert empty-bag s3) s2) s1)))))
#;(quickcheck
 (property ([s1 arbitrary-symbol]
            [s2 arbitrary-symbol])
           (eq? s2 (bag-peek (bag-remove (bag-insert (bag-insert empty-bag s2) s1))))))

;;zaleznosci dla fifo
#;(quickcheck
 (property ([s1 arbitrary-symbol]
            [s2 arbitrary-symbol]
            [s3 arbitrary-symbol])
           (eq? s3 (bag-peek (bag-insert (bag-insert (bag-insert empty-bag s3) s2) s1)))))

#;(quickcheck
 (property ([s1 arbitrary-symbol]
            [s2 arbitrary-symbol])
           (eq? s1 (bag-peek (bag-remove (bag-insert (bag-insert empty-bag s2) s1))))))

;; jeśli jakaś własność dotyczy tylko stosu lub tylko kolejki,
;; wykomentuj ją i opisz to w komentarzu powyżej własności

;; otwarcie komponentu przeszukiwania
(define-values/invoke-unit/infer graph-search@)

;; uruchomienie przeszukiwania na przykładowym grafie
(search test-graph 1)
;; TODO: uruchom przeszukiwanie na swoich przykładowych grafach!
(search my-graph-1 1)
(search my-graph-1 10)
(search my-graph-1 5)
(search my-graph-2 1)
(search my-graph-2 10)
(search my-graph-3 1)
(search my-graph-3 4)