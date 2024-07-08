import mysql.connector
import os
import time

time.sleep(20)
# Creating user table if does not exsist
def create_table():
    """Creating users tabale if doesnt exsist"""
    try:
        conn = mysql.connector.connect(
            host=os.environ.get('MYSQL_HOST'),
            user=os.environ.get('MYSQL_ROOT_USER'),
            password=os.environ.get('MYSQL_ROOT_PASSWORD'),
            database=os.environ.get('MYSQL_DATABASE')
        )
        cursor = conn.cursor()
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS users (
                name TEXT,
                age INT
            );
        ''')
        conn.commit()
        cursor.close()
        conn.close()
    except Exception as e:
        print("Cant connect to db", e)

if __name__ == "__main__":
    create_table()