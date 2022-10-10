from string import ascii_letters
from random import choice
from app import db
from flask import jsonify, redirect
import MySQLdb.cursors as cursors

def get_one_from_database(sql):
    # realiza um select do banco de dados e exibe como json
    cursor = db.connection.cursor(cursors.DictCursor)
    try:
        cursor.execute(sql)
        row = cursor.fetchone()
        resp = jsonify(row)
        resp.status_code = 200
        cursor.close()
        return resp
    except:
        return "Houve algo errado com a transação, por favor, tente novamente."

def get_from_database(sql):
    # realiza um select do banco de dados e exibe como json
    cursor = db.connection.cursor(cursors.DictCursor)
    try:
        cursor.execute(sql)
        rows = cursor.fetchall()
        resp = jsonify(rows)
        resp.status_code = 200
        cursor.close()
        return resp
    except:
        return "Houve algo errado com a transação, por favor, tente novamente."


def try_int_conversion(value):
    try:
        int(value)
        return int(value)
    except:
        return redirect('/ficha/criar/')


def try_float_conversion(value):
    try:
        float(value)
        return float(value)
    except:
        return redirect('/ficha/criar/')

def create_file_name():
    numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
    letters = list(ascii_letters)
    numbers_letters = numbers + letters
    
    file_name = ''

    while len(file_name) < 15:
        file_name += choice(numbers_letters)
    
    return file_name
