(define (entry tree)
  (car tree)
)

(define (left-branch tree)
  (cadr tree)
)

(define (right-branch tree)
  (caddr tree)
)

(define (tree->list tree)
  (if (null? tree)
    '()
    (append (tree->list (left-branch tree))
            (cons (entry tree) (tree->list (right-branch tree))))
  )
)

(define (list->tree l)
  (define (split l n left mid)
    (if (= 0 n)
      (list left mid l)
      (split (cdr l) (- n 1) (append left (list mid)) (car l))
    )
  )

  (define (partial-list->tree lst len)
    (if (null? lst)  
      '()
      (let ((mid (quotient len 2)))
        (let ((parts (split (cdr lst) mid '() (car lst))))
          ; (newline)
          ; (display "lst=")
          ; (display lst)
          ; (display " parts=")
          ; (display parts)
          (let ((left (car parts))
                (right (caddr parts))
                (entry (cadr parts)))
            (list entry 
                  (partial-list->tree left mid) 
                  (partial-list->tree right (- len mid 1))
            )
          )
        )
      )
    )
  )

  (partial-list->tree l (length l))
)

(define (rebalance-tree tree)
  (list->tree (tree->list tree))
)

(list->tree '())
(list->tree '(1))
(list->tree '(1 2))
(list->tree '(1 2 3))
(list->tree '(1 2 3 4))
(list->tree '(1 2 3 4 5 6 7 8 9 10 11))

(tree->list '())
(tree->list '(42 () ()))
(tree->list '(42 (0 () ()) ()))
(tree->list '(42 () (9000 () ())))
(tree->list '(42 (0 () ()) (9000 () ())))
(tree->list '(5 (2 (1 () ()) (3 () ())) (8 (6 () (7 () ())) (10 (9 () ()) (11 () ())))))
(tree->list '(1 () (2 () (3 () (4 () (5 () (6 () (7 () (8 () (9 () (10 () (11 () ()))))))))))))

(rebalance-tree '(5 (2 (1 () ()) (3 () ())) (8 (6 () (7 () ())) (10 (9 () ()) (11 () ())))))
(rebalance-tree '(1 () (2 () (3 () (4 () (5 () (6 () (7 () (8 () (9 () (10 () (11 () ()))))))))))))

