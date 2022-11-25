import os
from flask import Flask, render_template, send_from_directory, request, redirect, url_for, session
from flask_mysqldb import MySQL
import MySQLdb.cursors as cursors
import requests
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


@app.route("/api/pesquisar_mundo/")
def api_pesquisar_mundo():
    query_usuario = request.values.get("?nomemundo")
    cursor = db.connection.cursor(cursors.DictCursor)
    sql = f'''SELECT id_mundo, nome_mundo, imagem_mundo, mundo.id_cadastro,
    cadastro.apelido_cadastro AS mestre, privacidade_mundo, tema_mundo, jgdorNeces_mundo
    FROM mundo JOIN cadastro ON cadastro.id_cadastro = mundo.id_cadastro
    WHERE `nome_mundo` LIKE "%{query_usuario}%" AND privacidade_mundo = 0'''
    
    cursor.execute(sql)
    row = cursor.fetchall()
    
    resp = []

    for i in range(0, len(row)):
        # ciclagem entre o array de mundos
        mundo = {}
        
        for j in row[i]:
            mundo[j] = row[i][j]

        
        if mundo['id_cadastro'] == session['usuario']:
            continue

        id_mundo = row[i]["id_mundo"]
        sql_participantes = f'''SELECT id_usuario, cadastro.apelido_cadastro FROM `participantes_mundo`
            JOIN cadastro ON participantes_mundo.id_usuario = cadastro.id_cadastro WHERE id_mundo = {id_mundo}'''
        cursor.execute(sql_participantes)

        resp_participantes = cursor.fetchall()

        # adiciona os participantes do mundo
        mundo["quant_participantes"] = len(resp_participantes)
    
        resp.append(mundo)

    return jsonify(resp)


@app.route("/api/mundos/")
def api_mundos():
    cursor = db.connection.cursor(cursors.DictCursor)
    cursor.execute(f'''SELECT id_mundo, nome_mundo, imagem_mundo, mundo.id_cadastro,
    cadastro.apelido_cadastro AS mestre, privacidade_mundo, tema_mundo, jgdorNeces_mundo
    FROM mundo JOIN cadastro ON cadastro.id_cadastro = mundo.id_cadastro''')

    row = cursor.fetchall()

    response = []

    for i in range(0, len(row)):
        # ciclagem entre o array de mundos
        mundo = {}
        
        # constrói o mundo atual com a linha atual do SQL
        for j in row[i]:
            mundo[j] = row[i][j]

        mundo['dono'] = False

        if mundo['id_cadastro'] == session['usuario']:
            mundo['dono'] = True

        id_mundo = row[i]["id_mundo"]
        sql_participantes = f'''SELECT id_usuario, cadastro.apelido_cadastro FROM `participantes_mundo`
            JOIN cadastro ON participantes_mundo.id_usuario = cadastro.id_cadastro WHERE id_mundo = {id_mundo}'''
        cursor.execute(sql_participantes)

        resp_participantes = cursor.fetchall()

        # adiciona os participantes do mundo
        mundo["quant_participantes"] = len(resp_participantes)
        mundo['participa'] = False

        for j in range(0, len(resp_participantes)):
            # verifica se o usuário participa do mundo e retorna como um valor booleano
            if resp_participantes[j]['id_usuario'] == session['usuario']:
                mundo['participa'] = True
                break
        
        if not mundo['dono']:
            # previne de exibir os mundos privados que o usuário não participa
            if mundo['privacidade_mundo'] == 1 and mundo['participa'] == False:
                continue

        response.append(mundo)

    return jsonify(response)


