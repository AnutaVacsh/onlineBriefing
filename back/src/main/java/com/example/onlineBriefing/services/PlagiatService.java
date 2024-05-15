package com.example.onlineBriefing.services;

import com.example.onlineBriefing.models.AnswerStudent;
import com.example.onlineBriefing.models.Plagiat;
import com.example.onlineBriefing.models.Question;
import com.example.onlineBriefing.repositories.AnswerStudentRepository;
import com.example.onlineBriefing.repositories.PlagiatRepository;
import com.example.onlineBriefing.repositories.QuestionRepository;
import org.aspectj.weaver.patterns.TypePatternQuestions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Service
public class PlagiatService {

    @Autowired
    private PlagiatRepository plagiatRepository;
    @Autowired
    private AnswerStudentRepository answerStudentRepository;
    @Autowired
    private QuestionRepository questionRepository;

    public Boolean plagiatCheckAll(List<AnswerStudent> answerStudents) {
        for (AnswerStudent answerStudent : answerStudents) {
            if (!plagiatCheck(answerStudent)) {
                return false;
            }
        }
        return true;
    }

    public Boolean plagiatCheck(AnswerStudent answerStudent) {
        Question question = questionRepository.findById(answerStudent.getQuestion()).get();
        if (!Objects.equals(question.getTypeVerification(), "автоматически")) {
            List<AnswerStudent> answerStudents = answerStudentRepository.findAllByQuestion(answerStudent.getQuestion());
            double similarity;
            for (AnswerStudent answer : answerStudents) {
                similarity = calculateLevenshteinDistance(answer.getText(), answerStudent.getText());
                if (similarity > 0.8) {
                    plagiatRepository.save(new Plagiat(answer.getIdStudent(), answerStudent.getIdStudent()));
                    return false;
                }
            }
        }
        return true;
    }

    public static double calculateLevenshteinDistance(String word1, String word2) {
        int maxLength = Math.max(word1.length(), word2.length());

        int[][] dp = new int[word1.length() + 1][word2.length() + 1];

        for (int i = 0; i <= word1.length(); i++) {
            dp[i][0] = i;
        }

        for (int j = 0; j <= word2.length(); j++) {
            dp[0][j] = j;
        }

        for (int i = 1; i <= word1.length(); i++) {
            for (int j = 1; j <= word2.length(); j++) {
                int cost = (word1.charAt(i - 1) == word2.charAt(j - 1)) ? 0 : 1;

                dp[i][j] = Math.min(dp[i - 1][j] + 1,
                        Math.min(dp[i][j - 1] + 1,
                                dp[i - 1][j - 1] + cost));
            }
        }

        return (double) (maxLength - dp[word1.length()][word2.length()]) / maxLength;
    }
}

