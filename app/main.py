from fastapi import FastAPI
from pydantic import BaseModel
from typing import List, Dict

from app.user_store import UserStore
from app.quiz_engine import QuizEngine
from app.prediction_engine import PredictionEngine
from app.study_plan_engine import StudyPlanEngine
from app.risk_engine import RiskEngine
from app.trend_engine import TrendEngine
from app.event_consumer import emit_event, start_consumer

app = FastAPI(title="Studyora AI Service")

user_store = UserStore()

quiz_engine = QuizEngine()
prediction_engine = PredictionEngine()
study_plan_engine = StudyPlanEngine()
risk_engine = RiskEngine()
trend_engine = TrendEngine()

@app.on_event("startup")
def startup():
    start_consumer()

# ---------- Models ----------

class QuizRequest(BaseModel):
    user_id: str
    subject: str
    difficulty: str
    past_score: float

class QuizResultRequest(BaseModel):
    user_id: str
    subject: str
    score: float

class PredictionRequest(BaseModel):
    user_id: str
    study_frequency: int
    missed_sessions: int
    quiz_scores: List[float]

class StudyPlanRequest(BaseModel):
    user_id: str
    availability: Dict[str, List[str]]
    subjects: List[str]
    weak_subjects: List[str]

# ---------- Routes ----------

@app.post("/studyora/quiz")
def generate_quiz(request: QuizRequest):
    quiz = quiz_engine.generate_quiz(
        request.subject,
        request.difficulty,
        request.past_score
    )
    return {"quiz": quiz}

@app.post("/studyora/quiz-result")
def submit_quiz_result(request: QuizResultRequest):
    user_store.add_quiz_result(
        request.user_id,
        {"subject": request.subject, "score": request.score}
    )
    return {"status": "saved"}

@app.post("/studyora/study-plan")
def generate_study_plan(request: StudyPlanRequest):
    plan = study_plan_engine.generate_plan(
        request.availability,
        request.subjects,
        request.weak_subjects
    )
    user_store.add_study_plan(request.user_id, plan)
    return {"study_plan": plan}

@app.post("/studyora/predict")
def predict(request: PredictionRequest):
    grade = prediction_engine.predict_grade(
        request.study_frequency,
        request.missed_sessions,
        request.quiz_scores
    )

    user_store.set_predicted_grade(request.user_id, grade)

    user = user_store.get_or_create_user(request.user_id)
    previous_risk = user["risk_level"]

    trend = trend_engine.detect_trend(user["quiz_history"])
    new_risk = risk_engine.assess_risk(user)

    user_store.set_risk_level(request.user_id, new_risk)

    risk_drift = risk_engine.detect_risk_drift(previous_risk, new_risk)

    emit_event("PERFORMANCE_ANALYSIS", {
        "user_id": request.user_id,
        "trend": trend,
        "risk_drift": risk_drift
    })

    return {
        "user_id": request.user_id,
        "predicted_grade": grade,
        "risk_level": new_risk,
        "trend": trend,
        "risk_drift": risk_drift
    }

@app.get("/studyora/user/{user_id}")
def get_user(user_id: str):
    return user_store.get_or_create_user(user_id)
