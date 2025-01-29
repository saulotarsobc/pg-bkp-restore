import { spawn } from "node:child_process";
import * as fs from "node:fs";

// Variáveis de ambiente
const PROD_DB_HOST = process.env.PROD_DB_HOST || "my-database.com.br";
const PROD_DB_PORT = process.env.PROD_DB_PORT || "5435";
const PROD_DB_USER = process.env.PROD_DB_USER || "postgres";
const PROD_DB_PASS = process.env.PROD_DB_PASS || "superPassword";
const PROD_DB_NAME = process.env.PROD_DB_NAME || "my-db";

const DEV_DB_HOST = process.env.DEV_DB_HOST || "my-another-database.com.br";
const DEV_DB_PORT = process.env.DEV_DB_PORT || "5432";
const DEV_DB_USER = process.env.DEV_DB_USER || "postgres";
const DEV_DB_PASS = process.env.DEV_DB_PASS || "superPassword";
const DEV_DB_NAME = process.env.DEV_DB_NAME || "my-another-db";

const DO_BACKUP = process.env.DO_BACKUP === "1" || true;
const DO_RESTORE = process.env.DO_RESTORE === "1" || true;

const BACKUP_FILE = "backup.dump";

function runCommand(command: string, args: string[], env: NodeJS.ProcessEnv) {
  return new Promise<void>((resolve, reject) => {
    const process = spawn(command, args, { env });

    process.stdout.on("data", (data) => {
      console.log(data.toString()); // Mostra os logs em tempo real
    });

    process.stderr.on("data", (data) => {
      console.error(data.toString()); // Mostra os erros em tempo real
    });

    process.on("close", (code) => {
      if (code === 0) {
        resolve();
      } else {
        reject(new Error(`Command failed with exit code ${code}`));
      }
    });
  });
}

async function backupDatabase() {
  try {
    console.log("Iniciando o backup do banco de dados...");

    // Define a senha para o PostgreSQL
    const env = { ...process.env, PGPASSWORD: PROD_DB_PASS };

    const args = [
      "--verbose",
      "-h",
      PROD_DB_HOST,
      "-p",
      PROD_DB_PORT,
      "-U",
      PROD_DB_USER,
      "-Fc",
      "--no-owner",
      "--no-privileges",
      "-d",
      PROD_DB_NAME,
      "-f",
      BACKUP_FILE,
    ];

    await runCommand("pg_dump", args, env);

    console.log("Backup criado com sucesso em:", BACKUP_FILE);
  } catch (error) {
    console.error("Erro ao criar o backup:", error);
    process.exit(1);
  }
}

async function restoreDatabase() {
  try {
    console.log("Iniciando a restauração do banco de dados...");

    if (!fs.existsSync(BACKUP_FILE)) {
      console.error("Erro: Arquivo de backup não encontrado.");
      process.exit(1);
    }

    // Define a senha para o PostgreSQL
    const env = { ...process.env, PGPASSWORD: DEV_DB_PASS };

    const args = [
      "--no-comments",
      "--no-owner",
      "--disable-triggers",
      "-h",
      DEV_DB_HOST,
      "-p",
      DEV_DB_PORT,
      "-U",
      DEV_DB_USER,
      "-d",
      DEV_DB_NAME,
      BACKUP_FILE,
    ];

    await runCommand("pg_restore", args, env);

    console.log("Restauração realizada com sucesso.");
  } catch (error) {
    console.error("Erro ao restaurar o banco de dados:", error);
    process.exit(1);
  }
}

async function main() {
  if (DO_BACKUP) {
    await backupDatabase();
  }

  if (DO_RESTORE) {
    await restoreDatabase();
  }
}

main().catch((error) => {
  console.error("Erro inesperado:", error);
  process.exit(1);
});
