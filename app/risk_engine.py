# app/risk_engine.py

class RiskEngine:
    def assess_risk(self, user: dict) -> str:
        scores = [q["score"] for q in user["quiz_history"]]

        if not scores:
            return "UNKNOWN"

        avg_score = sum(scores) / len(scores)

        if avg_score < 50:
            return "HIGH"
        elif avg_score < 70:
            return "MEDIUM"
        else:
            return "LOW"

    def detect_risk_drift(self, previous: str, current: str) -> str:
        if previous == "UNKNOWN":
            return "NEW"

        levels = {"LOW": 1, "MEDIUM": 2, "HIGH": 3}

        if levels[current] > levels[previous]:
            return "INCREASING"
        elif levels[current] < levels[previous]:
            return "DECREASING"
        else:
            return "STABLE"
