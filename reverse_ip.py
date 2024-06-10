from flask import Flask, request

app = Flask(__name__)

@app.route('/')
def reverse_ip():
    ip = request.remote_addr
    reversed_ip = '.'.join(reversed(ip.split('.')))
    return f'Reversed IP: {reversed_ip}'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
