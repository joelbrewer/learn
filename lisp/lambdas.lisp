; Lambda = anyonymous function (function sans name)

; Use lambda to add four to each element in a list
(mapcar (lambda (n) (+ n 4)) '(4 8 12))

; Use lambda to write a function that suqares then sums a list
(defun sum-squares (lst)
  (reduce #'+ (mapcar (lambda (n) (* n n)) lst)))
