from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/")
def home():
    return jsonify({
        "service": "order-service",
        "status": "running"
    })


@app.route("/health")
def health():
    return jsonify({
        "service": "order-service",
        "status": "healthy"
    })


@app.route("/orders")
def orders():
    return jsonify([
        {
            "order_id": 1001,
            "user_id": 1,
            "product_id": 101,
            "quantity": 1,
            "status": "confirmed"
        },
        {
            "order_id": 1002,
            "user_id": 2,
            "product_id": 102,
            "quantity": 2,
            "status": "processing"
        }
    ])


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5003)
