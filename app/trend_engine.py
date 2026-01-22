# app/trend_engine.py

class TrendEngine:
    def detect_trend(self, quiz_history: list) -> dict:
        if len(quiz_history) < 3:
            return {
                "trend": "INSUFFICIENT_DATA",
                "direction": "FLAT",
                "confidence": "LOW"
            }

        scores = [q["score"] for q in quiz_history[-3:]]

        if scores[2] > scores[1] > scores[0]:
            return {
                "trend": "IMPROVING",
                "direction": "UP",
                "confidence": "HIGH"
            }

        if scores[2] < scores[1] < scores[0]:
            return {
                "trend": "DECLINING",
                "direction": "DOWN",
                "confidence": "HIGH"
            }

        return {
            "trend": "STABLE",
            "direction": "FLAT",
            "confidence": "MEDIUM"
        }
