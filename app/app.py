from flask import Flask, render_template
from database import Database
from dotenv import load_dotenv
import os

load_dotenv()

app = Flask(__name__)

@app.route('/')
def movie_list():
    db = Database(
        host=os.getenv('DB_HOST'),
        database=os.getenv('DB_NAME'),
        user=os.getenv('DB_USER'),
        password=os.getenv('DB_PASSWORD')
    )
    movies = db.read_movies()
    db.close_connection()
    return render_template('movies_list.html', movies=movies)

if __name__ == "__main__":
    app.run(debug=True)
