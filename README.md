# Experimentos Edge-pair-tool

Esse repositório contém os scripts utilizados para testar a ferramenta de cobertura de código disponível no seguinte repositório: https://github.com/matheus-soaress/edge-pair-cov-tool

---

### Executando script de teste

Na pasta dockerfile execute o seguinte comando para montar a imagem Docker usada para rodar os testes:

    *docker build -t epc-tool-experiments .*

Em seguida inicie o container Docker usando o comando:

    *docker container run -i --name epc-tool-container epc-tool-experiments*

Para reiniciar o container parado use o comando:

    *docker container start -i epc-tool-container*
    
https://docs.docker.com/get-started/02_our_app/

### Problemas atuais

BA-control-flow quando instrumenta o Math, gera erro.

Cli nas versões iniciais usa o JUnit 3 e nas últimas usa o JUnit 4.