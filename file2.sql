-- GROUP BY

-- Contare quanti iscritti ci sono stati ogni anno
SELECT COUNT(`id`) as `numero_di_iscritti` , YEAR(`enrolment_date`) as `anno_di_iscrizione` 
FROM `students` 
GROUP BY `anno_di_iscrizione`;

-- Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT COUNT(`id`) as `numero_di_insegnati` , `office_address`
FROM `teachers`
GROUP BY `office_address`;

-- Calcolare la media dei voti di ogni appello d'esame
SELECT AVG(`vote`) as `media_voti`, `exam_id` as `appello_esame`
FROM `exam_student`
GROUP BY `exam_id`;

-- Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT COUNT(`name`) as `corsi_di_laurea`, `department_id` as `dipartimento`  
FROM `degrees`
GROUP BY `department_id`;



-- JOIN

-- Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT `students`.`name`, `students`.`surname`, `degrees`.`name`
FROM `degrees`
JOIN `students` ON `students`. `degree_id` = `degrees`.`id`
WHERE `degrees`.`name` = 'Corso di Laurea in Economia';

-- Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
SELECT *
FROM `departments`
JOIN `degrees`
ON `degrees`.`department_id` = `departments`.`id`
WHERE `degrees`.`level` = 'Magistrale'
AND `departments`.`name` = 'Dipartimento di Neuroscienze'

-- Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT `teachers`.`name`, `teachers`.`surname`, `courses`.`name` 
FROM `teachers`
JOIN `course_teacher` ON `course_teacher`.`teacher_id` = `teachers`.`id`
JOIN `courses` ON `course_teacher`.`course_id` = `courses`.`id`
WHERE `teachers`.`id` = 44;

-- Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui
-- sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT `students`.`surname`, `students`.`name`, `degrees`.`name`, `degrees`.`level`, `departments`.`name`
FROM `departments`
JOIN `degrees` ON `degrees`.`department_id` = `departments`.`id`
JOIN `students`ON `students`.`degree_id` = `degrees`.`id`
ORDER BY `students`.`surname` ASC;

-- Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT `degrees`.`name`, `courses`.`name`, `teachers`.`surname`, `teachers`.`name`
FROM `degrees` 
JOIN `courses` ON `courses`.`degree_id` = `degrees`.`id`
JOIN `course_teacher` ON `course_teacher`.`course_id` = `courses`.`id`
JOIN `teachers` ON `course_teacher`.`teacher_id` = `teachers`.`id`;

-- Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
SELECT DISTINCT `teachers`.`name`, `departments`.`name`
FROM `departments`
JOIN `degrees`ON `degrees`.`department_id` = `departments`.`id`
JOIN `courses` ON `courses`.`degree_id` = `degrees`.`id`
JOIN `course_teacher`ON `course_teacher`.`course_id` = `courses`.`id`
JOIN `teachers` ON `course_teacher`.`teacher_id` = `teachers`.`id`
WHERE `departments`.`name`= 'Dipartimento di Matematica'  
ORDER BY `teachers`.`name` ASC;

SELECT DISTINCT `teachers`.`name`, `teachers`.`surname`, `teachers`.`phone`, `teachers`.`email`, `teachers`.`office_address`, `teachers`.`office_number`
FROM `teachers` 
JOIN `course_teacher` ON `teachers`.`id` = `course_teacher`.`teacher_id`
JOIN `courses` ON `course_teacher`.`course_id` = `courses`.`id`
JOIN `degrees` ON `courses`.`degree_id` = `degrees`.`id`
JOIN `departments` ON `degrees`.`department_id` = `departments`.`id`
WHERE `departments`.`name` = 'Dipartimento di Matematica';

-- BONUS: Selezionare per ogni studente il numero di tentativi sostenuti
-- per ogni esame, stampando anche il voto massimo. Successivamente,
-- filtrare i tentativi con voto minimo 18.
SELECT `students`.`id`, `students`.`name`, `students`.`surname`, MAX(`exam_student`.`vote`) AS `maximum_vote`, `courses`.`name`, COUNT(`exam_student`.`vote`) as `numero_tentativi_appello`
FROM `students`
JOIN `exam_student` ON `students`.`id` = `exam_student`.`student_id`
JOIN `exams` ON `exams`.`id` = `exam_student`.`exam_id`
JOIN `courses` ON `courses`.`id` = `exams`.`course_id`
GROUP BY `students`.`id`, `courses`.`id`
HAVING `maximum_vote` >= 18;