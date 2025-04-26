import pandas as pd
import random
import re
import psycopg2
from datetime import datetime, timedelta

# === LOGIN ===
def ler_login(caminho_login):
    dados = {}
    with open(caminho_login, 'r') as f:
        linhas = f.readlines()
        for linha in linhas:
            if '=' in linha:
                chave, valor = linha.strip().split('=')
                dados[chave.strip()] = valor.strip()
    return dados

# === CONECTAR no Banco ===
def conectar_postgres(usuario, senha, banco, host='localhost', porta=5432):
    conn = psycopg2.connect(
        dbname=banco,
        user=usuario,
        password=senha,
        host=host,
        port=porta
    )
    return conn

# === LIMPAR descrições ===
def limpar_texto(texto):
    texto = re.sub(r'[^\w\s]', '', texto)  
    return texto.strip()

# === Gerar data aleatória ===
def gerar_data_inicial(fim, dias_offset=0):
    return fim - timedelta(days=random.randint(0, dias_offset))

# === Modulo Gerar Dados ===
descricoes_produtos = [
    "Notebook", "Smartphone", "TV", "Geladeira", "Fogão", "Micro-ondas", "Ar-condicionado",
    "Cafeteira", "Liquidificador", "Ventilador", "Fone de ouvido", "Impressora", "Monitor",
    "Mouse", "Teclado", "Cadeira Gamer", "Mesa Escritório", "Tablet", "Smartwatch", "Caixa de Som"
]

produtos = []
for i in range(100):
    produto_id = f"Produto{1000 + i}"
    descricao = limpar_texto(random.choice(descricoes_produtos))
    produtos.append({"produto_id": produto_id, "descricao_produto": descricao})

produtos_df = pd.DataFrame(produtos)

# === Tabelas ===
venda_data = []
for i in range(100):
    produto = random.choice(produtos)
    venda_data.append({
        "venda_id": i + 1,
        "data_emissao": gerar_data_inicial(datetime(2025, 3, 31), dias_offset=90).strftime("%Y-%m-%d"),
        "horariomov": f"{random.randint(0, 23):02}:{random.randint(0, 59):02}:00",
        "produto_id": produto["produto_id"],
        "qtde_vendida": random.randint(1, 50),
        "valor_unitario": random.randint(10, 500),
        "filial_id": random.choice([1, 2, 3]),
        "item": random.randint(1, 5),
        "unidade_medida": random.choice(['un', 'kg', 'ltr'])
    })
venda_df = pd.DataFrame(venda_data)

pedido_compra_data = []
for i in range(100):
    produto = random.choice(produtos)
    pedido_compra_data.append({
        "pedido_id": random.randint(10000, 99999),
        "data_pedido": gerar_data_inicial(datetime(2025, 3, 31), dias_offset=90).strftime("%Y-%m-%d"),
        "item": random.randint(1, 5),
        "produto_id": produto["produto_id"],
        "descricao_produto": produto["descricao_produto"],
        "ordem_compra": random.randint(1000, 9999),
        "qtde_pedida": random.randint(1, 500),
        "filial_id": random.choice([1, 2, 3]),
        "data_entrega": gerar_data_inicial(datetime(2025, 3, 31), dias_offset=30).strftime("%Y-%m-%d"),
        "qtde_entregue": random.randint(0, 500),
        "qtde_pendente": random.randint(0, 500),
        "preco_compra": random.randint(10, 500),
        "fornecedor_id": random.randint(1, 5)
    })
pedido_compra_df = pd.DataFrame(pedido_compra_data)

entradas_mercadoria_data = []
for i in range(100):
    produto = random.choice(produtos)
    entradas_mercadoria_data.append({
        "data_entrada": gerar_data_inicial(datetime(2025, 3, 31), dias_offset=90).strftime("%Y-%m-%d"),
        "nro_nfe": f"NFE{random.randint(100000, 999999)}",
        "item": random.randint(1, 5),
        "produto_id": produto["produto_id"],
        "descricao_produto": produto["descricao_produto"],
        "qtde_recebida": random.randint(0, 1000),
        "filial_id": random.choice([1, 2, 3]),
        "custo_unitario": random.randint(10, 500)
    })
entradas_mercadoria_df = pd.DataFrame(entradas_mercadoria_data)

# === CRIAR tabelas no Banco ===
def criar_tabelas(cursor):
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS venda (
            venda_id SERIAL PRIMARY KEY,
            data_emissao DATE,
            horariomov TIME,
            produto_id VARCHAR(50),
            qtde_vendida INTEGER,
            valor_unitario INTEGER,
            filial_id INTEGER,
            item INTEGER,
            unidade_medida VARCHAR(10)
        );
    """)
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS pedido_compra (
            pedido_id INTEGER PRIMARY KEY,
            data_pedido DATE,
            item INTEGER,
            produto_id VARCHAR(50),
            descricao_produto VARCHAR(100),
            ordem_compra INTEGER,
            qtde_pedida INTEGER,
            filial_id INTEGER,
            data_entrega DATE,
            qtde_entregue INTEGER,
            qtde_pendente INTEGER,
            preco_compra INTEGER,
            fornecedor_id INTEGER
        );
    """)
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS entradas_mercadoria (
            id SERIAL PRIMARY KEY,
            data_entrada DATE,
            nro_nfe VARCHAR(50),
            item INTEGER,
            produto_id VARCHAR(50),
            descricao_produto VARCHAR(100),
            qtde_recebida INTEGER,
            filial_id INTEGER,
            custo_unitario INTEGER
        );
    """)

# === INSERIR dados no Banco ===
def inserir_dados(conn, df, tabela):
    cursor = conn.cursor()
    for index, row in df.iterrows():
        colunas = ', '.join(row.index)
        valores = ', '.join(['%s'] * len(row))
        sql = f"INSERT INTO {tabela} ({colunas}) VALUES ({valores});"
        cursor.execute(sql, tuple(row))
    conn.commit()

if __name__ == "__main__":
    caminho_login = r'C:\automação\projetos\login.txt'
    login = ler_login(caminho_login)
    
    conn = conectar_postgres(login['usuario'], login['senha'], login['banco'])
    cursor = conn.cursor()
    
    criar_tabelas(cursor)
    
    inserir_dados(conn, venda_df, 'venda')
    inserir_dados(conn, pedido_compra_df, 'pedido_compra')
    inserir_dados(conn, entradas_mercadoria_df, 'entradas_mercadoria')
    
    cursor.close()
    conn.close()
    
    print("Dados gerados e inseridos no PostgreSQL com sucesso!")
