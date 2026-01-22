from sqlalchemy import Column, String, JSON
from app.database.session import Base

class User(Base):
    __tablename__ = "users"

    user_id = Column(String, primary_key=True, index=True)
    quiz_history = Column(JSON, default=list)
    study_plans = Column(JSON, default=list)
    predicted_grade = Column(String, nullable=True)
    risk_profile = Column(JSON, nullable=True)
