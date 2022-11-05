from string import ascii_letters
from random import choice
from app import db
from flask import jsonify, redirect, url_for
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


def create_file_name():
    numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
    letters = list(ascii_letters)
    numbers_letters = numbers + letters

    file_name = ''

    while len(file_name) < 15:
        file_name += choice(numbers_letters)

    return file_name


def get_lists_from_ficha(ficha):
    lista_dinheiro = {
        "pc": ficha.get("pc"),
        "pp": ficha.get("pp"),
        "pe": ficha.get("pe"),
        "po": ficha.get("po"),
        "pl": ficha.get("pl")
    }

    lista_aparencia = {
        "idade": int(ficha.get("idade")),
        "altura": float(ficha.get("altura")),
        "peso": float(ficha.get("peso")),
        "cabelo": ficha.get("cabelo"),
        "olho": ficha.get("olho"),
        "pele": ficha.get("pele")
    }

    lista_bonus = {
        "inspiracao": int(ficha.get("inspiracao")),
        "percepcao": int(ficha.get("percepcao")),
        "dados_vida":  int(ficha.get("dados-vida")),
        "classe_armadura":  int(ficha.get("classe-armadura")),
        "iniciativa": int(ficha.get("iniciativa")),
        "deslocamento": int(ficha.get("deslocamento"))
    }

    lista_salvaguardas = {
        "forca": int(ficha.get("forca")),
        "destreza": int(ficha.get("destreza")),
        "constituicao": int(ficha.get("constituicao")),
        "inteligencia": int(ficha.get("inteligencia")),
        "sabedoria": int(ficha.get("sabedoria")),
        "carisma": int(ficha.get("carisma"))
    }

    all_lists = {}
    all_lists["lista_dinheiro"] = lista_dinheiro
    all_lists["lista_aparencia"] = lista_aparencia
    all_lists["lista_bonus"] = lista_bonus
    all_lists["lista_salvaguardas"] = lista_salvaguardas

    return all_lists

