# app/learning_state.py

class LearningState:
    def __init__(self):
        self.quiz_history = []
        self.weak_subjects = set()

    def add_quiz_result(self, subject: str, score: float):
        self.quiz_history.append({
            "subject": subject,
            "score": score
        })

        # Weak subject logic
        if score < 60:
            self.weak_subjects.add(subject)
        else:
            self.weak_subjects.discard(subject)

    def get_average_score(self):
        if not self.quiz_history:
            return 0
        return sum(q["score"] for q in self.quiz_history) / len(self.quiz_history)

    def get_weak_subjects(self):
        return list(self.weak_subjects)
