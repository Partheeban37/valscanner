from flask import Flask, request, jsonify
from flask_cors import CORS
import subprocess

app = Flask(__name__)
# Enable CORS specifically for /scan and allow all origins
CORS(app, resources={r"/scan": {"origins": "*"}})

# Add strict_slashes=False to allow /scan/ and /scan
@app.route('/scan', methods=['GET'], strict_slashes=False)
def scan():
    target = request.args.get('target')
    if not target:
        return jsonify({'error': 'Target is required'}), 400
    result = subprocess.getoutput(f"nmap -Pn {target}")
    return jsonify({'output': result})

if __name__ == '__main__':
    # Keep Flask running on all interfaces
    app.run(host='0.0.0.0', port=5000)
