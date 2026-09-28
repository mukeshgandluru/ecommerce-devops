from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/")
def home():
    return jsonify({
        "service": "user-service",
        "status": "running"
    })


@app.route("/health")
def health():
    return jsonify({
        "service": "user-service",
        "status": "healthy"
    })


@app.route("/users")
def users():
    return jsonify([
        {
            "id": 1,
            "name": "Mukesh",
            "email": "mukesh@example.com"
        },
        {
            "id": 2,
            "name": "Rahul",
            "email": "rahul@example.com"
        }
    ])


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001)
