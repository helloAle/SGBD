import xmlrpc.client

# Cria o proxy do servidor RPC
proxy = xmlrpc.client.ServerProxy("http://localhost:8000/")

# Solicita ao usuário que digite a mensagem a ser invertida
mensagem = input("Digite uma mensagem para inverter: ")

# Chama o método remoto "inverter" no servidor
resultado = proxy.inverter(mensagem)

# Exibe o resultado
print("Resultado da inversão:", resultado)
