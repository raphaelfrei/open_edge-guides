![image](https://github.com/raphaelfrei/open_edge-guides/assets/16196820/15dd55a3-3a8a-46f1-acfc-c1510e3823e7)# OpenEdge Progress 4GL:

## Acesso a Licença de Estudante:

Para solicitar o acesso à conta de estudante:

### 1- Acessar o site da Progress e clicar no botão **GET STARTED** da opção **CLASSROOM**:

![image](https://github.com/raphaelfrei/open_edge-guides/assets/16196820/cf4ce73b-d825-40d8-bf63-7bd766dd8a5c)

Principais diferenças entre a versão **CLASSROOM** e **BASIC**: 

1- Só é permitido a conexão com **banco de dados local** *(Mono-Usuário)*<br>
2- Não permite rodar aplicativos na versão **Web** ou **Mobile**<br>
3- Os aplicativos compilados não rodam na versão **Client Networking** *(Versão que o cliente final usa)*<br>

### 2 - Criar uma nova conta, fornecendo os seguintes dados:

**Email:** Sua conta de email<br>
**Progress ID:** Seu nome de usuário<br>
**Password:** Sua senha<br>
**First Name:** Primeiro Nome<br>
**Last Name:** Último Nome<br>
**Company Name:** Escrever o seu nome *(Ou da empresa no qual trabalha)*<br>
**Company Type:** Escolher o tipo da empresa *(Caso tenha colocado seu nome, pode selecionar **TECHNOLOGY SYSTEM INTEGRATOR OR CONSULTANCY**)*<br>
**Job Title:** Opcional - Seu título no trabalho *(Como estudante, programador, engenheiro, etc.)*<br>
**Country:** País onde mora<br>
**State:** Estado onde mora<br>
**Telephone:** Seu número para contato<br>

Recomendo que utilize um email existente, pois será necessário receber um código de ativação.

### 3 - Após ativar a conta, fazer o login onde será redirecionado para essa página:

![image](https://github.com/raphaelfrei/open_edge-guides/assets/16196820/c3bc3ffb-0083-4ebe-b2b9-e4642dfe2b5f)

Caso apareça o erro '**Member/City: This required value is missing'**, preencha todos os campos (exceto Fax).

**Address:** Endereço da sua casa (Somente rua e número)<br>
**City:** Sua cidade<br>
**Postal Code:** CEP da residência (Caso não saiba, veja no site dos Correios ou no Google)<br>
**State/Prov.:** Selecionar qualquer opção - Não está aparecendo as opções no BR<br>
**Country:** Por conta do bug na opção acima, escolher USA<br>

No final da página, selecionar a opção **'Progress OpenEdge 12.2 Developer Kit Classroom Edition'** e clicar em **Submit**:

![image](https://github.com/raphaelfrei/open_edge-guides/assets/16196820/e188cc79-ce05-4ca2-b33a-718c903093d1)

Após, selecionar a opção **'Download an evaluation product'**:

![image](https://github.com/raphaelfrei/open_edge-guides/assets/16196820/278c4b1a-50b4-4f10-bfef-b843c494fe4a)

Clicar no **DESCRIPTION** do **DEVELOPER KIT CLASSROOM EDITION**:

![image](https://github.com/raphaelfrei/open_edge-guides/assets/16196820/bc06d091-887f-46df-b986-99a109e16750)

Leia e Aceite os **Termos de Uso**:

![image](https://github.com/raphaelfrei/open_edge-guides/assets/16196820/9bf18f60-0587-4552-8f00-4e68b4981440)

Após aceitar, deslize até o fim da pagina e clique na opção **FILE NAME > PROGRESS_OE_12.2_WIN_64_PDSOE.zip**:

![image](https://github.com/raphaelfrei/open_edge-guides/assets/16196820/10292368-8f94-4887-8d29-95d8326012f4)

### 3 - Instalação do Programa:

1 - Após o download do arquivo, extraia o **.zip** para uma pasta na Área de Trabalho

2 - Abrir o arquivo **Setup.exe** dentro da pasta *(Necessita de permissão de Administrador)*

3 - Caso apareça o seguinte erro de **Java JDK**:

![image](https://github.com/raphaelfrei/open_edge-guides/assets/16196820/d78e90a3-101b-4ad9-9b85-d1d46abd4e79)

3.1 - Caso não tenha, faça o download do [JDK](https://www.oracle.com/br/java/technologies/downloads/) e instale:

(Escolher a versão Windows x64 Installer)

3.2 - Volte para a pasta onde descompactou os arquivos e abra o **oedk_response.ini** e encontre a variável **JAVA_HOME** *(Linha 37)*:

Adicione a pasta de instalação do JDK como valor *(No meu caso, é a pasta padrão que fica em C:\Program Files\Java\jdk-xx.x.xx\)*:

*(Caso prefira, esse valor também pode ser setado na **PATH** em **Variáveis do Sistema**)*

![image](https://github.com/raphaelfrei/open_edge-guides/assets/16196820/32fecc8b-6b91-4c63-9b06-63bb9b88796a)

4 - Após os procedimentos, executar o arquivo de instalação novamente

5 - Após alguns minutos carregando, seguir as seguintes etapas:

![image](https://github.com/raphaelfrei/open_edge-guides/assets/16196820/ae0d356a-e66c-4881-90b5-c925b5600527)
![image](https://github.com/raphaelfrei/open_edge-guides/assets/16196820/64ac3cb5-4aa1-4300-b7ae-dffea2f2554f)
![image](https://github.com/raphaelfrei/open_edge-guides/assets/16196820/9b51baa7-2a63-4252-bf7f-a81f60b081cd)

6 - Pronto, a sua máquina já possui a versão de **Estudante do Progress** instalada. Caso queira ver os programas, acesse o **Menu Iniciar** e veja os conteúdos da pasta **Progress**.

![image](https://github.com/raphaelfrei/open_edge-guides/assets/16196820/d68d35a8-2cff-4faa-a819-b1f6718909c2)

