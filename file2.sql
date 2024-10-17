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


-- Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze


-- Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)


-- Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui
-- sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome


-- Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti


-- Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)


-- BONUS: Selezionare per ogni studente il numero di tentativi sostenuti
-- per ogni esame, stampando anche il voto massimo. Successivamente,
-- filtrare i tentativi con voto minimo 18.