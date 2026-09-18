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
    # PORT lets the container pick a different port without a code change.
    # Manual run  (python3 app.py)  -> 8080, the default.
    # Container   (docker run)      -> 18080, set by ENV PORT in the Dockerfile.
    port = int(os.environ.get("PORT", 8080))
    app.run(host="0.0.0.0", port=port)
