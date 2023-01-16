# Experimentos Edge-pair-tool

Esse repositório contém os scripts utilizados para testar a ferramenta de cobertura de código disponível no seguinte repositório: https://github.com/matheus-soaress/edge-pair-cov-tool

---

## Executando script de teste

Na pasta dockerfile execute o seguinte comando para montar a imagem Docker usada para rodar os testes:

    *docker build -t epc-tool-experiments .*

Em seguida inicie o container Docker usando o comando:

    *docker container run -i --name epc-tool-container epc-tool-experiments*

Para reiniciar o container parado use o comando:

    *docker container start epc-tool-container*
    
Para acessar o console do container use o comando:

    *docker exec -it epc-tool-container /bin/bash*

https://docs.docker.com/get-started/02_our_app/

## Problemas atuais

BA-control-flow quando instrumenta o Math, gera erro.

~~Cli e Compress nas versões iniciais usam o JUnit 3 e nas últimas usam o JUnit 4.~~ [CORRIGIDO]

Instrumentação da JaCoCo gera erro na execução do Compress.

Erro nas últimas versões do Cli tanto para JaCoCo quanto para ba-control-flow.

Mockito recebe erro em todas as versões quando a JaCoCo é utilizada e apenas para algumas versões no caso da ba-control-flow.

JaCoCo apresenta erro no report ao analisar o arquivo jacoco.exec. Suspeita de que o erro seja por analisar bibliotecas que não deveriam ser analisadas e que precisam ser removidas do classpath (pasta /target possui uma pasta /lib)