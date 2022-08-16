from flask import Flask, render_template, send_from_directory

app = Flask(__name__, static_folder='static') 

@app.route('/<path:filename>')  
def send_file(filename):  
    return send_from_directory(app.static_folder, filename)


@app.route("/mundos")
def mundos():
    return render_template('mundos.html')


app.run(debug = True)