@app.route("/api/mundo/<id>/")
def api_mundo(id):
    cursor = db.connection.cursor(cursors.DictCursor)
    cursor.execute(f'''SELECT id_mundo, mundo.id_cadastro, nome_mundo, cadastro.apelido_cadastro,
        imagem_mundo, tema_mundo, descricao_mundo, sistema_mundo, frequencia_mundo,
        data_mundo, jgdorNeces_mundo, codigo_mundo, privacidade_mundo FROM mundo
        JOIN cadastro ON cadastro.id_cadastro = mundo.id_cadastro WHERE id_mundo = {id}''')
    row = cursor.fetchone()

    world = {}

    # constrói o mundo para retorná-lo como JSON depois
    for i in row:
        if i == 'data_mundo':
            # transforma a data em uma string (mais fácil de manipular no front-end)
            world['data_mundo'] = str(row['data_mundo'])
            continue
        world[i] = row[i]

    world['dono'] = False
    # caso o usuário logado for o dono da ficha
    if world['id_cadastro'] == session['usuario']:
        world['dono'] = True

    sql_participantes = f'''SELECT id_usuario, cadastro.apelido_cadastro FROM `participantes_mundo`
        JOIN cadastro ON participantes_mundo.id_usuario = cadastro.id_cadastro WHERE id_mundo = {id}'''
    cursor.execute(sql_participantes)

    resp_participantes = cursor.fetchall()

    # insere todos os participantes do mundo
    world["participantes"] = resp_participantes

    world['participa'] = False

    for j in range(0, len(resp_participantes)):
        # verifica se o usuário participa do mundo e retorna como um valor booleano
        if resp_participantes[j]['id_usuario'] == session['usuario']:
            world['participa'] = True
            break

    return world
    
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
    # dados gerais do usuário
    cursor.execute(f'''SELECT cadastro.id_cadastro, nome_cadastro,
        apelido_cadastro, email_cadastro, data_conta, id_assinatura
        FROM cadastro WHERE cadastro.id_cadastro = {session['usuario']}''')
    row = cursor.fetchone()

    date_account = str(row['data_conta'])

    # contagem de mundos e personagens do usuário
    sql_count_mundos = f"SELECT COUNT(id_mundo) AS quant_mundos FROM mundo WHERE id_cadastro = {session['usuario']}"
    sql_count_personagens = f"SELECT COUNT(id_personagem) AS quant_personagem FROM personagem WHERE id_usuario = {session['usuario']}"

    cursor.execute(sql_count_mundos)
    quant_mundos = cursor.fetchone()['quant_mundos']

    cursor.execute(sql_count_personagens)
    quant_personagem = cursor.fetchone()['quant_personagem']

    user = {}

    user['nome'] = row['nome_cadastro']
    user['apelido'] = row['apelido_cadastro']
    user['email'] = row['email_cadastro']
    user['data_conta'] = date_account
    user['quant_personagem'] = quant_personagem
    user['assinatura'] = row['id_assinatura']
    user['quant_mundos'] = quant_mundos

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

        # caso a requisição do usuário venha sem e-mail
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
def api_verify_code():
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
def api_verify_password():
    # verifica a senha após o usuário tentar alterar o e-mail ou a senha
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


@app.route("/api/join_world/")
def api_join_world():
    # adiciona o usuário a um mundo privado, caso ele insira o código correto
    if 'usuario' not in session:
        return redirect(url_for('login'))

    if 'codigo' not in request.values or request.values['codigo'] == '':
        return redirect('/mundos/')

    codigo = request.values['codigo']
    
    cursor = db.connection.cursor(cursors.DictCursor)
    sql = f"SELECT `id_mundo`, `id_cadastro` FROM `mundo` WHERE `codigo_mundo` = '{codigo}' AND `privacidade_mundo` = 1"
    cursor.execute(sql)

    row = cursor.fetchone()

    if row['id_cadastro'] == session['usuario']:
        return redirect('/mundos/')
    
    insert_sql = f"INSERT INTO `participantes_mundo`(`id_mundo`, `id_usuario`) VALUES ('{row['id_mundo']}','{session['usuario']}')"
    cursor.execute(insert_sql)
    db.connection.commit()

    return redirect(f"/mundo/{row['id_mundo']}")


@app.route("/api/verify_world_code/<code>/")
def api_verify_world_code(code):
    # verifica se o usuário inseriu um código válido e retorna como um valor booleano
    if 'usuario' not in session:
        return redirect(url_for('login'))

    cursor = db.connection.cursor(cursors.DictCursor)

    sql = f"SELECT `id_mundo` FROM `mundo` WHERE `codigo_mundo` = '{code}'"
    cursor.execute(sql)
    row = cursor.fetchone()

    response = {}

    if row:
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
            # realiza o login e salva a sessão do usuário
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


# ficha de criação do personagem
@app.route("/ficha/<id>/")
def ficha(id):
    if 'usuario' not in session:
        return redirect(url_for('login'))

    cursor = db.connection.cursor(cursors.DictCursor)

    sql_verify_owner = f"SELECT `id_usuario` FROM `personagem` WHERE `id_personagem` = {id}"

    cursor.execute(sql_verify_owner)
    row_verify_owner = cursor.fetchone()

    # se o usuário tentar acessar uma ficha que não existe
    if row_verify_owner is None:
        return redirect('/personagens/')

    # se o usuário tentar acessar uma ficha que não é dele
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

    # se o usuário tentar criar uma ficha que excede o limite de sua assinatura grátis
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

    # se o usuário tentar editar uma ficha que não existe
    if row_verify_owner is None:
        return redirect('/personagens/')

    # se o usuário tentar editar uma ficha que não é dele
    if row_verify_owner['id_usuario'] != session['usuario']:
        return redirect('/personagens/')

    if request.method == 'GET':
        return render_template('editar-ficha.html', usuario=session['apelido'], id=id)

    if request.method == 'POST':
        if post_editar_ficha(session, request, cursor, db, os, create_file_name, secure_filename, get_lists_from_ficha, id):
            return redirect('/personagens/')

        return redirect(f'/ficha/{id}/editar')


