# 📦 pg-bkp-restore: Backup e Restauração de PostgreSQL com Docker

[![GitHub Stars](https://img.shields.io/github/stars/saulotarsobc/pg-bkp-restore.svg)](https://github.com/saulotarsobc/pg-bkp-restore/stargazers)
[![GitHub Issues](https://img.shields.io/github/issues/saulotarsobc/pg-bkp-restore.svg)](https://github.com/saulotarsobc/pg-bkp-restore/issues)
[![GitHub Forks](https://img.shields.io/github/forks/saulotarsobc/pg-bkp-restore.svg)](https://github.com/saulotarsobc/pg-bkp-restore/network)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/saulotarsobc/pg-bkp-restore.svg)](https://github.com/saulotarsobc/pg-bkp-restore/commits)

## 📌 Visão Geral

Esta imagem Docker facilita **backup** e **restauração** de bancos de dados PostgreSQL de maneira automatizada.  
Ela utiliza `pg_dump` para criar backups e `pg_restore` para restauração.

### 🔥 Funcionalidades

✔️ **Backup automático** com `pg_dump`  
✔️ **Restauração automatizada** com `pg_restore`  
✔️ **Configuração via variáveis de ambiente**  
✔️ **Persistência dos arquivos de backup** com volumes Docker

---

## 🚀 Como Usar

### 🔧 Pré-requisitos

- Docker instalado em seu ambiente
- Banco de dados PostgreSQL configurado

---

### 🛠️ Configuração com `docker-compose`

Crie um arquivo **docker-compose.yaml** e adicione:

```yaml
services:
  pg-bkp-restore:
    image: saulotarsobc/pg-bkp-restore:latest
    container_name: pg-bkp-restore
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
      - DO_BACKUP=1 # 1 = Backup ativo, 0 = Desativado
      - DO_RESTORE=1 # 1 = Restauração ativa, 0 = Desativado
```

Após criar o arquivo, inicie o serviço:

```bash
docker-compose up -d
```

---

### ▶️ Execução Manual

Você também pode rodar o container sem `docker-compose`:

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

---

## 🌍 Variáveis de Ambiente

| Variável       | Descrição                           | Exemplo                      |
| -------------- | ----------------------------------- | ---------------------------- |
| `SRC_DB_HOST`  | Host do banco de origem             | `my-database.com.br`         |
| `SRC_DB_PORT`  | Porta do banco de origem            | `5435`                       |
| `SRC_DB_USER`  | Usuário do banco de origem          | `postgres`                   |
| `SRC_DB_PASS`  | Senha do banco de origem            | `superPassword`              |
| `SRC_DB_NAME`  | Nome do banco de origem             | `my-db`                      |
| `DEST_DB_HOST` | Host do banco de destino            | `my-another-database.com.br` |
| `DEST_DB_PORT` | Porta do banco de destino           | `5432`                       |
| `DEST_DB_USER` | Usuário do banco de destino         | `postgres`                   |
| `DEST_DB_PASS` | Senha do banco de destino           | `superPassword`              |
| `DEST_DB_NAME` | Nome do banco de destino            | `my-another-db`              |
| `DO_BACKUP`    | Ativar backup (1: Sim, 0: Não)      | `1`                          |
| `DO_RESTORE`   | Ativar restauração (1: Sim, 0: Não) | `1`                          |

---

## 📂 Estrutura do Projeto

- **`Dockerfile`** → Configuração da imagem Docker
- **`script.sh`** → Script de backup/restauração
- **`docker-compose.yaml`** → Configuração para `docker-compose`
- **`/files`** → Diretório para armazenar backups

---

## 🔄 Como Funciona

1️⃣ Se `DO_BACKUP=1`, o container cria um **backup** usando `pg_dump`.  
2️⃣ Se `DO_RESTORE=1`, o container **restaura** um backup existente com `pg_restore`.  
3️⃣ Os arquivos de backup são armazenados no diretório `/files`.

---

## 📝 Licença

Este projeto é distribuído sob a licença **MIT**.

🔗 Contribua ou reporte problemas no repositório oficial:  
[👉 GitHub - pg-bkp-restore](https://github.com/saulotarsobc/pg-bkp-restore)

🚀 **Happy coding!** 🚀
