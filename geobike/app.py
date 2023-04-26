from flask import Flask, request, jsonify
from flask_cors import CORS
from gevent.pywsgi import WSGIServer

app = Flask(__name__)
CORS(app)

@app.route('/location', methods=['POST'])

def location():
    data = request.get_json()
    lat = data['lat']
    lon = data['lon']
    response = jsonify({'status': 'success', 'message': f'Answer from Python! lat {lat}, lon {lon}'})
    return response

if __name__ == '__main__':
    http_server = WSGIServer(('', 5000), app)
    http_server.serve_forever()
