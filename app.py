import os
from flask import Flask, render_template, send_from_directory, request, redirect, url_for, session
from flask_mysqldb import MySQL
import MySQLdb.cursors as cursors
from werkzeug.utils import secure_filename
from utils import *

app = Flask(__name__, static_folder='app/resources',
            template_folder='app/screens')


# static_folder é a pasta que contém arquivos de css, javascript, imagens
# template_folder é a pasta que contém os htmls

# para referenciar tais arquivos no HTML em suas respectivas pastas:
# referencie o CSS com: http://127.0.0.1:5000/styles/<arquivo>.css
# imagens com: http://127.0.0.1:5000/images/<arquivo>.<extensão> no html ou ../images/<arquivo>.<extensão> dentro do CSS
# e JavaScript com: http://127.0.0.1:5000/js/<arquivo>.js

app.secret_key = 'secret_key'

app.config['JSON_AS_ASCII'] = False

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_PORT'] = 3307
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'dungeonsguild'

db = MySQL(app)


@app.route("/<path:filename>")
def send_file(filename):  # torna disponível os arquivos da pasta 'assets'
    return send_from_directory(app.static_folder, filename)


# APIs
@app.route("/api/pericias/")
def api_pericias():
    return get_from_database(
        '''
            SELECT id_pericia, nome_pericia, salvaguardas.id_salvaguardas, salvaguardas.nome_salvaguarda
            FROM pericias
            INNER JOIN salvaguardas
            ON pericias.id_salvaguardas = salvaguardas.id_salvaguardas
            ORDER BY pericias.id_pericia
        ''')


@app.route("/api/classes/")
def api_classes():
    return get_from_database("SELECT * FROM classes")


@app.route("/api/antecedentes/")
def api_antecedentes():
    return get_from_database("SELECT * FROM antecedentes")


@app.route("/api/racas/")
def api_racas():
    return get_from_database("SELECT * FROM racas")


@app.route("/api/tendencias/")
def api_tendencias():
    return get_from_database("SELECT * FROM tendencias")


@app.route("/api/personagem/<id>/")
def api_personagem(id):
    return get_one_from_database(f'''SELECT aliados, caracteristicas, cor_ficha, equipamentos, historia, idiomas_proficiencias,
        lista_aparencia, lista_bonus, lista_dinheiro, magias, nivel_personagem, nome_personagem, pericias, salvaguardas, tesouro,
        testes_resistencia, url_imagem, vida_atual, vida_total, xp_atual, xp_total, antecedentes.antecedente, classes.nome_classe,
        racas.nome_raca, tendencias.nome_tendencia, cadastro.apelido_cadastro FROM personagem
        JOIN antecedentes ON antecedentes.id = personagem.id_antecedente
        JOIN classes ON classes.id_classe = personagem.id_classe
        JOIN racas ON racas.id_raca = personagem.id_raca
        JOIN tendencias on tendencias.id_tendencia = personagem.id_tendencia
        JOIN cadastro ON cadastro.id_cadastro = personagem.id_usuario
        WHERE id_personagem = {id}''')


@app.route("/api/personagem/<id>/editar/")
def api_editar_personagem(id):
    return get_one_from_database(f'''SELECT * FROM personagem WHERE id_personagem = {id}''')


@app.route("/api/personagens_usuario/")
def api_personagens_usuario():
    return get_from_database(f'''SELECT id_personagem, nome_personagem, classes.nome_classe, nivel_personagem, racas.nome_raca,
        antecedentes.antecedente, cor_ficha, url_imagem FROM `personagem`
        JOIN classes ON classes.id_classe = personagem.id_classe
        JOIN racas ON racas.id_raca = personagem.id_raca
        JOIN antecedentes on antecedentes.id = personagem.id_antecedente
        WHERE id_usuario = {session['usuario']}''')


