from app.database.session import engine, Base
from app.database.models.user import User

def init_db():
    Base.metadata.create_all(bind=engine)

if __name__ == "__main__":
    init_db()
