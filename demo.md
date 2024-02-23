echo '<html><title>Container's inside</title><body><h1>Creating a container the hard way!</h1></body></html>' > index.html

cat << EOF >> server.py
import http.server
import socketserver

PORT = 80

Handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print("serving at port", PORT)
    httpd.serve_forever()
EOF

python3 server.py
