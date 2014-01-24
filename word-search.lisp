;;;; word-search.lisp

(in-package #:word-search)

;;; "word-search" goes here. Hacks and glory await!

(defparameter *dictionary-path* nil
 "Path to the dictionary File")

(defparameter *dictionary-hash* nil
  "Hash for dictionary-access")


(defun find-word (length char-pool)
  "Just call this function to find words with specific length (Integer) which can be built from the characters in char-pool (String)
Each character in char-pool is used only once.
Initialization is done automatically."
  (unless *dictionary-hash* (init))
  (find-word-intern length (string-upcase char-pool)))



(defun init ()
  "Call this function directly to initilize or reinitialize the word-database in *dictionary-hash*"
  (setf *dictionary-path* (asdf:system-relative-pathname 'word-search  "german.dic"))
  (setf *dictionary-hash* (make-hash-table :test 'eq :size 1700000))
  (read-word-list *dictionary-path* *dictionary-hash*))
	

(defun read-word-list (&optional (word-list-file *dictionary-path*) (dictionary-hash *dictionary-hash*))
  "Read list of words into hash-table.
Convert all words to upcase"
  (with-open-file (s word-list-file :external-format :iso-8859-1)
    (loop for line = (read-line s nil)
	  while line
       do (when (stringp line)
	    (let ((length (1- (length line))))
	      (when (> length 0)
		(push (string-upcase (subseq line 0 length)) (gethash length dictionary-hash))))))))


(defun find-word-intern (length char-pool &optional (word-hash *dictionary-hash*))
  "Finds word with length which can be build from the characters in char-pool.
Each character in char-pool can only be used once"
  (let ((words (gethash length word-hash)))
    (loop for word in words
	 when (check-word-build word char-pool) collect word)))

    
    

(defun check-word-build (word char-pool)
  "Create character-hash-pools from the word and the char-pool and check if it is possible to build word from the characters in char-pool"
  (let ((w-hash (make-character-pool-hash word))
	(cp-hash (make-character-pool-hash char-pool)))
    (loop for k being the hash-keys in w-hash using (hash-value v)
;	 do (format t "~A -> ~A  - ~A : ~A~%" k v (gethash k cp-hash)  (and (gethash k cp-hash) (<= v (gethash k cp-hash)))))))
	 always (and (gethash k cp-hash)
		     (<= v (gethash k cp-hash))))))
    
  


(defun make-character-pool-hash (char-pool)
  "Create hash with characters from char-pool as key and the amount of each character in char-pool as value
'aabc' results in the following hash:
a -> 2
b -> 1
c -> 1"
  (let ((char-pool-hash (make-hash-table :test 'eq)))
    (loop for c across char-pool
       do (if (gethash c char-pool-hash)
	      (incf (gethash c char-pool-hash))
	      (setf (gethash c char-pool-hash) 1)))
    char-pool-hash))
  


(defun test ()
  "Function for testing"
  (init)
  ;(sb-ext:gc :full t)
  ;(room)
  (time (read-word-list)))


;(time (progn (read-word-list) 'done))