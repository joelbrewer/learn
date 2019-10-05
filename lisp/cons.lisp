(cons 1 (cons 2 (cons 3 nil)))

; You can create 'dotted lists' by creating a list that doesn't end with the usual nil
(cons 1 (cons 2 3))

; We can use dotted lists to represent pairs
(cons 2 3)

; Playing with self-referential data stuctures...
(setf *print-circle* t)

(defparameter foo '(1 2 3))

(setf (cdddr foo) foo)

; Association Lists (alists for short) - key/value pairs stored in a list
; While a great way to store small amounts of data, alists are not very efficient
; with larger amounts of data (over a dozen items)
(defparameter *drink-order* '((tanya . rose)
                              (joel . old-fashioned)
                              (dad . ipa)
                              (mom . water)))

; Tree-like data

(defparameter *family-tree* '((joel (melanie (fred june))
                                   (david (bob theresa)))
                             (tanya (kim rj))))
