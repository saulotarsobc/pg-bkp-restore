# Backup and Restore PostgreSQL Docker Image

[![GitHub Stars](https://img.shields.io/github/stars/saulotarsobc/pg-bkp-restore.svg)](https://github.com/saulotarsobc/pg-bkp-restore/stargazers) [![GitHub Issues](https://img.shields.io/github/issues/saulotarsobc/pg-bkp-restore.svg)](https://github.com/saulotarsobc/pg-bkp-restore/issues) [![GitHub Pull Requests](https://img.shields.io/github/issues-pr/saulotarsobc/pg-bkp-restore.svg)](https://github.com/saulotarsobc/pg-bkp-restore/pulls) [![GitHub Forks](https://img.shields.io/github/forks/saulotarsobc/pg-bkp-restore.svg)](https://github.com/saulotarsobc/pg-bkp-restore/network) [![GitHub Last Commit](https://img.shields.io/github/last-commit/saulotarsobc/pg-bkp-restore.svg)](https://github.com/saulotarsobc/pg-bkp-restore/commits)

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
      - SRC_DB_HOST=my-database.com.br
      - SRC_DB_PORT=5435
      - SRC_DB_USER=postgres
      - SRC_DB_PASS=superPassword
      - SRC_DB_NAME=my-db
      - DEST_DB_HOST=my-another-database.com.br
      - DEST_DB_PORT=5432
      - DEST_DB_USER=postgres
      - DEST_DB_PASS=superPassword
      - DEST_DB_NAME=my-another-db
      - DO_BACKUP=1 # 1: Ativar backup, 0: Desativar
      - DO_RESTORE=1 # 1: Ativar restauração, 0: Desativar
```

---

#### Comando direto

Para executar diretamente, utilize:

```bash
docker run -v $(pwd)/data/files:/files \
  -e SRC_DB_HOST=my-database.com.br \
  -e SRC_DB_PORT=5435 \
  -e SRC_DB_USER=postgres \
  -e SRC_DB_PASS=superPassword \
  -e SRC_DB_NAME=my-db \
  -e DEST_DB_HOST=my-another-database.com.br \
  -e DEST_DB_PORT=5432 \
  -e DEST_DB_USER=postgres \
  -e DEST_DB_PASS=superPassword \
  -e DEST_DB_NAME=my-another-db \
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
| `SRC_DB_HOST`  | Host do banco de produção             | `my-database.com.br`         |
| `SRC_DB_PORT`  | Porta do banco de produção            | `5435`                       |
| `SRC_DB_USER`  | Usuário do banco de produção          | `postgres`                   |
| `SRC_DB_PASS`  | Senha do banco de produção            | `superPassword`              |
| `SRC_DB_NAME`  | Nome do banco de produção             | `my-db`                      |
| `DEST_DB_HOST` | Host do banco de desenvolvimento      | `my-another-database.com.br` |
| `DEST_DB_PORT` | Porta do banco de desenvolvimento     | `5432`                       |
| `DEST_DB_USER` | Usuário do banco de desenvolvimento   | `postgres`                   |
| `DEST_DB_PASS` | Senha do banco de desenvolvimento     | `superPassword`              |
| `DEST_DB_NAME` | Nome do banco de desenvolvimento      | `my-another-db`              |
| `DO_BACKUP`    | Realizar backup (1: Sim, 0: Não)      | `1`                          |
| `DO_RESTORE`   | Realizar restauração (1: Sim, 0: Não) | `1`                          |

## License

Esse projeto é distribuído sob a licença **MIT**.

---

Contribua ou reporte problemas diretamente no repositório! 🚀

[🔹 saulotarsobc/pg-bkp-restore](https://github.com/saulotarsobc/pg-bkp-restore)
