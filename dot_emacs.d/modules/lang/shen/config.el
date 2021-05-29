;;; lang/shen/config.el -*- lexical-binding: t; -*-

(use-package! shen-mode
  :defer t
  :init
  (after! shen-mode
    (set-repl-handler! 'shen-mode #'inferior-shen)
    (set-eval-handler! 'shen-mode #'+shen/shen-eval-region))

  :config
  (when (featurep! +prettify)
    (set-ligatures! '(shen-mode inferior-shen-mode)
      :lambda "/."
      :lambda "lambda"
      :and    "and"
      :or   "or"
      :def    "define"
      :true  "true"
      :false "false"
      :string "string"
      :float    "number"
      :bool   "bool"
      :list   "list"
      :tuple  "tuple")

    (defun +shen-details-interleave (sequence intermezzo)
      (let ((sequence (seq-reverse sequence)))
        (seq-reduce
                (lambda (acc elt) (cons elt (cons intermezzo acc)))
                (cdr sequence) (cons (car sequence) nil))))

    (defun +shen-details-prettified-sequence (pretty-sequence)
      (+shen-details-interleave (string-to-list pretty-sequence) '(Br . Bl)))

    (defun +shen-details-sequenced-substitions (alist)
      (mapcar
       (lambda (substitution)
         (let ((sequence (car substitution)) (pretty-sequence (cdr substitution)))
           (cons sequence (+shen-details-prettified-sequence pretty-sequence))))
       alist))

   (set-ligatures! '(shen-mode inferior-shen-mode) :alist
     (+shen-details-sequenced-substitions
      '(("append"   . ",")
       ("cn"       . ",")
       ("concat"   . ",")
       ("arity"    . "/n")
       ("boolean?" . "∈𝔹")
       ("cons"     . "x⋃")
       ("declare"  . "λx:T")
       ("defmacro" . "ƒΜ")
       ("defprolog" . "ƒ⊢")
       ("difference" . "∖")
       ("element?"   . "∈")
       ("empty?"     . "=∅")
       ("fail"       . "...")
       ("fix"        . "⍣=")
       ("integer?" . "∈ℤ")
       ("intersection" . "∩")
       ("language" . "L")
       ("length"       . "|S|")
       ("not"          . "¬")
       ("nth"          . "xₙ")
       ("number?" . "∈ℝ")
       ("n->string" . "ℝ↦𝕊")
       ("pos"   . "xₛ")
       ("reverse" . "ϕ")
       ("str" . "x↦𝕊")
       ("string?" . "∈𝕊")
       ("string->n" . "𝕊↦ℝ")
       ("subst" . "[x:=E]")
       ("sum" . "⅀")
       (">=" . "≥")
       ("<=" . "≤")))))

  (when (featurep! :editor rotate-text)
    (set-rotate-patterns! '(shen-mode inferiror-shen-mode)
      :symbols '(("true" "false")
                 ("<" "<=" ">" ">=")
                 ("+" "-")
                 ("<-vector" "vector->")
                 ("defmacro" "undefmacro")
                 ("profile" "unprofile")
                 ("put" "unput")
                 ("track" "untrack")
                 ("specialise" "unspecialise")
                 ("freeze" "thaw")
                 ("string->n" "n->string")
                 ("fst" "snd"))))

  (set-electric! '(shen-mode) :chars '(?\( ?\) ?\[ ?\] ?\n))
  (add-hook! '(shen-mode-hook inferior-shen-mode-hook) #'rainbow-delimiters-mode)

  (map! (:localleader
         :map shen-mode-map
         :desc "REPL" "'" #'inferior-shen
         :desc "New inferior-shen buffer" "R" #'+shen/new-inferior-shen
         :desc "Load file" "l" #'+shen/shen-load-file

         (:prefix ("e" . "evaluate")
          :desc "Evaluate region" "r" #'+shen/shen-eval-region
          :desc "Evaluate region and go" "R" #'+shen/shen-eval-region-and-go
          :desc "Evaluate function" "f" #'+shen/shen-eval-defun
          :desc "Evaluate function and go" "F" #'+shen/shen-eval-defun-and-go
          :desc "Evaluate last sexp" "e" #'+shen/shen-eval-last-sexp))))
