import os
from flask import Flask, render_template, send_from_directory, request, redirect, url_for, session
from flask_mysqldb import MySQL
import MySQLdb.cursors as cursors
import requests
import random
from werkzeug.utils import secure_filename
from criar_ficha import post_criar_ficha
from editar_ficha import post_editar_ficha
from email_confirmation import *
from utils import *

app = Flask(__name__, static_folder='app/resources',
            template_folder='app/screens')


# static_folder é a pasta que contém arquivos de css, javascript, imagens
# template_folder é a pasta que contém os htmls

# para referenciar tais arquivos no HTML em suas respectivas pastas:
# referencie o CSS com: /styles/<arquivo>.css
# imagens com: /images/<arquivo>.<extensão> no html ou ../images/<arquivo>.<extensão> dentro do CSS
# e JavaScript com: /js/<arquivo>.js

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
    return get_from_database('''SELECT id_pericia, nome_pericia, salvaguardas.id_salvaguardas, salvaguardas.nome_salvaguarda
            FROM pericias INNER JOIN salvaguardas ON pericias.id_salvaguardas = salvaguardas.id_salvaguardas
            ORDER BY pericias.id_pericia''')


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
    magics_json = requests.get('http://localhost/dungeons-guild/magias.php').json()
    return magics_json


@app.route("/api/usuarios/<apelido>")
def api_usuarios(apelido):
    return get_from_database(f"SELECT apelido_cadastro, id_cadastro FROM cadastro WHERE apelido_cadastro LIKE '%{apelido}%'")


@app.route("/api/cadastro/", methods=['POST'])
def api_cadastro():
    if request.method == "POST":
        form = request.form

        response = {}

        if "email" not in form or form["email"] == "":
            response['sucess'] = False
            return response

        # cria o código de verificação
        code = verification_code()
        session['verification_code'] = code
        session['signup_email'] = form['email']

        # envia para o e-mail
        send_confirmation(form["email"], code)
        response['sucess'] = True
        return response


@app.route("/api/verify_code/", methods=['POST'])
def verify_code():
    # verifica se o código inserido está correto e retorna como um valor booleano
    user_sent_form = request.form

    response = {}

    if "verification-code" not in user_sent_form or user_sent_form['verification-code'] == '':
        response["sucess"] = False
        return response

    user_sent_code = user_sent_form['verification-code']

    if user_sent_code == session['verification_code']:
        response['sucess'] = True
        return response

    response['sucess'] = False

    return response


@app.route("/api/verify_password/", methods=["POST"])
def verify_password():
    user_sent_form = request.form
    response = {}

    cursor = db.connection.cursor(cursors.DictCursor)

    sql = f"SELECT senha_cadastro FROM cadastro WHERE id_cadastro = {session['usuario']}"
    cursor.execute(sql)
    row = cursor.fetchone()

    if user_sent_form['password'] == row['senha_cadastro']:
        response['sucess'] = True

        return response

    response['sucess'] = False

    return response


# fim das APIs

@app.route("/")
def inicio():
    return render_template('index.html')

# páginas de cadastro e login


@app.route("/cadastro/", methods=['GET', 'POST'])
def cadastro():
    if 'usuario' in session:
        return redirect('/personagens/')

    if request.method == 'GET':
        if 'verification_code' in session:
            session.pop('verification_code', None)

        if 'signup_email' in session:
            session.pop('signup_email', None)

        return render_template('cadastro.html')

    if request.method == 'POST':
        form = request.form
        fields = ['apelido', 'email', 'nome', 'senha',
                  'verificarSenha', 'verification-code']

        signup = {}

        for key in fields:
            if key not in form or form[key] == '':
                return redirect('/cadastro/')
            signup[key] = form[key].strip()

        if form['senha'] != form['senha'].strip():
            return redirect('/cadastro/')

        # previne o cadastro caso se o usuário não inserir o código correto
        # se as senhas forem diferentes,
        # se o usuário inserir uma senha com espaços
        # ou se o usuário inserir um e-mail diferente da qual o código de verificação foi enviada
        if signup['senha'] != form['verificarSenha'] \
                or signup['verification-code'] != session['verification_code'] \
                or ' ' in form['senha'] \
                or signup['email'] != session['signup_email']:

            return redirect('/cadastro/')

        session.pop('verification_code', None)
        session.pop('signup_email', None)

        cursor = db.connection.cursor(cursors.DictCursor)
        sql = f'''INSERT INTO `cadastro`
        (`nome_cadastro`, `apelido_cadastro`, `email_cadastro`, `senha_cadastro`, `id_assinatura`)
        VALUES ('{signup['nome']}', '{signup['apelido']}', '{signup['email']}', '{signup['senha']}', 1)'''
        cursor.execute(sql)
        db.connection.commit()

        return redirect('/login/')


