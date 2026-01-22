class QuizEngine:
    def generate_quiz(self, subject, difficulty, past_score):
        return {
            "subject": subject,
            "difficulty": difficulty,
            "question": f"Sample {difficulty} question in {subject}",
            "hint": "Think step by step"
        }
