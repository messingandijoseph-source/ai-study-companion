class DecisionEngine:
    def decide_study_strategy(self, risk_level: str) -> dict:
        if risk_level == "HIGH":
            return {
                "extra_sessions": 2,
                "focus": "weak_subjects",
                "intensity": "HIGH"
            }
        if risk_level == "MEDIUM":
            return {
                "extra_sessions": 1,
                "focus": "balanced",
                "intensity": "MEDIUM"
            }
        return {
            "extra_sessions": 0,
            "focus": "maintenance",
            "intensity": "LOW"
        }
