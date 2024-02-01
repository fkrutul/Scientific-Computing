#lang racket

;; Advanced Lab #1
;; 26 February 02020

;; To be run in DrRacket or Racket.
;; https://racket-lang.org/  (either Racket 7.6 or Racket 7.6 CS)
;;
;; Open this file in DrRacket and click the 'Run' button with the green triangle!
;;
;; Racket is a "batteries included" version of Scheme.

;; Good resources on Scheme include:

;; Structure and Interpretation of Computer Programs, widely considered to be the best textbook ever written
;; on programming.  This was the standard introductory textbook at MIT for 20 years.  Co-written by one of the
;; creators of Scheme, Gerald Jay Sussman.  Free oline version.
;;
;; https://mitpress.mit.edu/sites/default/files/sicp/index.html
;;
;;
;; The Little Schemer, 4th Edition.  How to think recursively in Scheme!  In print since the 1970s!
;; Co-written by my PhD advisor, Dan Friedman.
;;
;; https://mitpress.mit.edu/books/little-schemer-fourth-edition
;;
;;
;; The Scheme Programming Language, Fourth Edition, by R. Kent Dybvig.  Describes the Scheme programming language
;; in great detail.  Kent is the creator of Chez Scheme.
;;
;; https://scheme.com/tspl4/
;;
;;
;; How to Design Programs, 2nd Edition.  Free online version.  Introductory programming book, using Racket,
;; written by the creators of Racket.
;;
;; https://htdp.org/



;; (Safe to ignore this for right now.)
;; namespace magic to make 'eval' work properly in the file (as opposed to in the REPL)
;;
;; https://stackoverflow.com/questions/20778926/mysterious-racket-error-define-unbound-identifier-also-no-app-syntax-trans
(define-namespace-anchor anc)
(define ns (namespace-anchor->namespace anc))


;; Simple definition, and use of lambda.
(define square (lambda (n) (* n n)))
(square 3)
(square (square 3))

;; using an anonymous function created with lambda!
((lambda (n) (* n n)) 3)


;; another simple function definition
(define add
  (lambda (n m)
    (+ n m)))

(add 3 4)

;; Curried adder
;;
;; https://en.wikipedia.org/wiki/Currying
(define make-adder
  (lambda (n)
    (lambda (m)
      (add n m))))

(define add3 (make-adder 3))
(add3 4)

((make-adder 3) 4)

;; map
(map add1 '(1 2 3 4 5 6))
(map sqr '(1 2 3 4 5 6))
(map (lambda (n) (expt n n)) '(1 2 3 4 5 6))

;; filter
(filter even? '(1 2 3 4 5 6))

;; Implementing 'prime?' is an exercise left to the reader!  :)
;;
;; If you are up for a challenge, you might try implementing:
;;
;; https://en.wikipedia.org/wiki/Miller%E2%80%93Rabin_primality_test
(define prime? (lambda (n) '???))

(filter (lambda (n) (> n 3)) '(1 2 3 4 5 6))

;; practice with lists
'(1 2 3)
(cons 0 '(1 2 3))
(first '(1 2 3)) ;; same as (car '(1 2 3))
(rest '(1 2 3))  ;; same as (cdr '(1 2 3))

;; consing up a list
'()  ;; the empty list
(cons 3 '()) ;; (3)
(cons 2 (cons 3 '())) ;; (2 3)
(cons 1 (cons 2 (cons 3 '()))) ;; (1 2 3)

;; quoted symbols (not strings!  strings are different from symbols in Scheme)
'knight
'rook
'bishop

;; in Scheme, code is represented as S-expressions:
;;
;; https://en.wikipedia.org/wiki/S-expression
;;
;; If we quote an S-expression using the quote mark ('), the S-expression
;; becomes *data* we can manipulate, rather than an *expression* that is evaluated by Scheme.
(cons '+ (cons 3 (cons 4 '())))

;; In Scheme we can treat code as data, and data as code!  An extremely powerful technique.
(define expr (cons '+ (cons 3 (cons 4 '())))) ;; (+ 3 4)
(define new-expr (cons '* (rest expr)))       ;; (* 3 4)     we just created a new expression from the old one, swapping * for +!
(define newer-expr (cons 'expt (rest expr)))  ;; (expt 3 4)  we just created a new expression from the old one, swapping expt for +!
(define newest-expr                           ;; ((lambda (n m) (- (* n m) (expt n m)) 3 4)  same thing, but swapping in a lambda expr
  (cons '(lambda (n m) (- (* n m) (expt n m)))
        (rest expr)))

(define make/eval-expr ;; function that takes an operator expression, like '* or '+ or '(lambda (n m) (- (* n m) (expt n m)) 3 4),
  (lambda (operator)   ;; creates a new expression like (* 3 4), (+ 3 4), or ((lambda (n m) (- (* n m) (expt n m)) 3 4),
    (eval (cons operator (cons 3 (cons 4 '()))) ns))) ;; then calls 'eval' to evaluate the resulting expression.

(make/eval-expr '*)

(make/eval-expr '+)

(make/eval-expr '(lambda (n m) (- (* n m) (expt n m))))


;; You can directly define (or redefine) the syntax of Scheme
(define-syntax my-let
  (syntax-rules ()
    [(my-let ((y e)) body)
     ((lambda (y) body)
      e)]))

(my-let ((x (+ 3 4)))
  (* x x))
;;
;; expands to
;;
;((lambda (x) (* x x))
; (+ 3 4)
     


;; Collatz function
;;
;; https://en.wikipedia.org/wiki/Collatz_conjecture
(define C
  (lambda (n)
    (if (= n 1)
        'finished
        (if (even? n)
            (C (/ n 2))
            (C (+ (* n 3) 1))))))

(C 5)
(C 100)
(C 1000)


;; Other things mentioned in lab:
;;
;; Ubuntu on Windows:
;; https://docs.microsoft.com/en-us/windows/wsl/install-win10
;;
;; Two's complement representation of signed integers in Java:
;; https://en.wikipedia.org/wiki/Two's_complement
;;
;; World's First Classical Chinese Programming Language
;; https://spectrum.ieee.org/tech-talk/computing/software/classical-chinese