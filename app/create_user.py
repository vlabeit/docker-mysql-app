import mysql.connector
import os
from log_handler import logger, mysql_log


def data_insert():
    """Insert age and name from input to db """
    while True:
        print("\033[32m" + '\033[1m' + "Enter name and age to create user," + '\033[31m' + " enter exit to quit" + '\033[0m')
        name = str(input("provide name:")).strip()
        if not name:
            print("Name is required")
            continue        
        if name == 'exit':
            print("Exit completed...")
            break
        try:
            age = int(input("Provide your age:"))
            if age <= 0:
                print("Age can't be less than 0")
                continue
        except Exception as e:
            print("Age is not a valid number")  
            continue  
        try:
            # Getting mysql data log
            mysql_data = mysql_log()
            print("Connecting to db")
            
            conn = mysql.connector.connect(
                host=os.getenv('MYSQL_HOST'),
                user=os.getenv('MYSQL_ROOT_USER'),
                password=os.getenv('MYSQL_ROOT_PASSWORD'),
                database=os.getenv('MYSQL_DATABASE'),
                ssl_disabled=True
            )
            cursor = conn.cursor()
            insert_query = f"INSERT INTO users (name, age) VALUES ('{name}', {age})"
            cursor.execute(insert_query)
            conn.commit()
            cursor.close()
            conn.close()

            logger.info(f"Query executed: {insert_query}")
            print(f"Success, {name}, {age} created, keep adding users to continue, enter 'exit' to quit")
        except Exception as e:
            print("Cant connect to db", e)
            logger.error("Connection to db failed")


if __name__ == "__main__":
    data_insert()