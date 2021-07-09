## Teste back-end - Credere

  Projeto para responder o desáfio técnico no link abaixo:
  
  * https://github.com/meucredere/backend

  Utilizando Elixir/Phoenix para construir a API.

----

## Instruções
  
  * **Instalar Elixir/Erlang**
    
    * Instalar com asdf em linux: https://www.pluralsight.com/guides/installing-elixir-erlang-with-asdf                   i   
  
  * **Instalar Phoenix**
    
    * https://hexdocs.pm/phoenix/installation.html

  * **Baixar/executar projeto**
    
    * `git clone https://github.com/davimonteiro7/backend-test-credere.git`
    * `cd backend-test-credere/probe_simulator`
    * `mix deps.get`
    * `mix phx.server`

----

## Endpoints

### Enviar sonda

  Envia uma sonda para a posição inicial (0,0) em um quadrante delimitado.
  Retorna um objeto JSON com uma mensagem de sucesso na criação.

* **URL**

  /api/probe_simulator/send_probe

* **Method:**

  `GET`
  
* **Success Response:**

  * **Code:** 201 <br />
    **Content:** `{"message":"Probe created successfully"}`
 
* **Error Response:**

  * **Code:** 404 NOT FOUND <br />

* **Sample Call:**

  local: `curl GET http://localhost:4000/api/probe_simulator/send_probe -v` 

----

### Mostrar sonda
  
  Retorna um objeto JSON com as informações da sonda enviada.

* **URL**

  /api/probe_simulator/show_probe

* **Method:**

  `GET`
  
* **Success Response:**

  * **Code:** 200 <br />
    **Content:** `{"face": current_face,"x": current_x, "y":current_y}`
 
* **Error Response:**

  * **Code:** 400 BAD REQUEST <br />
    **Content:** `{"message":"This probe was not created."}`

* **Sample Call:**

  local: `curl GET http://localhost:4000/api/probe_simulator/show_probe -v` 

----

### Movimentar sonda

  Retorna um objeto JSON com as informações atualizadas da sonda e uma descrição da sua movimentação.

* **URL**

  /api/probe_simulator/move_probe

* **Method:**

  `POST`
  
* **Data Params**


   Exemplo válido : {
                     "movimentos": ["GE", "M", "M", "M", "GD", "M", "M","M"]
                   }

* **Success Response:**

  * **Code:** 200 <br />
    **Content:** `{ "description":"a sonda girou para a esquerda, moveu 3 casa(s) no eixo y, girou para a direita, moveu 3 casa(s) no eixo x,","probe":{"x":3,"y":3} }`
 
* **Error Response:**

  * **Code:** 400 BAD REQUEST <br />
    **Content:** `{ "erro":"Um movemento inválido foi detectado, infelizmente a sonda ainda não possui a habilidade de se mover fora dos limites configurados (Quadrante 5x5)." }`

* **Sample Call:**

  local: `curl -X POST -H 'Content-Type: application/json' -d '{"movimentos": ["GE", "M", "M", "M", "GD", "M", "M","M"]}' http://localhost:4000/api/probe_simulator/move_probe -v` 

## Deploy

  Para fazer o deploy desta aplicação foi utilizado Elixir realeses e Gigalixir.
  
  Primeiro foi preciso prepara um release para o gigalixir.

  link: https://gigalixir.readthedocs.io/en/latest/modify-app/releases.html#modifying-existing-app-with-elixir-releases

  Foi seguida as orientações deste documente para isto, adaptando para esta API "não precisando configurar credencias para um banco de dados".

  Após criar a realease, segui este documento (https://gigalixir.readthedocs.io/en/latest/getting-started-guide.html#set-up-deploys) para fazer o deploy.

  Foi necessario mudar o repositório do projeto para utilizar o Gigalixir.
  Para acompanhar os passos anteriores do projeto, acceso o antigo repositorio:

  https://github.com/davimonteiro7/backend-test-credere   
  
----