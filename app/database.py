import mysql.connector
from mysql.connector import Error

class Database:
    def __init__(self, host, database, user, password):
        self.connection = self.create_connection(host, database, user, password)

    def create_connection(self, host, database, user, password):
        try:
            connection = mysql.connector.connect(
                host=host,
                database=database,
                user=user,
                password=password
            )
            if connection.is_connected():
                print("Connection to MySQL database is successful")
            return connection
        except Error as e:
            print(f"Error: {e}")
            return None

    def create_movie(self, name, description, year):
        cursor = self.connection.cursor()
        query = "INSERT INTO Movies (name, description, year) VALUES (%s, %s, %s)"
        cursor.execute(query, (name, description, year))
        self.connection.commit()
        print("Movie created successfully")

    def read_movies(self):
        cursor = self.connection.cursor()
        query = "SELECT * FROM Movies"
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows

    def update_movie(self, movie_id, name, description, year):
        cursor = self.connection.cursor()
        query = "UPDATE Movies SET name = %s, description = %s, year = %s WHERE id = %s"
        cursor.execute(query, (name, description, year, movie_id))
        self.connection.commit()
        print("Movie updated successfully")

    def delete_movie(self, movie_id):
        cursor = self.connection.cursor()
        query = "DELETE FROM Movies WHERE id = %s"
        cursor.execute(query, (movie_id,))
        self.connection.commit()
        print("Movie deleted successfully")

    def search_movies_by_year(self, year):
        cursor = self.connection.cursor()
        query = "SELECT * FROM Movies WHERE year = %s"
        cursor.execute(query, (year,))
        rows = cursor.fetchall()
        for row in rows:
            print(row)

    def get_movies_by_author(self, author_name):
        cursor = self.connection.cursor()
        query = """
        SELECT Movies.id, Movies.name, Movies.description, Movies.year
        FROM Movies
        JOIN Movies_Authors ON Movies.id = Movies_Authors.movie_id
        JOIN Authors ON Movies_Authors.author_id = Authors.id
        WHERE Authors.name = %s
        """
        cursor.execute(query, (author_name,))
        rows = cursor.fetchall()
        for row in rows:
            print(row)

    def close_connection(self):
        if self.connection.is_connected():
            self.connection.close()
            print("Connection to MySQL database is closed")
