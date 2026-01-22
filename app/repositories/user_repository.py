from sqlalchemy.orm import Session
from app.database.models.user import User

class UserRepository:

    def get_or_create(self, db: Session, user_id: str) -> User:
        user = db.query(User).filter(User.user_id == user_id).first()
        if not user:
            user = User(
                user_id=user_id,
                quiz_history=[],
                study_plans=[]
            )
            db.add(user)
            db.commit()
            db.refresh(user)
        return user

    def add_quiz_result(self, db: Session, user_id: str, result: dict):
        user = self.get_or_create(db, user_id)
        user.quiz_history.append(result)
        db.commit()

    def add_study_plan(self, db: Session, user_id: str, plan: dict):
        user = self.get_or_create(db, user_id)
        user.study_plans.append(plan)
        db.commit()

    def set_predicted_grade(self, db: Session, user_id: str, grade: str):
        user = self.get_or_create(db, user_id)
        user.predicted_grade = grade
        db.commit()

    def set_risk_profile(self, db: Session, user_id: str, risk: dict):
        user = self.get_or_create(db, user_id)
        user.risk_profile = risk
        db.commit()
