(defun hello-world-file ()
  (with-open-file (my-stream
                    "helloworld.txt"
                    :direction :output
                    :if-exists :supersede)
    (princ "Hello World!" my-stream)))
