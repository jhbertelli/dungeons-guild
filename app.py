from flask import Flask, render_template, send_from_directory, jsonify
import mysql.connector as mysql
from flask_mysqldb import MySQL
import MySQLdb.cursors as cursors


app = Flask(__name__, static_folder='app/resources',
            template_folder='app/screens')

app.config['JSON_AS_ASCII'] = False

# static_folder é a pasta que contém arquivos de css, javascript, imagens
# template_folder é a pasta que contém os htmls

# para referenciar tais arquivos no HTML em suas respectivas pastas:
# referencie o CSS com: http://127.0.0.1:5000/styles/<arquivo>.css
# imagens com: http://127.0.0.1:5000/images/<arquivo>.<extensão> no html ou ../images/<arquivo>.<extensão> dentro do CSS
# e JavaScript com: http://127.0.0.1:5000/js/<arquivo>.js

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_PORT'] = 3307
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'dungeonsguild'

db = MySQL(app)

@app.route("/<path:filename>")
def send_file(filename):  # torna disponível os arquivos da pasta 'assets'
    return send_from_directory(app.static_folder, filename)


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


# APIs
@app.route("/api/pericias/")
def api_pericias():
    return get_from_database("SELECT * FROM pericias")


@app.route("/api/classes/")
def api_classes():
    return get_from_database("SELECT * FROM classes")

@app.route("/api/antecedentes/")
def api_antecedentes():
    return get_from_database("SELECT * FROM antecedentes")

@app.route("/api/salvaguardas/")
def api_salvaguardas():
    return get_from_database('''SELECT id_pericia, nome_pericia, salvaguardas.nome_salvaguarda FROM pericias
                    INNER JOIN salvaguardas
                    ON pericias.id_salvaguardas = salvaguardas.id_salvaguardas
                    ORDER BY pericias.id_pericia''')


@app.route("/api/tendencias/")
def api_tendencias():
    return get_from_database("SELECT * FROM tendencias")


@app.route("/api/personagem/")
def api_personagem():
    return get_from_database("SELECT * FROM personagem")


@app.route("/api/magias/")
def api_magias():
    json = open("app/resources/json/spells_sorted.json")
    return json


# páginas de cadastro e login
@app.route("/cadastro/")
def cadastro():
    return render_template('cadastro.html')


@app.route("/login/")
def login():
    return render_template('login.html')


# telas do dashboard
@app.route("/personagens/")
def personagens():
    return render_template('personagens.html')


@app.route("/personagensvazio/")
def personagensvazio():
    return render_template('personagensvazio.html')


@app.route("/mundos/")
def mundos():
    return render_template('mundos.html')


@app.route("/mundosvazio/")
def mundosvazio():
    return render_template('mundosvazio.html')


@app.route("/embreve/")
def embreve():
    return render_template('embreve.html')


@app.route("/livros/")
def livros():
    return render_template('livros.html')


@app.route("/perfil/")
def perfil():
    return render_template('perfil.html')


# ficha de criação do personagem
@app.route("/ficha/")
def ficha():
    return render_template('ficha.html')


@app.route("/ficha/criar/")
def criar_ficha():
    return render_template('criar-ficha.html')


if __name__ == "__main__":
    app.run(debug=True)
