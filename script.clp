; Templates
(deftemplate professor
    (slot name (type STRING))
    (slot course-code (type STRING))
    (slot class (type STRING))
)

(deftemplate cover
    (slot course (type STRING))
    (slot section (type STRING))
)

(deftemplate know
    (slot prof (type STRING))
    (slot subj (type STRING))
)

(deftemplate message
    (slot code (type INTEGER))
    (slot parameters (type STRING)))

; Function declarations
(deffunction MAIN::add-professor (?name ?course-code ?class)
   (assert (professor 
      (name ?name) 
      (course-code ?course-code) 
      (class ?class)
   ))
   (printout t "Professor added successfully." crlf)
)

(deffunction MAIN::add-cover (?course ?section)
   (assert (cover 
      (course ?course) 
      (section ?section)
   ))
   (printout t "Cover added successfully." crlf)
)

(deffunction MAIN::generate-knows ()
   (run)
   (printout t "All 'know' facts have been generated." crlf)
)

(deffunction MAIN::retract-cover (?course)
   (bind ?deleted-count 0)
   (do-for-all-facts 
      ((?f cover)) 
      (eq ?f:course ?course)
      (retract ?f)
      (bind ?deleted-count (+ ?deleted-count 1))
   )
   (if (> ?deleted-count 0) then
      (printout t "Deleted " ?deleted-count " cover(s) for course: " ?course crlf)
   else
      (printout t "No covers found for course: " ?course crlf)
   )
)

(deffunction MAIN::list-courses ()
   (printout t crlf "--- Registered Courses ---" crlf)
   (do-for-all-facts 
      ((?c cover))
      TRUE
      (printout t "Course: " ?c:course ", Section: " ?c:section crlf)
   )
)

(deffunction MAIN::list-professors ()
   (printout t crlf "--- Registered Professors ---" crlf)
   (do-for-all-facts 
      ((?p professor))
      TRUE
      (printout t "Name: " ?p:name ", Course: " ?p:course-code ", Class: " ?p:class crlf)
   )
)

(deffunction MAIN::list-know-facts ()
   (printout t crlf "--- Know Facts ---" crlf)
   (do-for-all-facts 
      ((?k know))
      TRUE
      (printout t "Professor: " ?k:prof ", Subject: " ?k:subj crlf)
   )
)

(deffunction MAIN::exit-system ()
   (printout t "Exiting the program. Goodbye!" crlf)
   (exit)
)

; Message handler rule
(defrule MAIN::process-message
   ?msg <- (message (code ?code) (parameters ?parameters))
   =>
   (retract ?msg)
   (bind ?params (explode$ ?parameters)) ; Split parameters if needed
   
   (switch ?code
      (case 1 then
         (add-professor (nth$ 1 ?params) (nth$ 2 ?params) (nth$ 3 ?params))
      )
      (case 2 then
         (add-cover (nth$ 1 ?params) (nth$ 2 ?params))
      )
      (case 3 then
         (generate-knows)
      )
      (case 4 then
         (retract-cover (nth$ 1 ?params))
      )
      (case 5 then
         (list-courses)
      )
      (case 6 then
         (list-professors)
      )
      (case 7 then
         (list-know-facts)
      )
      (default 
         (printout t "Invalid code. Please try again." crlf)
      )
   )
)

; Rule to generate "know" facts
(defrule knows
   (professor (name ?x) (course-code ?y))
   (cover (course ?c) (section ?d))
   (test (eq ?y ?c))
   =>
   (printout t "This professor " ?x " knows " ?d "." crlf)
   (assert (know (prof ?x) (subj ?d)))
)


; Startup rule
(defrule MAIN::startup
   (declare (salience 100))
   (initial-fact)
   =>
   (printout t "Professor Knowledge Management System Initialized" crlf)
   (printout t "Send a message to interact with the system." crlf)
   (printout t "Available Commands:" crlf)
   (printout t "1. Add Professor: assert(message (code 1) (parameters \"<name> <course-code> <class>\"))" crlf)
   (printout t "2. Add Cover: assert(message (code 2) (parameters \"<course> <section>\"))" crlf)
   (printout t "3. Generate Know Facts: assert(message (code 3) (parameters \"\"))" crlf)
   (printout t "4. Retract Cover by Course: assert(message (code 4) (parameters \"<course>\"))" crlf)
   (printout t "5. List Courses: assert(message (code 5) (parameters \"\"))" crlf)
   (printout t "6. List Professors: assert(message (code 6) (parameters \"\"))" crlf)
   (printout t "7. List Know Facts: assert(message (code 7) (parameters \"\"))" crlf)
   (printout t "Example of a command to add a professor: assert(message (code 1) (parameters \"Dr. Smith COMP101 A1\"))" crlf)
)