@app.route("/personagem/excluir/", methods=['POST'])
def excluir_personagem():
    if 'usuario' not in session:
        return redirect(url_for('login'))

    cursor = db.connection.cursor(cursors.DictCursor)

    id_personagem = request.form.get('id-personagem')

    sql_verify_owner = f"SELECT `id_usuario` FROM `personagem` WHERE `id_personagem` = {id_personagem}"

    cursor.execute(sql_verify_owner)
    row_verify_owner = cursor.fetchone()

    # caso o usuário tente excluir um personagem que não existe
    if row_verify_owner is None:
        return redirect('/personagens/')

    # caso o usuário tente excluir um personagem que não é dele
    if row_verify_owner['id_usuario'] != session['usuario']:
        return redirect('/personagens/')

    sql = f"DELETE FROM personagem WHERE id_personagem = {id_personagem}"
    # realiza a exclusão
    cursor.execute(sql)
    db.connection.commit()
    cursor.close()

    return redirect(url_for('personagens'))


@app.route("/criar/mundo/", methods=['GET', 'POST'])
def criar_mundo():
    if 'usuario' not in session:
        return redirect(url_for('login'))

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
            while True:
                # comando para gerar um código...
                codigo_privacidade = codigo_mundo()
                
                # verificar se existe um codigo_privacidade igual no banco
                sql_cod_igual = f'SELECT `codigo_mundo` FROM `mundo` WHERE `codigo_mundo` = "{codigo_privacidade}"'
                cursor.execute(sql_cod_igual)
                row_vefificar_codigo = cursor.fetchone()

                if not row_vefificar_codigo:
                    break

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

        return redirect('/mundos/')


@app.route("/editar/mundo/<id>/", methods=['GET', 'POST'])
def editar_mundo(id):
    if 'usuario' not in session:
        return redirect(url_for('login'))

    cursor = db.connection.cursor(cursors.DictCursor)

    sql_verify_owner = f"SELECT `id_cadastro` FROM `mundo` WHERE `id_mundo` = {id}"

    cursor.execute(sql_verify_owner)
    row_verify_owner = cursor.fetchone()
    
    # caso o usuário tente editar um mundo que não existe
    if row_verify_owner is None:
        return redirect('/mundos/')

    # caso o usuário tente acessar a edição de um mundo que não é dele
    if row_verify_owner['id_cadastro'] != session['usuario']:
        return redirect(f'/mundo/{id}')

    if request.method == 'GET':
        return render_template('editar-mundo.html', apelido=session['apelido'], id=id)

    if request.method == 'POST':
        mundo = request.form

        for key in mundo:
            # verifica se algum campo está vazio
            if mundo[key] == '':
                return redirect(f'/editar/mundo/{id}/')

        if 'img-mundo' not in request.files or request.files['img-mundo'].filename == '':
            # sql para caso o usuário não mande uma imagem diferente
            if mundo['privacidade'] == '0':
                sql = f'''UPDATE `mundo`
                    SET `nome_mundo`='{mundo['nome_mundo']}',`tema_mundo`='{mundo['tema_mundo']}',
                    `descricao_mundo`='{mundo['descricao_mundo']}', `sistema_mundo`='{mundo['sistema']}',
                    `frequencia_mundo`='{mundo['frequencia']}',`data_mundo`='{mundo['data_sessao']}',
                    `jgdorNeces_mundo`='{mundo['jogadores_necessarios']}', `privacidade_mundo`='{mundo['privacidade']}',
                    `codigo_mundo`=NULL
                    WHERE id_mundo = {id}'''
            else:
                while True:
                    # comando para gerar um código...
                    codigo_privacidade = codigo_mundo()
                    
                    # verificar se existe um codigo_privacidade igual no banco
                    sql_cod_igual = f'SELECT `codigo_mundo` FROM `mundo` WHERE `codigo_mundo` = "{codigo_privacidade}"'
                    cursor.execute(sql_cod_igual)
                    row_vefificar_codigo = cursor.fetchone()

                    if not row_vefificar_codigo:
                        break

                sql = f'''UPDATE `mundo`
                    SET `nome_mundo`='{mundo['nome_mundo']}',`tema_mundo`='{mundo['tema_mundo']}',
                    `descricao_mundo`='{mundo['descricao_mundo']}', `sistema_mundo`='{mundo['sistema']}',
                    `frequencia_mundo`='{mundo['frequencia']}',`data_mundo`='{mundo['data_sessao']}',
                    `jgdorNeces_mundo`='{mundo['jogadores_necessarios']}', `privacidade_mundo`='{mundo['privacidade']}',
                    `codigo_mundo`='{codigo_privacidade}'
                    WHERE id_mundo = {id}'''
        else:
            image = request.files['img-mundo']

            # cria um nome diferente para o arquivo e salva
            image.filename = create_file_name(
            ) + os.path.splitext(image.filename)[1]

            # se por algum acaso o nome já existir na pasta
            while image.filename in os.listdir('app/resources/images/mundos'):
                image.filename = create_file_name(
                ) + os.path.splitext(image.filename)[1]

            filename = secure_filename(image.filename)
            image.save(os.path.join('app/resources/images/mundos', filename))
            url_imagem = '/images/mundos/' + filename

            if mundo['privacidade'] == '0':
                sql = f'''UPDATE `mundo`
                    SET `nome_mundo`='{mundo['nome_mundo']}',`tema_mundo`='{mundo['tema_mundo']}',
                    `descricao_mundo`='{mundo['descricao_mundo']}', `sistema_mundo`='{mundo['sistema']}',
                    `frequencia_mundo`='{mundo['frequencia']}',`data_mundo`='{mundo['data_sessao']}',
                    `jgdorNeces_mundo`='{mundo['jogadores_necessarios']}', `privacidade_mundo`='{mundo['privacidade']}',
                    `imagem_mundo`='{url_imagem}', `codigo_mundo`=NULL
                    WHERE id_mundo = {id}'''
            else:
                while True:
                    # comando para gerar um código...
                    codigo_privacidade = codigo_mundo()
                    
                    # verificar se existe um codigo_privacidade igual no banco
                    sql_cod_igual = f'SELECT `codigo_mundo` FROM `mundo` WHERE `codigo_mundo` = "{codigo_privacidade}"'
                    cursor.execute(sql_cod_igual)
                    row_vefificar_codigo = cursor.fetchone()

                    if not row_vefificar_codigo:
                        break

                sql = f'''UPDATE `mundo`
                    SET `nome_mundo`='{mundo['nome_mundo']}',`tema_mundo`='{mundo['tema_mundo']}',
                    `descricao_mundo`='{mundo['descricao_mundo']}', `sistema_mundo`='{mundo['sistema']}',
                    `frequencia_mundo`='{mundo['frequencia']}',`data_mundo`='{mundo['data_sessao']}',
                    `jgdorNeces_mundo`='{mundo['jogadores_necessarios']}', `privacidade_mundo`='{mundo['privacidade']}',
                    `imagem_mundo`='{url_imagem}', `codigo_mundo`='{codigo_privacidade}'
                    WHERE id_mundo = {id}'''

        cursor.execute(sql)
        db.connection.commit()
        
        return redirect(f'/mundos/')


