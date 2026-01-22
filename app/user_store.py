# app/user_store.py

from typing import Dict, List, Optional

class UserStore:
    def __init__(self):
        self.users: Dict[str, Dict] = {}

    def get_or_create_user(self, user_id: str) -> Dict:
        if user_id not in self.users:
            self.users[user_id] = {
                "user_id": user_id,
                "quiz_history": [],
                "study_plans": [],
                "predicted_grade": None,
                "risk_level": "UNKNOWN"
            }
        return self.users[user_id]

    def add_quiz_result(self, user_id: str, result: Dict):
        self.get_or_create_user(user_id)["quiz_history"].append(result)

    def add_study_plan(self, user_id: str, plan: Dict):
        self.get_or_create_user(user_id)["study_plans"].append(plan)

    def set_predicted_grade(self, user_id: str, grade: str):
        self.get_or_create_user(user_id)["predicted_grade"] = grade

    def set_risk_level(self, user_id: str, risk: str):
        self.get_or_create_user(user_id)["risk_level"] = risk
