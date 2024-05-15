package com.example.onlineBriefing.services;

import com.example.onlineBriefing.models.*;
import com.example.onlineBriefing.repositories.*;
import org.apache.catalina.Group;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.relational.core.sql.In;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class BriefingService {

    @Autowired
    private BriefingRepository briefingRepository;
    @Autowired
    private AnswerStudentRepository answerStudentRepository;
    @Autowired
    private QuestionRepository questionRepository;
    @Autowired
    private UniversityGroupRepository universityGroupRepository;
    @Autowired
    private StudentRepository studentRepository;
    @Autowired
    private SubjectRepository subjectRepository;
    @Autowired
    private ProfileRepository profileRepository;
    @Autowired
    private ProfileBriefingRepository profileBriefingRepository;

    public List<Briefing> getAllBriefingsByIdSubject(Integer idSubject) {
        return briefingRepository.findAllByIdSubject(idSubject);
    }

    //РЕЗУЛЬТАТЫ ЛЕТУЧКИ
    public Double getEstimationBriefingStudent(Integer idBriefing, Integer idStudent) {
        List<Question> questions = questionRepository.findAllByBriefing(idBriefing);
        BigDecimal sum = BigDecimal.ZERO; // Используем константу BigDecimal.ZERO для инициализации суммы
        int count = 0;
        for (Question question : questions) {
            AnswerStudent answerStudent = answerStudentRepository.findByQuestionAndIdStudent(question.getId(), idStudent);
            if (answerStudent != null && answerStudent.getAccuracy_percent() != null) {
                sum = sum.add(answerStudent.getAccuracy_percent()); // Используем метод add() для добавления BigDecimal к сумме
            }
            count++;
        }
        BigDecimal average = BigDecimal.ZERO;
        if (count != 0) {
            average = sum.divide(BigDecimal.valueOf(count), 2, RoundingMode.HALF_UP); // Вычисляем среднее значение с точностью до двух знаков после запятой
        }
        return average.doubleValue();
    }

    //Средний балл по предмету
    public double calculateAverageGradeBySubject(Integer idStudent, Integer subject) {
        List<Briefing> briefings = getAllBriefingsByIdSubject(subject);
        double sum = 0;
        int count = 0;
        double estimate;
        for (Briefing briefing :
                briefings) {
            estimate = getEstimationBriefingStudent(briefing.getId(), idStudent);
            sum += estimate;
            count += 1;
        }
        return sum / count;
    }

    //Средний балл по вопросам летучки группы
    public Map<Question, Double> getQuestionAvgGrade(Integer briefing, Integer group) {
        List<Question> questions = questionRepository.findAllByBriefing(briefing);
        BigDecimal sum;
        int count;
        List<AnswerStudent> answerStudents;
        Map<Question, Double> res = new HashMap<>();
        BigDecimal average = BigDecimal.ZERO;
        for (Question question : questions) {
            count = 0;
            sum = BigDecimal.ZERO;
            answerStudents = answerStudentRepository.findAllByQuestion(question.getId());
            for (AnswerStudent answerStudent : answerStudents) {
                if (Objects.equals(studentRepository.findById(answerStudent.getIdStudent()).get().getIdGroup(), group)) {
                    count++;
                    sum = sum.add(answerStudent.getAccuracy_percent());
                }
            }
            if (count != 0) {
                average = sum.divide(BigDecimal.valueOf(count), 2, RoundingMode.HALF_UP); // Вычисляем среднее значение с точностью до двух знаков после запятой
            }
            res.put(question, average.doubleValue());
        }
        return res;
    }
    //Средний балл группы по летучке
    public Double getBriefingAvgGrade(Integer briefing, Integer group) {
        List<Question> questions = questionRepository.findAllByBriefing(briefing);
        BigDecimal sum= BigDecimal.ZERO;
        int count = 0;
        List<AnswerStudent> answerStudents;
        BigDecimal average = BigDecimal.ZERO;
        for (Question question : questions) {
            answerStudents = answerStudentRepository.findAllByQuestion(question.getId());
            for (AnswerStudent answerStudent : answerStudents) {
                if (Objects.equals(studentRepository.findById(answerStudent.getIdStudent()).get().getIdGroup(), group)) {
                    count++;
                    sum = sum.add(answerStudent.getAccuracy_percent());
                }
            }
        }
        if (count != 0) {
            average = sum.divide(BigDecimal.valueOf(count), 2, RoundingMode.HALF_UP); // Вычисляем среднее значение с точностью до двух знаков после запятой
        }
        return average.doubleValue();
    }
    //Средний балл по летучкам среди всех групп
    public Map<Briefing, Double> getQuestionAvgGrade(Integer subject) {
        List<Briefing> briefings = getAllBriefingsByIdSubject(subject);
        List<UniversityGroup> universityGroups = new ArrayList<>();
        Map<Briefing, Double> res = new HashMap<>();
        int count;
        Double sum;
        for (Briefing briefing : briefings) {
            Integer profile_id = profileBriefingRepository
                    .findByBriefing(briefing.getId())
                    .getProfile();
            universityGroups = universityGroupRepository.findAllByIdProfile(profile_id);
            count=0;
            sum=0.0;
            for (UniversityGroup universityGroup: universityGroups){
                sum+=getBriefingAvgGrade(briefing.getId(), universityGroup.getId());
                count++;
            }
            res.put(briefing, sum/count);
        }
        return res;
    }

    //Получить место в топе и лучший балл
    public String getTopStudent(Integer idStudent, Integer subject) {
        Map<Integer, Double> top = getTop(subject);
        int position = getStudentPositionInTop(top, idStudent);
        Double max = top.values().iterator().next();
        return "Ваше место в рейтинге " + position + " Лучший балл в топе: " + max;
    }

    private static int getStudentPositionInTop(Map<Integer, Double> sortedScores, Integer idStudent) {
        int position = 1;
        for (Map.Entry<Integer, Double> entry : sortedScores.entrySet()) {
            if (entry.getKey().equals(idStudent)) {
                return position;
            }
            position++;
        }
        return -1; // Если студент не найден
    }
    //Топ студентов по id
    public Map<Integer, Double> getTop(Integer subject) {
        Integer profileId = subjectRepository.findById(subject).get().getId();
        List<UniversityGroup> groups = universityGroupRepository.findAllByIdProfile(profileId);
        List<Student> students = new ArrayList<>();
        for (UniversityGroup group :
                groups) {
            students.addAll(studentRepository.findAllByIdGroup(group.getId()));
        }
        Map<Integer, Double> studentsMap = new HashMap<>();
        for (Student s : students) {
            studentsMap.put(s.getId(), calculateAverageGradeBySubject(s.getId(), subject));
        }
        return studentsMap.entrySet()
                .stream()
                .sorted(Map.Entry.comparingByValue(Comparator.reverseOrder())) // Сортировка по убыванию
                .collect(Collectors.toMap(
                        Map.Entry::getKey,
                        Map.Entry::getValue,
                        (e1, e2) -> e1,
                        LinkedHashMap::new
                ));
    }
    //Топ студентов
    public Map<Student, Double> getTopStudents(Integer subject, Integer group) {

        Map<Integer, Double> top = getTop(subject);
        Map<Student, Double> studentTop = new LinkedHashMap<>(); // Используем LinkedHashMap для сохранения порядка

        for (Map.Entry<Integer, Double> entry : top.entrySet()) {
            Integer studentId = entry.getKey();
            Double averageGrade = entry.getValue();
            Student student = studentRepository.findById(studentId).orElse(null); // Извлекаем объект Student по ID
            if (student != null) {
                if (Objects.equals(student.getIdGroup(), group)) {
                    studentTop.put(student, averageGrade); // Добавляем в карту
                }
            }
        }
        return studentTop;
    }

    public List<Double> getAllScores(Integer idStudent, Integer subject) {
        List<Briefing> briefings = getAllBriefingsByIdSubject(subject);
        List<Double> scores = new ArrayList<>();
        for (Briefing briefing :
                briefings) {
            scores.add(getEstimationBriefingStudent(briefing.getId(), idStudent));
        }
        return scores;
    }
    public Optional<Briefing> findBriefingById(Integer id) {
        return briefingRepository.findById(id);
    }

    public Briefing addBriefing(Briefing briefing) {
        return briefingRepository.save(briefing);
    }

    public List<Briefing> findAllBriefings() {
        return briefingRepository.findAll();
    }

}
