from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World! v1.2"

counter = 1

@app.route("/count")
def count():
    global counter
    counter += 1
    mensagem = f"Versao 1.2. Contagem: {counter}"
    return mensagem

@app.route("/reset")
def reset():
    global counter
    counter = 1
    return str(counter)

if __name__ == "__main__":
    app.run(debug=False, port=5000, host="0.0.0.0")