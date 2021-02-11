#lang racket
(require rackunit)

;; procedury pomocnicze
(define (tagged-tuple? tag len x)
  (and (list? x)
       (=   len (length x))
       (eq? tag (car x))))

(define (tagged-list? tag x)
  (and (pair? x)
       (eq? tag (car x))
       (list? (cdr x))))

;; reprezentacja formuł w CNFie
;; zmienne
(define (var? x)
  (symbol? x))

(define (var x)
  x)

(define (var-name x)
  x)

(define (var<? x y)
  (symbol<? x y))

;; literały
(define (lit pol var)
  (list 'lit pol var))

(define (pos x)
  (lit true (var x)))

(define (neg x)
  (lit false (var x)))

(define (lit? x)
  (and (tagged-tuple? 'lit 3 x)
       (boolean? (second x))
       (var? (third x))))

(define (lit-pol l)
  (second l))

(define (lit-var l)
  (third l))

;; klauzule
(define (clause? c)
  (and (tagged-list? 'clause c)
       (andmap lit? (cdr c))))

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

;; definicja rezolucyjnych drzew wyprowadzenia
(define (axiom? p)
  (tagged-tuple? 'axiom 2 p))

(define (axiom c)
  (list 'axiom c))

(define (axiom-clause a)
  (second a))

(define (res? p)
  (tagged-tuple? 'resolve 4 p))

(define (res x pf-pos pf-neg)
  (list 'resolve x pf-pos pf-neg))

(define (res-var p)
  (second p))
(define (res-proof-pos p)
  (third p))
(define (res-proof-neg p)
  (fourth p))

(define (proof? p)
  (or (and (axiom? p)
           (clause? (axiom-clause p)))
      (and (res? p)
           (var? (res-var p))
           (proof? (res-proof-pos p))
           (proof? (res-proof-neg p)))))

(define (proof-result pf prop-cnf)
  ;; XXX: zaimplementuj
  (define (proof val pos neg)
    (list 'proof val pos neg))
  (define (get-clauses-from-proof pf)
    (if (axiom? pf)
        (list (axiom-clause pf))
        (remove-duplicates (append (get-clauses-from-proof (res-proof-pos pf))
                (get-clauses-from-proof (res-proof-neg pf))))))
  (define (in list1 list2)
    (define (a-in-list a list)
      (if (null? list)
          false
          (if (equal? a (car list))
              true
              (a-in-list a (cdr list)))))
    (cond [(null? list1) true]
          [(a-in-list (car list1) list2) (in (cdr list1) list2)]
          [else false]))
  (define (solve pf)
    (define (clauses-that-go-further pos neg)
      (if (null? pos)
          (if (null? neg)
              null
              (if (not (equal? (lit-var (car neg)) (res-var pf)))
                  (remove-duplicates (append (list (car neg)) (clauses-that-go-further pos (cdr neg))))
                  (clauses-that-go-further pos (cdr neg))))
          (if (not (equal? (lit-var (car pos)) (res-var pf)))
              (remove-duplicates (append (list (car pos)) (clauses-that-go-further (cdr pos) neg)))
              (clauses-that-go-further (cdr pos) neg))))
    (cond [(axiom? pf) pf]
          [(and (axiom? (res-proof-neg pf)) (axiom? (res-proof-pos pf)))
           (let* ([pos (clause-lits (axiom-clause (res-proof-pos pf)))]
                  [neg (clause-lits (axiom-clause (res-proof-neg pf)))]
                  [res (clauses-that-go-further pos neg)])
              (if (null? res)
                  (axiom (clause))
                  (axiom (remove-duplicates (foldr append null (map clause res))))))]
          [(axiom? (res-proof-pos pf)) (solve (proof (res-var pf) (res-proof-pos pf) (solve (res-proof-neg pf))))]
          [(axiom? (res-proof-neg pf)) (solve (proof (res-var pf) (solve (res-proof-pos pf)) (res-proof-neg pf)))]
          [else (solve (proof (res-var pf) (solve (res-proof-pos pf)) (solve (res-proof-neg pf))))]))
  (define (clauses-from-cnf? pf cnf)
    (let ([from-cnf (cnf-clauses cnf)]
          [from-pf (get-clauses-from-proof pf)])
      (in from-pf from-cnf)))
  (if (and (proof? pf) (clauses-from-cnf? pf prop-cnf))
      (cadr (solve pf))
      false)
  #;(error "proof-result: not implemented!"))

(define (check-proof? pf prop)
  (let ((c (proof-result pf prop)))
    (and (clause? c)
         (null? (clause-lits c)))))

;; XXX: Zestaw testów do zadania pierwszego

(define proof-checking-test
  (test-suite "testy proof-resulta"
              (test-suite "kiedy istnieje literał w dowodzie, którego nie ma w formule CNF"
                          (test-case "zmienna h nie istnieje w formule" (check-equal? #f (proof-result '(resolve q
                                                                   (axiom (clause (lit #t p) (lit #t q)))
                                                                   (axiom (clause (lit #f h) (lit #f q))))
                                                         '(cnf (clause (lit #t p) (lit #t q))
                                                               (clause (lit #f q))))))
                          (test-case "zmienna k nie istnieje w formule CNF" (check-equal? #f (proof-result
                                                          '(resolve q
                                                                    (resolve r (axiom (clause (lit #t r) (lit #f k)))
                                                                             (axiom (clause (lit #f r) (lit #t q))))
                                                                    (axiom (clause (lit #f q))))
                                                          '(cnf (clause (lit #t r))
                                                                (clause (lit #f r) (lit #t q))
                                                                (clause (lit #f q)))))))
              (test-suite "wynikiem proof-resulta dla tych testów będą jakieś klauzule"
                          (test-case "powstaje klauzala dwóch literałów z dwóch różnych gałęzi dowodu" (check-equal? (clause '(lit #t p) '(lit #t h))
                                                                                                                     (proof-result
                                                       '(resolve q
                                                                   (axiom (clause (lit #t p) (lit #t q)))
                                                                   (resolve r (axiom (clause (lit #f q) (lit #t r)))
                                                                              (axiom (clause (lit #f q) (lit #f r) (lit #t h)))))
                                                       '(cnf (clause (lit #t p) (lit #t q))
                                                             (clause (lit #f q) (lit #t r))
                                                             (clause (lit #f q) (lit #f r) (lit #t h)))))))
              (test-suite "tutaj są resolucyjne dowody sprzeczności"
                          (test-case "" (check-equal? #t (check-proof?
                                                          '(resolve q
          (resolve p (axiom (clause (lit #t p) (lit #t q)))
               (axiom (clause (lit #f p) (lit #t q))))
          (resolve r (axiom (clause (lit #f q) (lit #t r)))
               (axiom (clause (lit #f q) (lit #f r)))))
                                                          '(cnf (clause (lit #f p) (lit #t q))
                   (clause (lit #t p) (lit #t q))
                   (clause (lit #f q) (lit #t r))
                   (clause (lit #f q) (lit #f r))))))
                          (test-case "" (check-equal? #t (check-proof?
                                                          '(resolve q
                                                                    (resolve p (axiom (clause (lit #t p) (lit #t q)))
                                                                             (axiom (clause (lit #f p) (lit #t q))))
                                                                    (resolve p (axiom (clause (lit #t p) (lit #f q)))
                                                                             (axiom (clause (lit #f p) (lit #f q)))))
                                                          '(cnf (clause (lit #t p) (lit #t q))
                                                                (clause (lit #f p) (lit #t q))
                                                                (clause (lit #t p) (lit #f q))
                                                                (clause (lit #f p) (lit #f q)))))))))


(run-test proof-checking-test)
;; Wewnętrzna reprezentacja klauzul

(define (sorted? ord? xs)
  (or (null? xs)
      (null? (cdr xs))
      (and (ord? (car xs)
                (cadr xs))
           (sorted? ord? (cdr xs)))))

(define (sorted-varlist? xs)
  (and (andmap var? xs)
       (sorted? var<? xs)))

(define (res-clause pos neg pf)
  (list 'res-clause pos neg pf))

(define (res-clause-pos rc)
  (second rc))
(define (res-clause-neg rc)
  (third rc))
(define (res-clause-proof rc)
  (fourth rc))

(define (res-clause? p)
  (and (tagged-tuple? 'res-clause 4 p)
       (sorted-varlist? (second p))
       (sorted-varlist? (third  p))
       (proof? (fourth p))))

;; implementacja zbiorów / kolejek klauzul do przetworzenia

(define clause-set-empty
  '(stop () ()))

(define (clause-set-add rc rc-set)
  (define (eq-cl? sc)
    (and (equal? (res-clause-pos rc)
                 (res-clause-pos sc))
         (equal? (res-clause-neg rc)
                 (res-clause-neg sc))))
  (define (add-to-stopped sset)
    (let ((procd  (cadr  sset))
          (toproc (caddr sset)))
      (cond
       [(null? procd) (list 'stop (list rc) '())]
       [(or (memf eq-cl? procd)
            (memf eq-cl? toproc))
        sset]
       [else (list 'stop procd (cons rc toproc))])))
  (define (add-to-running rset)
    (let ((pd  (second rset))
          (tp  (third  rset))
          (cc  (fourth rset))
          (rst (fifth  rset)))
      (if (or (memf eq-cl? pd)
              (memf eq-cl? tp)
              (eq-cl? cc)
              (memf eq-cl? rst))
          rset
          (list 'run pd tp cc (cons rc rst)))))
  (if (eq? 'stop (car rc-set))
      (add-to-stopped rc-set)
      (add-to-running rc-set)))

(define (clause-set-done? rc-set)
  (and (eq? 'stop (car rc-set))
       (null? (caddr rc-set))))

(define (clause-set-next-pair rc-set)
  (define (aux rset)
    (let* ((pd  (second rset))
           (tp  (third  rset))
           (nc  (car tp))
           (rtp (cdr tp))
           (cc  (fourth rset))
           (rst (fifth  rset))
           (ns  (if (null? rtp)
                    (list 'stop (cons cc (cons nc pd)) rst)
                    (list 'run  (cons nc pd) rtp cc rst))))
      (cons cc (cons nc ns))))
  (if (eq? 'stop (car rc-set))
      (let ((pd (second rc-set))
            (tp (third  rc-set)))
        (aux (list 'run '() pd (car tp) (cdr tp))))
      (aux rc-set)))

(define (clause-set-done->clause-list rc-set)
  (and (clause-set-done? rc-set)
       (cadr rc-set)))

;; konwersja z reprezentacji wejściowej na wewnętrzną

(define (clause->res-clause cl)
  (let ((pos (filter-map (lambda (l) (and (lit-pol l) (lit-var l)))
                         (clause-lits cl)))
        (neg (filter-map (lambda (l) (and (not (lit-pol l)) (lit-var l)))
                         (clause-lits cl)))
        (pf  (axiom cl)))
    (res-clause (sort pos var<?) (sort neg var<?) pf)))

;; tu zdefiniuj procedury pomocnicze, jeśli potrzebujesz

(define (rc-trivial? rc)
  ;; XXX: uzupełnij
  (define (in list1 list2)
    (define (a-in-list a list)
      (if (null? list)
          false
          (if (equal? a (car list))
              true
              (a-in-list a (cdr list)))))
    (cond [(null? list1) false]
          [(a-in-list (car list1) list2) true]
          [else (in (cdr list1) list2)]))
  (in (second rc) (third rc))
  #;(error "Not implemented"))

(define (rc-resolve rc1 rc2)
  ;; XXX: uzupełnij
  (define (x-in-list x lista)
      (if (null? lista)
          false
          (if (equal? x (car lista))
              true
              (x-in-list x (cdr lista)))))
  (define (what-var-we-resolve c1 c2)
    (cond [(or (and (null? (third c1)) (null? (second c1)))
            (and (null? (third c2)) (null? (second c2)))
            (and (null? (second c1)) (null? (second c2)))
            (and (null? (third c1)) (null? (third c2))))
        false
        ]
         [(or (null? (second c1)) (null? (third c2))) (what-var-we-resolve c2 c1)]
         [(x-in-list (car (second c1)) (third c2)) (car (second c1))]
         [else (what-var-we-resolve (list 'res-clause (cdr (second c1)) (third c1) (fourth c1)) c2)]))
  (define (make-proof c1 c2 a)
    (list 'resolve a (fourth c1) (fourth c2)))
  (define (new-set-of-vars list1 list2 a)
    (remove-duplicates (remove a (sort (append list1 list2) var<?))))
  (let* ([a (what-var-we-resolve rc1 rc2)]
         [pos (new-set-of-vars (second rc1) (second rc2) a)]
        [neg (new-set-of-vars (third rc1) (third rc2) a)]
        [new-proof (make-proof rc1 rc2 a)])
    (if (equal? a #f)
        false
        (list 'res-clause pos neg new-proof)))
  #;(error "Not implemented"))

(define (fixed-point op start)
  (let ((new (op start)))
    (if (eq? new false)
        start
        (fixed-point op new))))

(define (cnf->clause-set f)
  (define (aux cl rc-set)
    (clause-set-add (clause->res-clause cl) rc-set))
  (foldl aux clause-set-empty (cnf-clauses f)))

(define (get-empty-proof rc-set)
  (define (rc-empty? c)
    (and (null? (res-clause-pos c))
         (null? (res-clause-neg c))))
  (let* ((rcs (clause-set-done->clause-list rc-set))
         (empty-or-false (findf rc-empty? rcs)))
    (and empty-or-false
         (res-clause-proof empty-or-false))))

(define (improve rc-set)
  (if (clause-set-done? rc-set)
      false
      (let* ((triple (clause-set-next-pair rc-set))
             (c1     (car  triple))
             (c2     (cadr triple))
             (rc-set (cddr triple))
             (c-or-f (rc-resolve c1 c2)))
        (if (and c-or-f (not (rc-trivial? c-or-f)))
            (clause-set-add c-or-f rc-set)
            rc-set))))

(define (prove cnf-form)
  (let* ((clauses (cnf->clause-set cnf-form))
         (sat-clauses (fixed-point improve clauses))
         (pf-or-false (get-empty-proof sat-clauses)))
    (if (eq? pf-or-false false)
        'sat
        (list 'unsat pf-or-false))))

;; XXX: Zestaw testów do zadania drugiego

(define proving-cnf-tests
  (test-suite "testy zadania drugiego"
              (test-suite "testy rc-trivial?"
                          ;;załóżmy w tych testach że pf to poprawny dowód wyprowadzenia testownanych klauzul
                          (test-case "" (check-equal? #t (rc-trivial? '(res-clause (p) (p z) pf))))
                          (test-case "" (check-equal? #t (rc-trivial? '(res-clause (p q r) (p q r) pf))))
                          (test-case "" (check-equal? #f (rc-trivial? '(res-clause (a b c) (d e f) pf))))
                          (test-case "" (check-equal? #f (rc-trivial? '(res-clause () (p q) pf))))
                          (test-case "" (check-equal? #f (rc-trivial? '(res-clause (p q) () pf)))))
;;ponieważ osobne testowanie procedury rc-resolve wymaga pisania poprawnych dowodów wyprowadzenia obu klauzul przeprowadzę testy procedury prove, która używa rc-resolve
              (test-suite "testy procedury prove"
                          (let [(cnf1 '(cnf (clause (lit #t p) (lit #t q))
                (clause (lit #f p) (lit #t q))
                (clause (lit #t p) (lit #f q))
                (clause (lit #f p) (lit #f q))))
                                (cnf2 '(cnf (clause (lit #f p) (lit #t q))
                                            (clause (lit #f p) (lit #f r) (lit #t s))
                                            (clause (lit #f q) (lit #t r))
                                            (clause (lit #t p))
                                            (clause (lit #f s))))
                                (cnf3 '(cnf (clause (lit #t p) (lit #t r))
                                            (clause (lit #f r) (lit #f s))
                                            (clause (lit #t q) (lit #t s))
                                            (clause (lit #t q) (lit #t r))
                                            (clause (lit #f p) (lit #f q))
                                            (clause (lit #t s) (lit #t p))))
                                (cnf4 '(cnf (clause (lit #t p) (lit #t q) (lit #t r))
                                            (clause (lit #f r) (lit #f q) (lit #f p))
                                            (clause (lit #f q) (lit #t r))
                                            (clause (lit #f r) (lit #t p))))] ;;cnf4 nie posiada dowodu sprzeczności
                            (test-case "brak dowodu na sprzeczność" (check-equal? 'sat (prove cnf4)))
                            (test-case "istnieje dowód na sprzeczność" (check-equal? 'unsat (car (prove cnf3))))
                            (test-case "istnieje dowód" (check-equal? 'unsat (car (prove cnf2))))
                            (test-case "istnieje dowód" (check-equal? 'unsat (car (prove cnf1))))
                            (test-case "zwracany jest dowód" (check-equal? #t (proof? (cadr (prove cnf1))))) ;;cadr ponieważ prove zwraca liste gdzie na pierwszym miejscu jest sumbol 'sat a na drugim lista z dowodem
                            (test-case "zwracany jest dowód" (check-equal? #t (proof? (cadr (prove cnf2)))))
                            (test-case "zwracany jest dowód" (check-equal? #t (proof? (cadr (prove cnf3)))))))))

(run-test proving-cnf-tests)