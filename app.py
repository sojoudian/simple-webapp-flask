import os
from flask import Flask
app = Flask(__name__)

@app.route("/")
def main():
    return "Welcome CLO835!"

@app.route('/how are you')
def hello():
    return 'I am good, how about you?'

if __name__ == "__main__":
    # PORT overrides the default without a code change.
    port = int(os.environ.get("PORT", 8080))
    app.run(host="0.0.0.0", port=port)
