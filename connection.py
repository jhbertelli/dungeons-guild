import mysql.connector as mysql

db = mysql.connect(
    host="localhost",
    port=3307,
    user="root",
    password="",
    database="dungeonsguild"
)

cursor = db.cursor()

cursor.execute("SELECT * FROM cadastro")

result = cursor.fetchall()

for i in result:
    print(i[0], i[4])