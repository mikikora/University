#lang racket

(define (tagged-tuple? tag len x)
  (and (list? x)
       (=   len (length x))
       (eq? tag (car x))))

(define (tagged-list? tag x)
  (and (pair? x)
       (eq? tag car x)
       (list? cdr x)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define (var? t)
  (symbol? t))

(define (var x)
  x)

;;
(define (neg? t)
  (and (list? t)
       (= 2 (length t))
       (eq? 'neg (car t))))

(define (neg x)
  (list 'neg x))

(define (neg-subf f)
  (second f))

;;
(define (conj? t)
  (and (list? t)
       (= 3 (length t))
       (eq? 'conj (car t))))

(define (conj t1 t2)
  (list 'conj t1 t2))

(define (conj-left t)
  (second t))

(define (conj-right t)
  (third t))

;;
(define (disj? t)
  (and (list? t)
       (= 3 (length t))
       (eq? 'disj (car t))))

(define (disj t1 t2)
  (list 'disj t1 t2))

(define (disj-left t)
  (second t))

(define (disj-right t)
  (third t))

(define (prop? f)
  (or (var? f)
      (lit? f)
      (and (neg? f)
           (prop? (neg-subf f)))
      (and (disj? f)
           (prop? (disj-left f))
           (prop? (disj-right f)))
      (and (conj? f)
           (prop? (conj-left f))
           (prop? (conj-right f)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; zadanie 2

#;(define (free-vars x)
  (define (pom x xs)
    (cond [(var? x) (list x)]
          [(neg? x) (append xs (pom (neg-subf x) xs))]
          [(disj? x) (append xs (pom (disj-left x) xs)
                             (pom (disj-right x) xs))]
          [(conj? x) (append xs (pom (conj-left x) xs)
                             (pom (conj-right x) xs))]))
  (remove-duplicates (pom x null)))

(define (free-vars x)
  (define (pom x)
     (cond [(var? x) (list x)]
           [(lit? x) (list (lit-val x))]
           [(neg? x) (free-vars (neg-subf x))]
           [(disj? x) (append (free-vars (disj-left x))
                              (free-vars (disj-right x)))]
           [(conj? x) (append (free-vars (conj-left x))
                              (free-vars (conj-right x)))])
  )
  (remove-duplicates (pom x)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; zadanie 3

(define (gen-vals xs)
  (if (null? xs)
      (list null)
      (let*
          ((vss (gen-vals (cdr xs)))
           (x (car xs))
           (vst (map (lambda (vs) (cons (list x true) vs)) vss))
           (vsf (map (lambda (vs) (cons (list x false) vs)) vss)))
        (append vst vsf))))

(define (eval-formula f l)
  (define (eval-var x l)
    (if (null? l)
        (error "variable with no evaluation")
        (if (eq? x (caar l))
            (cdar l)
            (eval-var x (cdr l))))
    )
  (cond
    [(var? f) (eval-var f l)]
    [(lit? f) (if (lit-bool f)
                  (eval-var (lit-val f) l)
                  (eval-formula (neg (lit-val f)) l))]
    [(neg? f) (not (eval-formula (neg-subf f) l))]
    [(disj? f) (or (eval-formula (disj-left f) l)
                   (eval-formula (disj-right f) l))]
    [(conj? f) (and (eval-formula (conj-left f) l)
                    (eval-formula (conj-right f) l))]))

(define (falsifiable-eval? f)
  (define (search-false f xs)
    (if (null? xs)
        false
        (if (eval-formula f (car xs))
            (search-false f (cdr xs))
            (car xs))))
  (let [(lista (gen-vals (free-vars f)))]
    (search-false f lista)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; zadanie 4

(define (lit pol var)
  (list 'lit pol var))

(define (lit? x)
  (and (tagged-tuple? 'lit 3 x)
       (boolean? (second x))
       (var? (third x))))

(define (lit-val x)
  (third x))

(define (lit-bool x)
  (second x))

(define (nnf? f)
  (cond [(lit? f) true]
        [(neg? f) false]
        [(disj? f) (and (nnf? (disj-left f))
                        (nnf? (disj-right f)))]
        [(conj? f) (and (nnf? (conj-left f))
                        (nnf? (conj-right f)))]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; zadanie 5

(define (convert-to-nnf f)
  (cond [(var? f) (lit true f)]
        [(conj? f) (conj (convert-to-nnf (conj-left f))
                         (convert-to-nnf (conj-right f)))]
        [(disj? f) (disj (convert-to-nnf (disj-left f))
                         (convert-to-nnf (disj-right f)))]
        [(neg? f) (convert-neg-to-nnf (neg-subf f))]))

(define (convert-neg-to-nnf f)
  (cond [(var? f) (lit false f)]
        [(conj? f) (conj (convert-neg-to-nnf (conj-left f))
                         (convert-neg-to-nnf (conj-right f)))]
        [(disj? f) (disj (convert-neg-to-nnf (disj-left f))
                         (convert-neg-to-nnf (disj-right f)))]
        [(neg? f) (convert-to-nnf (neg-subf f))]))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; zadanie 6

(define (clause? x)
  (and (tagged-list? 'claus x)
       (andmap lit? (cdr x))))

(define (clause . lits)
  (cons 'clause lits))

(define (clause-lits c)
  (cdr c))

(define (cnf? f)
  (and (tagged-list? 'cnf f)
       (andmap clause? (cdr f))))

(define (cnf . clauses)
  (cons 'cnf clauses))

(define (cnf-clauses f)
  (cdr f))

#;(define (convert-to-cnf f)
    (define (literals xs)
      (if (null? xs)
          null
          (append (lit (not (cdr xs)) (car xs))
                  (literals (cdr xs)))))
    (define (pom xs)
      (if (null? xs)
          null
          (if (eval-formula f (car xs))
              (pom (cdr xs))
              (append (clause (literals (car xs)))
                      (pom (car xs))))))
  (let* [(lista (gen-vals (free-vars f)))
         (list-clauses (pom lista))]
    (cnf list-clauses)))

#;(define (convert-to-cnf f)
  (cond [(lit? f) (clause f)]
        [(clause? f) f]
        [conj? f] (cnf (convert))))


;;(convert-to-cnf (convert-to-nnf (conj (disj (neg 'x) (conj 'x (neg 'z))) 'y)))









