# Backup and Restore PostgreSQL Docker Image

## Overview

Essa imagem Docker foi projetada para realizar **backup** e **restauração** de bancos de dados PostgreSQL de forma simples e eficiente. A automação é feita através de um script que utiliza `pg_dump` e `pg_restore`, com suporte tanto para ambientes de produção quanto de desenvolvimento.

## Features

- **Backup automático**: Cria backups do banco de dados de produção.
- **Restauração automatizada**: Restaura o backup em um banco de desenvolvimento.
- **Configuração via variáveis de ambiente**: Personalize os detalhes de conexão do banco e as operações de backup/restauração.
- **Volume de dados**: Persistência dos backups através de volumes Docker.

## Como usar

### Requisitos

- Docker instalado no ambiente.

### Executando a imagem

#### Exemplo com `docker-compose.yaml`

Crie um arquivo `docker-compose.yaml` com o seguinte conteúdo:

```yaml
services:
  app:
    image: saulotarsobc/pg-bkp-restore:latest
    restart: no
    volumes:
      - ./data/files:/files
    environment:
      - PROD_DB_HOST=my-database.com.br
      - PROD_DB_PORT=5435
      - PROD_DB_USER=postgres
      - PROD_DB_PASS=superPassword
      - PROD_DB_NAME=my-db
      - DEV_DB_HOST=my-another-database.com.br
      - DEV_DB_PORT=5432
      - DEV_DB_USER=postgres
      - DEV_DB_PASS=superPassword
      - DEV_DB_NAME=my-another-db
      - DO_BACKUP=1 # 1: Ativar backup, 0: Desativar
      - DO_RESTORE=1 # 1: Ativar restauração, 0: Desativar
```

````

#### Comando direto

Para executar diretamente, utilize:

```bash
docker run -v $(pwd)/data/files:/files \
  -e PROD_DB_HOST=my-database.com.br \
  -e PROD_DB_PORT=5435 \
  -e PROD_DB_USER=postgres \
  -e PROD_DB_PASS=superPassword \
  -e PROD_DB_NAME=my-db \
  -e DEV_DB_HOST=my-another-database.com.br \
  -e DEV_DB_PORT=5432 \
  -e DEV_DB_USER=postgres \
  -e DEV_DB_PASS=superPassword \
  -e DEV_DB_NAME=my-another-db \
  -e DO_BACKUP=1 \
  -e DO_RESTORE=1 \
  saulotarsobc/pg-bkp-restore:latest
```

### Estrutura do Projeto

- **`Dockerfile`**: Configuração da imagem base.
- **`script.sh`**: Automação do backup e restauração.
- **`/files`**: Diretório compartilhado com o host para armazenar os arquivos de backup.

### Variáveis de Ambiente

| Variável       | Descrição                             | Exemplo                      |
| -------------- | ------------------------------------- | ---------------------------- |
| `PROD_DB_HOST` | Host do banco de produção             | `my-database.com.br`         |
| `PROD_DB_PORT` | Porta do banco de produção            | `5435`                       |
| `PROD_DB_USER` | Usuário do banco de produção          | `postgres`                   |
| `PROD_DB_PASS` | Senha do banco de produção            | `superPassword`              |
| `PROD_DB_NAME` | Nome do banco de produção             | `my-db`                      |
| `DEV_DB_HOST`  | Host do banco de desenvolvimento      | `my-another-database.com.br` |
| `DEV_DB_PORT`  | Porta do banco de desenvolvimento     | `5432`                       |
| `DEV_DB_USER`  | Usuário do banco de desenvolvimento   | `postgres`                   |
| `DEV_DB_PASS`  | Senha do banco de desenvolvimento     | `superPassword`              |
| `DEV_DB_NAME`  | Nome do banco de desenvolvimento      | `my-another-db`              |
| `DO_BACKUP`    | Realizar backup (1: Sim, 0: Não)      | `1`                          |
| `DO_RESTORE`   | Realizar restauração (1: Sim, 0: Não) | `1`                          |

## License

Esse projeto é distribuído sob a licença **MIT**.

---

Contribua ou reporte problemas diretamente no repositório! 🚀

[![GitHub Issues](https://img.shields.io/github/issues/saulotarsobc/pg-bkp-restore.svg)](https://github.com/saulotarsobc/pg-bkp-restore/issues)
````