@app.route("/pesquisar_mundo/")
def pesquisar_mundo():
    return render_template('pesquisar_mundos.html', apelido=session['apelido'])


@app.route("/mundos/")
def mundos():
    if 'usuario' not in session:
        return redirect(url_for('login'))

    return render_template('mundos.html', apelido=session['apelido'])

@app.route("/mundo/<id>/")
def mundo(id):
    if 'usuario' not in session:
        return redirect(url_for('login'))

    cursor = db.connection.cursor(cursors.DictCursor)

    sql_verify_owner_and_privacy = f"SELECT id_cadastro, privacidade_mundo FROM mundo WHERE id_mundo = {id}"
    cursor.execute(sql_verify_owner_and_privacy)

    row = cursor.fetchone()

    # se o mundo não existir
    if row is None:
        return redirect('/mundos/')
    
    if row['privacidade_mundo'] == 1:
        # caso o mundo for privado
        if row['id_cadastro'] != session['usuario']:
            # executa o código abaixo se o usuário não for o dono do mundo
            sql_verify_players = f'''SELECT id_usuario FROM `participantes_mundo` WHERE id_mundo = {id}'''
            cursor.execute(sql_verify_players)
            players_array = cursor.fetchall()

            for i in range(0, len(players_array)):
                # verifica se o usuário está dentro dos participantes, e retorna o mundo se ele estiver
                if players_array[i]['id_usuario'] == session['usuario']:
                    return render_template('mundo.html', id=id)

            return redirect('/mundos/')
           
    return render_template('mundo.html', id=id)


@app.route("/mundo/<id>/solicitacoes/")
def solicitacoes_mundo(id):
    return render_template("solicitacoes.html", id=id)


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
        delete_mundos_sql = f"DELETE FROM mundo WHERE id_cadastro = {session['usuario']}"
        cursor.execute(delete_mundos_sql)
        db.connection.commit()
    except:
        pass

    try:
        delete_participa_mundo = f"DELETE FROM participantes_mundo WHERE id_usuario = {session['usuario']}"
        cursor.execute(delete_participa_mundo)
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


@app.route("/logout/", methods=['GET', 'POST'])
def logout():
    session.pop('usuario', None)
    session.pop('apelido', None)
    return redirect(url_for('login'))


if __name__ == "__main__":
    app.run(debug=True)
