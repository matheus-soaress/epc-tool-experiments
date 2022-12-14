# Experimentos Edge-pair-tool

Esse repositório contém os scripts utilizados para testar a ferramenta de cobertura de código disponível no seguinte repositório: https://github.com/matheus-soaress/edge-pair-cov-tool

---

### Executando script de teste

Na pasta dockerfile execute o seguinte comando para montar a imagem Docker usada para rodar os testes:

    *docker build -t epc-tool-experiments .*

Em seguida inicie o container Docker usando o comando:

    *docker run -dp 3000:3000 epc-tool-experiments*

https://docs.docker.com/get-started/02_our_app/