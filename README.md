<a id="Home"></a>
# Ambiente para Estudo e Laboratório **Haskell** com Docker

### O intuito deste projeto com **Docker** e **Docker Compose** é fornecer um ambiente de desenvolvimento consistente e simples, afim de  facilitar estudos e laboratórios, principalmente de quem está iniciando em **Haskell**.

<hr>

***Sumário**

- [**Pré-requisitos**](#Pre-requisitos) 
- [**Configuração do Ambiente**](#Configuracao-do-Ambiente) 
- [**Como utilizar o Projeto**](#Como-utilizar-o-Projeto) 
- [**Como rodar o exemplo**](#Como-rodar-o-exemplo) 
- [**Como rodar um novo arquivo usando o GHC**](#Como-rodar-um-novo-arquivo-usando-o-GHC) 


<hr>

****

 <a id="Pre-requisitos"></a>
## Pré-requisitos  >> 
<small>[**->Voltar Início**](#home)</small>

Certifique-se de ter o **Docker** e o **Docker Compose** instalados em sua máquina.

- **Docker:** [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/)
- **Docker Compose:** [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)

<hr>

 <a id="Configuracao-do-Ambiente"></a>
## Configuração do Ambiente  >> 
<small>[**->Voltar Início**](#home)</small>

Este projeto utiliza um arquivo `docker-compose.yml` e um `Dockerfile` para configurar o ambiente de desenvolvimento.

O arquivo `docker-compose.yml` define o serviço `haskell-app`, que usa a imagem base `haskell:latest`. Ele também especifica o build context, o Dockerfile a ser usado, as portas a serem redirecionadas e os volumes a serem montados.

<hr>

**docker-compose.yml:**
```yaml
version: '3'
services:
  haskell-app:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: "Haskell-App"
    stdin_open: true
    tty: true
    ports:
      - 8080:8080
    volumes:
      - ./app:/app
```

O `Dockerfile` define a imagem base `haskell:latest` e define o diretório de trabalho no contêiner como `/app`. E posteriormente, assim como no `docker-compose.yml`, poderá ser acrescentado novas configurações conforme for necessário.

**Dockerfile:**

```dockerfile
# Define a imagem base
FROM haskell:latest

# Define o diretório de trabalho no contêiner
WORKDIR /app
```
<hr>

 <a id="Como-utilizar-o-Projeto"></a>
## Como utilizar o Projeto  >> 
<small>[**->Voltar Início**](#home)</small>

1. **Clone** ou faça **download** deste repositório em sua máquina:

   ```shell
   git clone https://github.com/vladimirpezzole/Lab-Haskell.git
   ```

2. Acesse o diretório do projeto:

   ```shell
   cd Lab-Haskell
   ```

3. Inicie o projeto usando o **Docker Compose**:

   ```shell
   docker compose up -d
   ```
   *>> Obs. se a versão do Docker CLI for anterior a versão 2.0.0 use **docker-compose** com hífen(-).*

4. Agora você pode desenvolver seu projeto **Haskell** no **host**, e os arquivos serão refletidos dentro do **contêiner Haskell** dentro da pasta **app**.

5. Para acessar um **shell** dentro do **contêiner Haskell** em execução, use o seguinte comando:

   ```shell
   docker exec -it Haskell-App bash
   ```

   Isso abrirá um **shell** dentro do **contêiner**, onde você pode executar comandos e interagir com o ambiente de desenvolvimento.

6. Quando terminar de usar o projeto, você pode parar e **remover** os **contêineres** usando o comando:

   ```shell
   docker compose down
   ```

   Isso encerrará os **contêineres**, mas manterá os **volumes**, permitindo que você inicie novamente o projeto no futuro sem perder os dados.

<hr>

>> **Aproveite o desenvolvimento do seu projeto Haskell usando o ambiente Dockerizado!**

<br>

******

<hr>

 <a id="Como-rodar-o-exemplo"></a>
## Como rodar o exemplo  >> 
<small>[**->Voltar Início**](#home)</small>

Para testar a função `main` do arquivo **Main.hs** localizado em >> `app/Main.hs`, compile o arquivo e execute no terminal. Seguindo os passos:

1. Abra um terminal.
2. Digite o comando `docker compose exec haskell-app bash` para abrir um terminal interativo dentro do contêiner. 
3. Se não estiver dentro da pasta `app` navegue até o diretório onde está localizado o arquivo `Main.hs` usando o comando `cd` (change directory). Por exemplo: `cd /app`.
4. Compile o arquivo `Main.hs` usando o GHC (Glasgow Haskell Compiler) com o seguinte comando: `ghc Main.hs`.
   Isso irá gerar um arquivo executável com o nome `Main`.
5. Agora execute o arquivo gerado com o seguinte comando: `./Main`.
   Isso irá executar o programa e, se você fornecer dois argumentos numéricos, ele imprimirá a soma deles. Caso contrário, exibirá a mensagem "Por favor, forneça dois argumentos numéricos."

Certifique-se de ter o GHC instalado corretamente em seu sistema para compilar e executar o código Haskell.

**Exemplo:**
```bash
meuusuario@linux:~/Lab-Haskell$ docker compose exec haskell-app bash
```
No terminal interativo dentro do contêiner na pasta `app` :

```bash
>> digite -> ghc Main.hs
root@haskell-app:/app# ghc Main.hs

>> resultado
[1 of 2] Compiling Main             ( Main.hs, Main.o )
[2 of 2] Linking Main

>> execute o arquivo Main compilado
root@haskell-app:/app# ./Main

>> resultado:
root@haskell-app:/app#  Por favor, forneça dois argumentos numéricos.

>> com argumentos 20 e 40
root@haskell-app:/app#  ./Main 20 40

>> resultado:
60.0

```

<hr>

 <a id="Como-rodar-um-novo-arquivo-usando-o-GHC"></a>
## Como rodar um novo arquivo usando o GHC  >> 
<small>[**->Voltar Início**](#home)</small>

Crie seu arquivo e salve com extensão `.hs`, >> exemplo: `MeuAppHaskell.hs`.

No terminal digite só `ghci` ou `ghci` + o nome do arquivo:

**Exemplo:**

```bash
root@haskell-app:/app# ghci MeuAppHaskell.hs

>> resultado
GHCi, version 9.4.5: https://www.haskell.org/ghc/  :? for help
[1 of 2] Compiling Main             ( MeuAppHaskell.hs, interpreted )
Ok, one module loaded.
ghci>

>> digite a função e os parâmetros (ex. soma 3 4)
ghci> soma 3 4

>> resultado
7.0
```

Para compilar outro arquivo ainda dentro do **GHC**:

```bash
>> digite -> :l + arquivo
ghci> :l MeuOutroArquivo.hs

>> resultado
[1 of 2] Compiling Main             ( MeuOutroArquivo.hs, interpreted )
Ok, one module loaded.
ghci> 

>> digite a função e os parâmetros (ex. subtrai 10 3)
ghci> subtrai 3 4

>> resultado
7.0

>>  Para sair do GHC digite
ghci> :quit

>> resultado
Leaving GHCi.
root@haskell-app:/app#
```

