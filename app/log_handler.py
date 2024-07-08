import os
import logging
import socket
from collections import defaultdict

logging.basicConfig(filename='/home/user/decoya/app/logs/app_logs.log', level=logging.INFO, 
                    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

def get_hostname():
    return socket.gethostname()

def get_local_ip():
    return socket.gethostbyname(socket.gethostname())

def mysql_log():
    # Get data from mysql request
    mysql_data = defaultdict(dict)
    try:
        mysql_data['ip'] = get_local_ip()
        mysql_data['host'] = get_hostname()
        mysql_data['db'] = os.getenv('MYSQL_DATABASE')
        logger.info(f"Connection established, mysql log data: {mysql_data}")
        return mysql_data
    except Exception as e:
        logger.error("Failed to retrieve mysql log data")
        print("Error, no log data", e)
        return None
    
                