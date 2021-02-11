#lang racket

(require rackunit)

(define (merge xs ys)
  (define (merging xs ys res)
    (cond
      [(null? xs) (append res ys)]
      [(null? ys) (append res xs)]
      [(< (car xs) (car ys)) (merging (cdr xs) ys (append res (list (car xs))))]
      [else (merging xs (cdr ys) (append res (list (car ys))))]))
  (merging xs ys null))

(define (split xs)
  (let ((n (floor (/ (length xs) 2))))
    (define (iter xs wl i)
      (if (>= i n)
          (cons wl xs)
          (iter (cdr xs) (append wl (list (car xs))) (+ i 1))))
    (iter xs null 0)))

(define (merge-sort xs)
  (cond
    [(null? xs) xs]
    [(null? (cdr xs)) xs]
    [else
     (let ((lpair (split xs)))
       (merge
        (merge-sort (car lpair))
        (merge-sort (cdr lpair))))]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;testy

(define a (list 1 3 5 7 9))
(define b (list 1 2 3 4 5 6 7 8 9))
(define c (list 1 1 1 1 1 1 1 1))
(define d null)
(define e (list 3 6 1 2 4 7 4 3)) ;;lista parzystej długości
(define f (list 6))
(define g (list 5 7 2 3 5)) ;;lista nieparzystej długości


(define merge-sort-test
  (test-suite 
  "zestaw testów dla wszystkich powyższych funkcji"
    
     (test-suite
   "zestaw testów procedury merge"
   ;;uwaga merge w założeniu działa dla list niemalejących i tylko takie będą testowane
   
     (test-case "merge z nullem zwraca liste" (check-equal? (list? (merge a d)) #t))
     (test-case "merge z lista zwraca liste" (check-equal? (list? (merge b c)) #t))
     (test-case "merge z nullem" (check-equal? (merge a d) a))
     (test-case "merge z listą rosnacą" (check-equal? (merge a b) (list 1 1 2 3 3 4 5 5 6 7 7 8 9 9)))
     (test-case "merge z listą niemalejącą" (check-equal? (merge a c) (list 1 1 1 1 1 1 1 1 1 3 5 7 9))
      )
  )
    
    (test-suite
     "zestaw testów procedury split"
   (test-case "split z rosnącą listą" (check-equal? (split a) (cons (list 1 3) (list 5 7 9))))
   (test-case "split z nullem" (check-equal? (split d) (cons null null)))
   (test-case "split z dowolną listą" (check-equal? (split e) (cons (list 3 6 1 2) (list 4 7 4 3))))
   (test-case "split z listą jednoelementową" (check-equal? (split f) (cons null (list 6)))))

    (test-suite
     "zestaw testów procedury merge-sort"
     (test-case "merge-sort z nullem jest listą" (check-equal? (list? (merge-sort d)) #t))
     (test-case "merge-sort z dowolną listą jest listą" (check-equal? (list? (merge-sort e)) #t))
     (test-case "merge-sort z nullem" (check-equal? (merge-sort d) null))
     (test-case "merge-sort z listą posortowaną rosnąco" (check-equal? (merge-sort a) a))
     (test-case "merge-sort z listą posortowaną niemalejąco" (check-equal? (merge-sort c) c))
     (test-case "merge-sort z listą jednoelementową" (check-equal? (merge-sort f) f))
     (test-case "merge-sort z dowolną listą parzystej długości" (check-equal? (merge-sort e) (list 1 2 3 3 4 4 6 7)))
     (test-case "merge-sort z dowolną listą nieparzystej długości" (check-equal? (merge-sort g) (list 2 3 5 5 7))))))















