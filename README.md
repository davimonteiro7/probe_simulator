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
