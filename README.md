# Gerenciador de Funcionarios

Primeiro projeto em flutter consumindo e montando uma API, só esta funcionando o POST o Delete e Update não funciona, os dados só serão atualizados e excluídos localmente e não no banco de dados.


## Vamos Começar


Assim que clonar o repósitorio roda o seguinte script no terminal do VScode:
<br><br>

```bash
flutter pub get
``` 
-  Esse comando vai instalar as dependências necéssarias para rodar o projeto. 
<br><br>

Depois vai fazer os seguintes passos:
<br><br>

```bash
   cd ./API/
``` 
-   aqui você vai entrar na pasta da API
  <br><br>
  
  
  ```bash
   cnode app.js
``` 
-  aqui você vai subir o back-end, ou seja , o servidor local

<br><br>

Para rodar vai ser necéssario estar com o emulador aberto ou conectar o seu dispositivo móvel no cabo USB da sua máquina, com esse preparativos prontos, você vai nessa opção (lembrando se der algum erro tente abrir o arquivo main.dart, e depois tente executar novamente):
![image](https://github.com/willams192/gerencimento_funcionario/assets/84344077/05be3f46-d3d9-4637-af54-7b3f6fae6cab)

<br><br>

Quando for preencher o fórmulario para salvar os dados do funcionário vai ser preciso preencher três campos:


   - Nome => é obrigatório
   - Email => é obrigatório
   - Avatar Url => não é obrigatório

<br><br>

Se caso quiser preencher o terceiro campo vou disponibilizar algumas URLs para colocar nesse campo:
<br><br>

   - https://cdn.pixabay.com/photo/2014/04/03/10/32/businessman-310819_960_720.png
   - https://cdn.pixabay.com/photo/2016/08/20/05/36/avatar-1606914_960_720.png
   - https://cdn.pixabay.com/photo/2016/08/20/05/36/avatar-1606914_960_720.png
   - https://cdn.pixabay.com/photo/2014/04/02/14/11/male-306408_960_720.png

