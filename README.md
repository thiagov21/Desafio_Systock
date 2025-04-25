# Case Técnico - Análise de Dados SQL

Este repositório contém a solução para o case técnico de análise de dados utilizando PostgreSQL.

## Estrutura do Projeto

```
.
├── README.md
├── schemas/
│   └── 01_create_tables.sql      # Criação das tabelas
├── queries/
│   ├── parte1/                   # Consultas SQL básicas
│   │   ├── 1.1_consumo_mensal.sql
│   │   ├── 1.2_pedidos_pendentes.sql
│   │   └── 1.3_nao_consumidos.sql
│   ├── parte2/                   # Transformações de dados
│   │   └── transformacoes.sql
│   └── parte3/                   # Consultas para validação
│       └── validacao_cliente.sql
└── docs/
    └── estrategia_validacao.md   # Documentação da estratégia de validação
```



## Pré-requisitos

- PostgreSQL 12 ou superior
- Cliente SQL (recomendado: DBeaver)

## Como Usar

1. Crie um novo banco de dados no PostgreSQL
2. Execute o script de criação das tabelas em `schemas/01_create_tables.sql`
3. Execute as consultas na ordem desejada dentro da pasta `queries/`

## Documentação

- Cada arquivo SQL está documentado com comentários explicando a lógica utilizada
- A estratégia de validação está detalhada em `docs/estrategia_validacao.md`