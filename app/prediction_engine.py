class PredictionEngine:
    def predict_grade(self, study_frequency, missed_sessions, quiz_scores):
        avg = sum(quiz_scores) / len(quiz_scores)

        if avg >= 85 and missed_sessions <= 1:
            return "A"
        elif avg >= 70:
            return "B"
        return "C"
