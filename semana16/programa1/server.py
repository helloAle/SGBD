from xmlrpc.server import SimpleXMLRPCServer

def inverter_string(string):
    return string[::-1]

# Cria o servidor RPC
server = SimpleXMLRPCServer(("localhost", 8000))
print("Servidor pronto para receber solicitações...")

# Registra a função inverter_string como um método RPC
server.register_function(inverter_string, "inverter")

# Inicia o servidor
server.serve_forever()