@app.route("/api/perfil_usuario/")
def api_perfil_usuario():
    cursor = db.connection.cursor(cursors.DictCursor)
    cursor.execute(f'''SELECT nome_cadastro, apelido_cadastro, email_cadastro, data_conta,
        COUNT(personagem.id_personagem) AS quant_personagem, id_assinatura FROM cadastro
        JOIN personagem ON personagem.id_usuario = cadastro.id_cadastro
        WHERE id_cadastro = {session['usuario']}''')
    row = cursor.fetchone()
    
    date_account = str(row['data_conta'])

    user = {}

    user['nome'] = row['nome_cadastro']
    user['apelido'] = row['apelido_cadastro']
    user['email'] = row['email_cadastro']
    user['data_conta'] = date_account
    user['quant_personagem'] = row['quant_personagem']
    user['assinatura'] = row['id_assinatura']

    return jsonify(user)


@app.route("/api/magias/")
def api_magias():
    json = open("app/resources/json/spells_sorted.json")
    return json


@app.route("/")
def inicio():
    return render_template('inicio.html')

# páginas de cadastro e login
@app.route("/cadastro/", methods=['GET', 'POST'])
def cadastro():
    if request.method == 'GET':
        return render_template('cadastro.html')

    if request.method == 'POST':
        return redirect('http://127.0.0.1/dungeons-guild/register.php')


@app.route("/login/", methods=['GET', 'POST'])
def login():
    if request.method == 'GET':
        return render_template('login.html')
        
    if request.method == 'POST':
        cursor = db.connection.cursor(cursors.DictCursor)
        cursor.execute(f"SELECT * FROM cadastro WHERE email_cadastro = \
            '{request.form['loginemail']}' AND senha_cadastro = '{request.form['loginsenha']}'")
        row = cursor.fetchone()

        if row:
            session['usuario'] = row['id_cadastro']
            session['apelido'] = row['apelido_cadastro']
            return redirect(url_for('personagens'))
        else:
            return redirect(url_for('login'))


# telas do dashboard
@app.route("/personagens/")
def personagens():
    if 'usuario' not in session:
        return redirect(url_for('login'))
    
    if len(api_personagens_usuario().json) == 0:
        return render_template('personagensvazio.html', apelido=session['apelido'])
    
    return render_template('personagens.html', apelido=session['apelido'])


@app.route("/personagem/excluir/", methods=['POST'])
def excluir_personagem():
    if 'usuario' not in session:
        return redirect(url_for('login'))
    
    cursor = db.connection.cursor(cursors.DictCursor)

    id_personagem = request.form.get('id-personagem')

    sql = f"DELETE FROM personagem WHERE id_personagem = {id_personagem}"
    
    cursor.execute(sql)
    db.connection.commit()
    cursor.close()

    return redirect(url_for('personagens'))


@app.route("/criar/mundo/")
def criar_mundo():
    return render_template('criar-mundo.html')


@app.route("/mundos/")
def mundos():
    if 'usuario' not in session:
        return redirect(url_for('login'))

    return render_template('mundos.html', apelido=session['apelido'])


@app.route("/mundosvazio/")
def mundosvazio():
    if 'usuario' not in session:
        return redirect(url_for('login'))

    return render_template('mundosvazio.html', apelido=session['apelido'])


@app.route("/embreve/")
def embreve():
    if 'usuario' not in session:
        return redirect(url_for('login'))

    return render_template('embreve.html', apelido=session['apelido'])


@app.route("/livros/")
def livros():
    if 'usuario' not in session:
        return redirect(url_for('login'))

    return render_template('livros.html', apelido=session['apelido'])


@app.route("/assinaturas/")
def assinaturas():
    if 'usuario' not in session:
        return redirect(url_for('login'))

    return render_template('assinaturas.html', apelido=session['apelido'])


