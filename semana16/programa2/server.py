from xmlrpc.server import SimpleXMLRPCServer

def somar_numeros(a, b):
    return a + b

# Cria o servidor RPC
server = SimpleXMLRPCServer(("localhost", 8000))
print("Servidor pronto para receber solicitações...")

# Registra a função somar_numeros como um método RPC
server.register_function(somar_numeros, "somar")

# Inicia o servidor
server.serve_forever()
