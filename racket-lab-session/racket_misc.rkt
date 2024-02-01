#lang racket

(require "mk.rkt")

;; append is a function that takes two lists as input, and returns a list as outut
;(define append
;  (lambda (l1 l2)
;    (if (null? l1)
;        l2
;        (cons (first l1) (append (rest l1) l2)))))

;; appendo is a *relation* of three arguments, all of which are lists
(define appendo
  (lambda (l1 l2 out)
    (conde
       ((== '() l1) (== l2 out))
       ((fresh (a d res)
          (== (cons a d) l1)
          (== (cons a res) out)
          (appendo d l2 res))))))

(run 1 (?)
  (appendo '(cat dog) '(tiger fox) ?))
;; => ((cat dog tiger fox))

(run 1 (?)
  (appendo '(cat dog) ? '(cat dog tiger fox)))
;; => ((tiger fox))

(run* (X Y)
  (appendo X Y '(cat dog tiger fox)))
;; => (
;;     (() (cat dog tiger fox))
;;     ((cat) (dog tiger fox))
;;     ((cat dog) (tiger fox))
;;     ((cat dog tiger) (fox))
;;     ((cat dog tiger fox) ())
;;    )

(run 1 (X Y Z)
  (appendo X Y Z))
;; =>
;; (
;;   X   Y   Z
;;  (() _.0 _.0)
;; )

(run 1 (X Y Z)
  (appendo `(,X   dog) `(tiger    ,Z)   ;; inputs
           `(cat  ,Y     tiger   fox))) ;; output
;; => ((cat dog fox))

(run 1 (X Y Z)
  (appendo `(,X   dog) `(tiger    ,Z)   ;; inputs
           `(cat  ,Y     bear   fox))) ;; output
;; => ()   failure (no answers)

(append '(cat dog) '(tiger fox))
;; => (cat dog tiger fox)

(append '() '())
;; => ()

(append '() '(a b c))
;; => (a b c)

(append '(x y z) '())
;; => (x y z)


;;; Paradigms of Programming:
;;;    Object-oriented Programming
;;;    Procedural Programming
;;;    Functional Programming
;;;    Array-Oriented Programming
;;;    Stack-Oriented Programming
;;;    * Constraint Programming
;;;    * Logic Programming
;;;    * Relational Programming


;;; Logic programming

;;; Constraint logic programming

;;; Relational programming

#|
int x = 5;
int y = 6;
x = x + 7;
int z = x + y;

x  +  y  =  z
--------------
0     0     0
1     0     1
...
2     4     6
3     4     7  <-
4     4     8
...
5     2     7  <-


3 + 4 = ?,  solution is    ? = 7
? + 4 = 7,  solution is    ? = 3
?1 + ?2 = 7,  solutions are  ?1 = 3 and ?2 = 4, ?1 = 5 and ?2 = 2, etc.
all solutions are:
?1  ?2
0    7
1    6
2    5
3    4
4    3
5    2
6    1
7    0

?1 + ?2 = ?3     now have infinitely many answers

|#

