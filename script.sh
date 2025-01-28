set -e

# Backup
if [ "$DO_BACKUP" == "1" ]; then
    echo "Criando backup do banco de dados..."
    
    export PGPASSWORD="$PROD_DB_PASS"
    
    pg_dump -h "$PROD_DB_HOST" -p "$PROD_DB_PORT" -U "$PROD_DB_USER" -Fc --no-owner --no-privileges -d "$PROD_DB_NAME" -f /files/backup.dump --verbose;
fi

# Restore
if [ "$DO_RESTORE" == "1" ]; then
    echo "Restaurando o banco de dados..."
    
    export PGPASSWORD="$DEV_DB_PASS"
    BACKUP_FILE="/files/backup.dump"
    
    # Verifica se o arquivo de backup existe
    if [ ! -f "$BACKUP_FILE" ]; then
        echo "Erro: Arquivo de backup $BACKUP_FILE não encontrado."
        exit 1
    fi
    
    # Restaura o banco de dados
    pg_restore --no-comments --no-owner --disable-triggers --verbose -h "$DEV_DB_HOST" -p "$DEV_DB_PORT" -U "$DEV_DB_USER" -d "$DEV_DB_NAME" /files/backup.dump
    
    # Verifica se a restauração foi bem-sucedida
    if [ $? -eq 0 ]; then
        echo "Restauração realizada com sucesso."
    else
        echo "Falha na restauração do backup." >&2
        exit 1
    fi
fi