import json

from flask import Flask, jsonify
from pizzas import PIZZAS

app = Flask(__name__)


@app.route("/pizzas")
def pizzas():
    return jsonify([pizza for pizza in PIZZAS])


@app.route("/pizzas/<int:pizza_id>")
def pizza(pizza_id):
    pizza = next((pizza for pizza in PIZZAS if pizza['id'] == pizza_id), None)
    if not pizza:
        return jsonify(None), 404
    return jsonify(pizza)