@app.route("/perfil/", methods=['GET', 'POST'])
def perfil():
    if 'usuario' not in session:
        return redirect(url_for('login'))

    if request.method == 'GET':
        return render_template('perfil.html', apelido=session['apelido'])
    
    if request.method == 'POST':
        cursor = db.connection.cursor(cursors.DictCursor)

        if 'apelido' in request.form:
            new_apelido = request.form.get('apelido')

            if new_apelido == '':
                return redirect(url_for('perfil'))
            
            sql = f"UPDATE cadastro SET apelido_cadastro = '{new_apelido}' WHERE id_cadastro = {session['usuario']}"
            
            session['apelido'] = new_apelido

            cursor.execute(sql)
            db.connection.commit()

            return redirect(url_for('perfil'))

        if 'nome' in request.form:
            new_nome = request.form.get('nome')

            if new_nome == '':
                return redirect(url_for('perfil'))
            
            sql = f"UPDATE cadastro SET nome_cadastro = '{new_nome}' WHERE id_cadastro = {session['usuario']}"
                        
            cursor.execute(sql)
            db.connection.commit()

            return redirect(url_for('perfil'))

        if 'email' in request.form:
            new_email = request.form.get('email')

            if new_email == '':
                return redirect(url_for('login'))
            
            sql = f"UPDATE cadastro SET email_cadastro = '{new_email}' WHERE id_cadastro = {session['usuario']}"
                        
            cursor.execute(sql)
            db.connection.commit()

            session.clear()
            
            return redirect(url_for('perfil'))

        if 'senha' in request.form:
            new_password = request.form.get('senha')

            if new_password == '':
                return redirect(url_for('perfil'))
            
            sql = f"UPDATE cadastro SET senha_cadastro = '{new_password}' WHERE id_cadastro = {session['usuario']}"
                        
            cursor.execute(sql)
            db.connection.commit()

            session.clear()
            
            return redirect(url_for('login'))


@app.route("/account/delete/")
def excluir_conta():
    cursor = db.connection.cursor(cursors.DictCursor)

    try:
        delete_mundos_sql = f"DELETE FROM mundos WHERE id_usuario = {session['usuario']}"
        cursor.execute(delete_mundos_sql)
        db.connection.commit()
    except:
        pass

    try:
        delete_personagens_sql = f"DELETE FROM personagem WHERE id_usuario = {session['usuario']}"
        cursor.execute(delete_personagens_sql)
        db.connection.commit()
    except:
        pass

    delete_account_sql = f"DELETE FROM cadastro WHERE id_cadastro = {session['usuario']}"
    cursor.execute(delete_account_sql)
    db.connection.commit()

    cursor.close()

    return redirect(url_for('login'))


# ficha de criação do personagem
@app.route("/ficha/<id>/")
def ficha(id):
    if 'usuario' not in session:
        return redirect(url_for('login'))

    return render_template('ficha.html', id=id)