@app.route("/login/", methods=['GET', 'POST'])
def login():
    if 'usuario' in session:
        return redirect('/personagens/')

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

    sql_verify_owner = f"SELECT `id_usuario` FROM `personagem` WHERE `id_personagem` = {id_personagem}"

    cursor.execute(sql_verify_owner)
    row_verify_owner = cursor.fetchone()

    if row_verify_owner is None:
        return redirect('/personagens/')

    if row_verify_owner['id_usuario'] != session['usuario']:
        return redirect('/personagens/')

    sql = f"DELETE FROM personagem WHERE id_personagem = {id_personagem}"

    cursor.execute(sql)
    db.connection.commit()
    cursor.close()

    return redirect(url_for('personagens'))


@app.route("/criar/mundo/", methods=['GET', 'POST'])
def criar_mundo():
    if request.method == 'GET':
        return render_template('criar-mundo.html', apelido=session['apelido'])

    if request.method == 'POST':
        form = request.form

        if 'img-mundo' not in request.files:
            return redirect('/criar/mundo/')

        image = request.files['img-mundo']

        if image.filename == '':
            return redirect('/criar/mundo/')

        # cria um nome diferente para o arquivo e salva
        image.filename = create_file_name() + os.path.splitext(image.filename)[1]

        # se por algum acaso o nome já existir na pasta
        while image.filename in os.listdir('app/resources/images/mundos'):
            image.filename = create_file_name() + os.path.splitext(image.filename)[1]

        filename = secure_filename(image.filename)
        image.save(os.path.join('app/resources/images/mundos', filename))

        path = '/images/mundos/' + image.filename

        cursor = db.connection.cursor(cursors.DictCursor)
        codigo_privacidade = ''

        if form['privacidade'] == '1':
            # comando para gerar um código...
            minusculo = "abcdefghijklmnopqrstuvwxyz"                                                            
            maisculo = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            numero = "0123456789"
            pre_codigo = minusculo + maisculo + numero
            tamanho = 8
            codigo_privacidade = "".join(random.sample(pre_codigo, tamanho))
            
            # verificar se existe um codigo_privacidade igual no banco
            sql_cod_igual = f'SELECT `codigo_mundo` FROM `mundo` WHERE `codigo_mundo` = "{codigo_privacidade}"'
            cursor.execute(sql_cod_igual)
            row_vefificar_codigo = cursor.fetchone()

            while row_vefificar_codigo :
                # Fazer o codigo novamente até mudar
                codigo_privacidade = "".join(random.sample(pre_codigo, tamanho))
                sql_cod_igual = f'SELECT `codigo_mundo` FROM `mundo` WHERE `codigo_mundo` = "{codigo_privacidade}"'
                cursor.execute(sql_cod_igual)
                row_vefificar_codigo = cursor.fetchone()



      

        sql = f'''INSERT INTO `mundo`
            (`nome_mundo`, `imagem_mundo`, `tema_mundo`, `descricao_mundo`, 
            `sistema_mundo`, `frequencia_mundo`, `data_mundo`, `jgdorNeces_mundo`, `codigo_mundo`,
            `privacidade_mundo`, `id_cadastro`)
            VALUES
            ('{form['nome_mundo']}','{path}','{form['tema_mundo']}',
            '{form['descricao_mundo']}','{form['sistema']}','{form['frequencia']}','{form['data_sessao']}',
            '{form['jogadores_necessarios']}','{codigo_privacidade}','{form['privacidade']}','{session['usuario']}')'''

        # executa o comando SQL
        cursor.execute(sql)
        # para comandos com insert, update ou delete é necessário fazer o commit abaixo:
        # (este commando não é necessário para comandos com select)
        db.connection.commit()

        return form


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


