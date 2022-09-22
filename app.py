from flask import Flask, render_template, send_from_directory

app = Flask(__name__, static_folder='app/resources', template_folder='app/screens')

# static_folder é a pasta que contém arquivos de css, javascript, imagens
# template_folder é a pasta que contém os htmls

# para referenciar tais arquivos no HTML em suas respectivas pastas:
# referencie o CSS com: styles/<arquivo>.css
# imagens com: images/<arquivo>.<extensão> no html ou ../images/<arquivo>.<extensão> dentro do CSS
# e JavaScript com: js/<arquivo>.js

@app.route('/<path:filename>')
def send_file(filename):  # torna disponível os arquivos da pasta 'assets'
    return send_from_directory(app.static_folder, filename)


@app.route("/mundos")
def mundos():
    return render_template('mundos.html')


@app.route("/personagem")
def personagem():
    return render_template('personagem.html')

@app.route("/personagensvazio")
def personagensvazio():
    return render_template('personagensvazio.html')

@app.route("/personagens")
def personagens():
    return render_template('personagens.html')

@app.route("/mundosvazio")
def mundosvazio():
    return render_template('mundosvazio.html')

@app.route("/embreve")
def embreve():
    return render_template('embreve.html')

@app.route("/livros")
def livros():
    return render_template('livros.html')

app.run(debug = True)