@app.route("/ficha/criar/", methods=['GET', 'POST'])
def criar_ficha():
    sql = f"SELECT COUNT(id_personagem) AS quant_personagem FROM `personagem` WHERE id_usuario = {session['usuario']}"

    cursor = db.connection.cursor(cursors.DictCursor)
    cursor.execute(sql)
    row = cursor.fetchone()

    if row['quant_personagem'] >= 3:
        return redirect('/personagens/')

    if request.method == 'GET':
        return render_template('criar-ficha.html', usuario=session['apelido'])

    if request.method == 'POST':
        ficha = request.form

        for key in ficha:
            if ficha[key] == '':
                return redirect('/ficha/criar/')
        
        if 'img-personagem' not in request.files:
            return redirect('/ficha/criar/')

        image = request.files['img-personagem']

        if image.filename == '':
            return redirect('/ficha/criar/')

        # cria um nome diferente para o arquivo e salva
        image.filename = create_file_name() + os.path.splitext(image.filename)[1]

        # se por algum acaso o nome já existir na pasta
        while image.filename in os.listdir('app/resources/images/fichas'):
            image.filename = create_file_name() + os.path.splitext(image.filename)[1]

        filename = secure_filename(image.filename)
        image.save(os.path.join('app/resources/images/fichas', filename))
        url_imagem = '/images/fichas/' + filename
        
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
            "inspiracao" : int(ficha.get("inspiracao")),
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

        lista_ficha = {}

        lista_ficha["nome_personagem"] = ficha.get("nome-personagem")
        lista_ficha["url_imagem"] = url_imagem
        lista_ficha["vida_atual"] = int(ficha.get("vida-atual"))
        lista_ficha["vida_total"] = int(ficha.get("vida-total"))
        lista_ficha["classe"] = int(ficha.get("classe"))
        lista_ficha["nivel"] = int(ficha.get("nivel"))
        lista_ficha["antecedente"] = int(ficha.get("antecedente"))
        lista_ficha["id_jogador"] = session["usuario"]
        lista_ficha["raca"] = int(ficha.get("raca"))
        lista_ficha["tendencia"] = int(ficha.get("tendencia"))
        lista_ficha["xp_atual"] = int(ficha.get("xp-atual"))
        lista_ficha["xp_total"] = int(ficha.get("xp-total"))
        lista_ficha["lista_aparencia"] = lista_aparencia
        lista_ficha["lista_bonus"] = lista_bonus
        lista_ficha["cor_ficha"] = ficha.get("cor-ficha")
        lista_ficha["salvaguardas"] = lista_salvaguardas
        lista_ficha["pericias"] = ficha.getlist("pericias")
        lista_ficha["testes_resistencia"] = ficha.getlist("testes-resistencia")
        lista_ficha["idiomas_proficiencias"] = ficha.get("idiomas-proficiencias").strip()
        lista_ficha["equipamentos"] = ficha.get("equipamentos").strip()
        lista_ficha["lista_dinheiro"] = lista_dinheiro
        lista_ficha["caracteristicas"] = ficha.get("caracteristicas").strip()
        lista_ficha["magias"] = ficha.getlist("magias")
        lista_ficha["historia"] = ficha.get("historia").strip()
        lista_ficha["tesouro"] = ficha.get("tesouro").strip()
        lista_ficha["aliados"] = ficha.get("aliados").strip()


        sql = f'''INSERT INTO `personagem`
        (`nome_personagem`, `url_imagem` ,`vida_atual`, `vida_total`, `id_classe`, `nivel_personagem`, `id_antecedente`,
        `id_usuario`, `id_raca`, `id_tendencia`, `xp_atual`, `xp_total`, `lista_aparencia`, `lista_bonus`,
        `cor_ficha`, `salvaguardas`, `pericias`, `testes_resistencia`, `idiomas_proficiencias`, `equipamentos`,
        `lista_dinheiro`, `caracteristicas`, `magias`, `historia`, `tesouro`, `aliados`)
        VALUES (
        "{lista_ficha["nome_personagem"]}",
        "{lista_ficha["url_imagem"]}",
        "{lista_ficha["vida_atual"]}",
        "{lista_ficha["vida_total"]}",
        "{lista_ficha["classe"]}",
        "{lista_ficha["nivel"]}",
        "{lista_ficha["antecedente"]}",
        "{lista_ficha["id_jogador"]}",
        "{lista_ficha["raca"]}",
        "{lista_ficha["tendencia"]}",
        "{lista_ficha["xp_atual"]}",
        "{lista_ficha["xp_total"]}",
        "{lista_ficha["lista_aparencia"]}",
        "{lista_ficha["lista_bonus"]}",
        "{lista_ficha["cor_ficha"]}",
        "{lista_ficha["salvaguardas"]}",
        "{lista_ficha["pericias"]}",
        "{lista_ficha["testes_resistencia"]}",
        "{lista_ficha["idiomas_proficiencias"]}",
        "{lista_ficha["equipamentos"]}",
        "{lista_ficha["lista_dinheiro"]}",
        "{lista_ficha["caracteristicas"]}",
        "{lista_ficha["magias"]}",
        "{lista_ficha["historia"]}",
        "{lista_ficha["tesouro"]}",
        "{lista_ficha["aliados"]}")'''
        
        cursor.execute(sql)
        db.connection.commit()

        return redirect('/personagens/')


@app.route("/ficha/<id>/editar/", methods=['GET', 'POST'])
def editar_ficha(id):
    if request.method == 'GET':
        return render_template('editar-ficha.html', usuario=session['apelido'], id=id)

    return

@app.route("/logout/", methods=['GET', 'POST'])
def logout():
    session.pop('usuario', None)
    return redirect(url_for('login'))


if __name__ == "__main__":
    app.run(debug=True)