@app.route("/livros/")
def livros():
    if 'usuario' not in session:
        return redirect(url_for('login'))

    return render_template('livros.html', apelido=session['apelido'])


@app.route("/assinaturas/", methods=['GET', 'POST'])
def assinaturas():
    if 'usuario' not in session:
        return redirect(url_for('login'))

    if request.method == 'GET':
        return render_template('assinaturas.html', apelido=session['apelido'])

    if request.method == 'POST':
        cursor = db.connection.cursor(cursors.DictCursor)

        sql = f"UPDATE cadastro SET id_assinatura = 2 WHERE id_cadastro = {session['usuario']}"

        cursor.execute(sql)
        db.connection.commit()

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

        if 'senha-nova' in request.form:
            new_password = request.form.get('senha-nova')

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

    session.pop('usuario', None)
    session.pop('apelido', None)

    return redirect(url_for('login'))


# ficha de criação do personagem
@app.route("/ficha/<id>/")
def ficha(id):
    if 'usuario' not in session:
        return redirect(url_for('login'))

    cursor = db.connection.cursor(cursors.DictCursor)

    sql_verify_owner = f"SELECT `id_usuario` FROM `personagem` WHERE `id_personagem` = {id}"

    cursor.execute(sql_verify_owner)
    row_verify_owner = cursor.fetchone()

    if row_verify_owner is None:
        return redirect('/personagens/')

    if row_verify_owner['id_usuario'] != session['usuario']:
        return redirect('/personagens/')

    return render_template('ficha.html', id=id)


@app.route("/ficha/criar/", methods=['GET', 'POST'])
def criar_ficha():
    if 'usuario' not in session:
        return redirect(url_for('login'))

    sql_count_personagens_assinatura = f'''SELECT cadastro.id_assinatura, COUNT(id_personagem) AS quant_personagem
        FROM personagem JOIN cadastro ON personagem.id_usuario = cadastro.id_cadastro
        WHERE id_usuario = {session['usuario']}'''

    cursor = db.connection.cursor(cursors.DictCursor)
    cursor.execute(sql_count_personagens_assinatura)
    row_personagens_assinatura = cursor.fetchone()

    if row_personagens_assinatura['quant_personagem'] >= 3 and row_personagens_assinatura["id_assinatura"] == 1:
        return redirect('/personagens/')

    if request.method == 'GET':
        return render_template('criar-ficha.html', usuario=session['apelido'])

    if request.method == 'POST':
        if post_criar_ficha(session, request, cursor, db, os, create_file_name, secure_filename, get_lists_from_ficha):
            return redirect('/personagens/')

        return redirect('/ficha/criar/')


@app.route("/ficha/<id>/editar/", methods=['GET', 'POST'])
def editar_ficha(id):
    cursor = db.connection.cursor(cursors.DictCursor)

    sql_verify_owner = f"SELECT `id_usuario` FROM `personagem` WHERE `id_personagem` = {id}"

    cursor.execute(sql_verify_owner)
    row_verify_owner = cursor.fetchone()

    if row_verify_owner is None:
        return redirect('/personagens/')

    if row_verify_owner['id_usuario'] != session['usuario']:
        return redirect('/personagens/')

    if request.method == 'GET':
        return render_template('editar-ficha.html', usuario=session['apelido'], id=id)

    if request.method == 'POST':
        if post_editar_ficha(session, request, cursor, db, os, create_file_name, secure_filename, get_lists_from_ficha, id):
            return redirect('/personagens/')

        return redirect(f'/ficha/{id}/editar')


@app.route("/logout/", methods=['GET', 'POST'])
def logout():
    session.pop('usuario', None)
    session.pop('apelido', None)
    return redirect(url_for('login'))


if __name__ == "__main__":
    app.run(debug=True)
