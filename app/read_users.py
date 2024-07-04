import mysql.connector
import os
from log_handler import logger, mysql_log

def data_read():
    """Read data from mysql data and return all users dict list"""
    users_list = []
    try:
        mysql_data = mysql_log()

        conn = mysql.connector.connect(
            host=os.getenv('MYSQL_HOST'),
            user=os.getenv('MYSQL_ROOT_USER'),
            password=os.getenv('MYSQL_ROOT_PASSWORD'),
            database=os.getenv('MYSQL_DATABASE'),
        )
        cursor = conn.cursor()
        insert_query = f"SELECT * FROM users"
        cursor.execute(insert_query)

        for (name, age) in cursor:
            user_dict = {'name': name, 'age': age}
            users_list.append(user_dict)
        
        print("List of users:", users_list)

        cursor.close()
        conn.close()
        logger.info(f"Query executed: {insert_query}")
    
    except Exception as e:
        logger.error("Connection to db failed")
        print("Cant connect to db", e)

if __name__ == "__main__":
    data_read()