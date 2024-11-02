from flask import Flask, request, jsonify
from flask_cors import CORS
from moduls import Gevmini
import google.generativeai as genai

app = Flask(__name__)
CORS(app)  # CORS'u etkinleştir
gevmini = Gevmini("AIzaSyBRYEe1kSaynYPSE8E11rzmCOvmOVdgg8U", "gemini-1.5-flash-latest")

# Global veri saklama alanı
data_storage = {}

@app.errorhandler(404)
def not_found(error):
    return jsonify({'error': 'Not found'}), 404

@app.errorhandler(500)
def internal_error(error):
    return jsonify({'error': 'Internal server error'}), 500

@app.route('/api/answers_percent', methods=['POST'])
def answers_percent():
    data = request.get_json()
    user_answer = data.get("user_answer")
    correct_answer = data.get("correct_answer")
    if user_answer and correct_answer:
        result = gevmini.answers_percent(user_answer, correct_answer)
        return jsonify({"result": result}), 200
    else:
        return jsonify({"error": "Invalid input data"}), 400

@app.route('/api/create_quiz', methods=['POST'])
def create_quiz():
    data = request.get_json()
    subject = data.get("subject")
    question_count = data.get("question_count")
    level = data.get("level")
    if subject and question_count and level:
        result = gevmini.create_quiz(subject, question_count, level)
        return jsonify({"result": result}), 200
    else:
        return jsonify({"error": "Invalid input data"}), 400

@app.route('/api/lecture', methods=['POST'])
def lecture():
    data = request.get_json()
    subject = data.get("subject")
    title = data.get("title")
    level = data.get("level")
    token = data.get("token")
    if subject and title and level and token:
        result = gevmini.lecture(subject, title, level, token)
        return jsonify({"result": result}), 200
    else:
        return jsonify({"error": "Invalid input data"}), 400

@app.route('/api/find_answer', methods=['POST'])
def find_answer():
    data = request.get_json()
    question = data.get("question")
    level = data.get("level")
    if question and level:
        result = gevmini.find_answer(question, level)
        return jsonify({"result": result}), 200
    else:
        return jsonify({"error": "Invalid input data"}), 400

@app.route('/api/guide', methods=['POST'])
def guide():
    data = request.get_json()
    subject = data.get("subject")
    if subject:
        result = gevmini.guide(subject)
        return jsonify({"result": result}), 200
    else:
        return jsonify({"error": "Invalid input data"}), 400

@app.route('/api/create_question', methods=['POST'])
def create_question():
    data = request.get_json()
    subject = data.get("subject")
    level = data.get("level")
    if subject and level:
        result = gevmini.create_question(subject, level)
        return jsonify({"result": result}), 200
    else:
        return jsonify({"error": "Invalid input data"}), 400

@app.route('/api/data', methods=['POST'])
def receive_data():
    data = request.get_json()
    if data:
        data_storage.update(data)
        return jsonify({"message": "Data received and stored successfully.", "data": data}), 201
    else:
        return jsonify({"error": "No data received"}), 400

@app.route('/api/data', methods=['GET'])
def send_data():
    return jsonify(data_storage)

if __name__ == '__main__':
    app.run(debug=True, port=5000)
