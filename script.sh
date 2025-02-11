set -e

# Backup
if [ "$DO_BACKUP" = "1" ]; then
    echo "Criando backup do banco de dados..."
    export PGPASSWORD="$SRC_DB_PASS"
    
    pg_dump -h "$SRC_DB_HOST" -p "$SRC_DB_PORT" -U "$SRC_DB_USER" -Fc --no-owner --no-privileges -d "$SRC_DB_NAME" -f /files/backup.dump --verbose;
fi

# Restore
if [ "$DO_RESTORE" = "1" ]; then
    echo "Restaurando o banco de dados..."
    
    export PGPASSWORD="$DEST_DB_PASS"
    BACKUP_FILE="/files/backup.dump"
    
    # Verifica se o arquivo de backup existe
    if [ ! -f "$BACKUP_FILE" ]; then
        echo "Erro: Arquivo de backup $BACKUP_FILE não encontrado."
        exit 1
    fi
    
    # Restaura o banco de dados
    pg_restore --no-comments --no-owner --disable-triggers --verbose -h "$DEST_DB_HOST" -p "$DEST_DB_PORT" -U "$DEST_DB_USER" -d "$DEST_DB_NAME" /files/backup.dump
    
    # Verifica se a restauração foi bem-sucedida
    if [ $? -eq 0 ]; then
        echo "Restauração realizada com sucesso."
    else
        echo "Falha na restauração do backup." >&2
        exit 1
    fi
fi