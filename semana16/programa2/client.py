import xmlrpc.client

# Cria o proxy do servidor RPC
proxy = xmlrpc.client.ServerProxy("http://localhost:8000/")

# Solicita ao usuário que insira dois números
numero1 = int(input("Digite o primeiro número: "))
numero2 = int(input("Digite o segundo número: "))

# Chama o método remoto "somar" no servidor
resultado = proxy.somar(numero1, numero2)

# Exibe o resultado
print("Resultado da soma:", resultado)
