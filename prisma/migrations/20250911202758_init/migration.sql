-- CreateEnum
CREATE TYPE "public"."TipoPessoa" AS ENUM ('FISICA', 'JURIDICA');

-- CreateEnum
CREATE TYPE "public"."EstadoCivil" AS ENUM ('SOLTEIRO', 'CASADO', 'DIVORCIADO', 'VIUVO');

-- CreateEnum
CREATE TYPE "public"."Sexo" AS ENUM ('MASCULINO', 'FEMININO', 'OUTRO');

-- CreateEnum
CREATE TYPE "public"."TipoCondomino" AS ENUM ('PROPRIETARIO', 'LOCATARIO', 'RESIDENTE', 'NENHUM');

-- CreateEnum
CREATE TYPE "public"."TipoContato" AS ENUM ('TELEFONE', 'CELULAR', 'EMAIL', 'OUTRO');

-- CreateEnum
CREATE TYPE "public"."TipoDocumento" AS ENUM ('CPF', 'CNPJ', 'RG', 'CNH', 'OUTRO');

-- CreateEnum
CREATE TYPE "public"."TipoEndereco" AS ENUM ('RESIDENCIAL', 'COMERCIAL', 'COBRANCA', 'OUTRO');

-- CreateTable
CREATE TABLE "public"."User" (
    "userId" SERIAL NOT NULL,
    "nomeCompleto" TEXT NOT NULL,
    "dataNascimento" TIMESTAMP(3) NOT NULL,
    "tipoPessoa" "public"."TipoPessoa" NOT NULL,
    "estadoCivil" "public"."EstadoCivil" NOT NULL,
    "sexo" "public"."Sexo" NOT NULL,
    "condomino" BOOLEAN NOT NULL DEFAULT false,
    "fornecedor" BOOLEAN NOT NULL DEFAULT false,
    "sindico" BOOLEAN NOT NULL DEFAULT false,
    "funcionario" BOOLEAN NOT NULL DEFAULT false,
    "tipoCondomino" "public"."TipoCondomino" NOT NULL,
    "foto" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "isFirstLogin" BOOLEAN NOT NULL DEFAULT true,
    "email" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "public"."UserLogin" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "displayName" TEXT NOT NULL,
    "firstLogin" BOOLEAN NOT NULL DEFAULT true,
    "token" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "UserLogin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Contato" (
    "id" SERIAL NOT NULL,
    "tipo" "public"."TipoContato" NOT NULL,
    "contato" TEXT NOT NULL,
    "responsavel" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "Contato_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Documento" (
    "id" SERIAL NOT NULL,
    "tipo" "public"."TipoDocumento" NOT NULL,
    "documento" TEXT NOT NULL,
    "validade" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "Documento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Endereco" (
    "id" SERIAL NOT NULL,
    "tipo" "public"."TipoEndereco" NOT NULL,
    "logradouro" TEXT NOT NULL,
    "cep" TEXT,
    "numero" TEXT NOT NULL,
    "complemento" TEXT NOT NULL,
    "bairro" TEXT NOT NULL,
    "cidade" TEXT NOT NULL,
    "estado" TEXT NOT NULL,
    "pais" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "Endereco_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "public"."User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "UserLogin_email_key" ON "public"."UserLogin"("email");

-- CreateIndex
CREATE UNIQUE INDEX "UserLogin_userId_key" ON "public"."UserLogin"("userId");

-- AddForeignKey
ALTER TABLE "public"."UserLogin" ADD CONSTRAINT "UserLogin_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Contato" ADD CONSTRAINT "Contato_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Documento" ADD CONSTRAINT "Documento_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Endereco" ADD CONSTRAINT "Endereco_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;
