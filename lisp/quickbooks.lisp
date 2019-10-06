(ql:quickload :drakma)
(ql:quickload :flexi-streams)
(ql:quickload :qbase64)
(ql:quickload :cl-json)

(defparameter *sandbox-company-id* (string "4620816365016386660"))
(defparameter *prod-company-id* (string "193514537028129"))
(defparameter *sandbox-api* (string "https://sandbox-quickbooks.api.intuit.com/v3/company/"))
(defparameter *prod-api* (string "https://quickbooks.api.intuit.com/v3/company/"))
(defparameter *company-id* *prod-company-id*)
(defparameter *api* *prod-api*)

(defun make-auth-header (token) (concatenate 'string "Bearer " token))
(defun make-basic-auth-header ()
  (let* ((client-id (sb-unix::posix-getenv "QB_CLIENT"))
        (client-secret (sb-unix::posix-getenv "QB_SECRET"))
        (encoded-string (qbase64:encode-bytes (string-to-octets (concatenate 'string client-id ":" client-secret))))
        (final-string (concatenate 'string "Basic " encoded-string)))
  final-string
  )
)
(defun make-qb-request (route token)
  (map 'string 'code-char
        (drakma:http-request
          (concatenate 'string *api* route)
          :accept "application/json"
          :content-type "application/json"
          :additional-headers `(("Authorization" . ,(make-auth-header token))))))

(defun refresh-token ()
  (let* ((rtoken (sb-unix::posix-getenv "QB_REFRESH_TOKEN"))
        (route "https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer"))
    (map 'string 'code-char
         (drakma:http-request
           route
           :method :post
           :parameters `(("grant_type" . "refresh_token")
                        ("refresh_token" . ,(string rtoken)))
           :accept "application/json"
           :content-type "application/x-www-form-urlencoded"
           :additional-headers `(("Authorization" . ,(make-basic-auth-header)))))))
(defun get-profit-and-loss (date-macro token)
  (make-qb-request (concatenate 'string *company-id* "/reports/ProfitAndLoss?date_macro=" date-macro "&minorversion=12") token))

(defun request-as-json (function &rest args)
  (with-input-from-string
        (s (apply function args))
          (json:decode-json s)))

(defun start ()
  (let* ((token-request (request-as-json #'refresh-token))
         (token (cdr (assoc :access--token token-request)))
         (last-week (request-as-json #'get-profit-and-loss "Last%20Week" token)))
; First, we need to grab a token, so that we can make API requests to QuickBooks
    (print last-week)
    (print token)))
