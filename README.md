# ![Ruby Version](https://img.shields.io/badge/Ruby-3.2.2-red.svg) ![Rails Version](https://img.shields.io/badge/Rails-7.2.1-orange.svg) ![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)

#  Gerenciamento de convites

## 📜 Problema
Desenvolver uma aplicação Ruby on Rails para gerenciar convites.

## 📋 Escopo do Sistema
Ao logar no sistema, o administrador pode realizar os seguintes CRUDs:

### **Administradores**
- Adicionar
- Listar
- Excluir
- Editar

### **Empresas**
- Adicionar
- Listar
- Excluir
- Editar

### **Convites**
- Adicionar
- Listar
- Excluir
- Editar
- Filtrar por:
  - Nome
  - Empresa
  - e/ou Intervalo de tempo

Exemplo de filtro:
Se a empresa A tem 10 convites ativos em Janeiro e 2 foram desativados em Fevereiro, ao filtrar:
- Janeiro: 10 convites.
- Fevereiro: 8 convites.

---

## 🛠️ Implementação

## 🏗️ Arquitetura

- **Services**: Encapsulam regras de negócio complexas
  - CreateService: Gerencia criação de registros
  - UpdateService: Gerencia atualização de registros
  - DeleteService: Gerencia exclusão de registros

- **Queries**: Objetos específicos para consultas complexas
  - InvitationsQuery: Gerencia filtros e buscas de convites
    - Filtro por nome
    - Filtro por empresa
    - Filtro por intervalo de datas
    - Lógica de convites ativos/inativos

- **Models**: Implementam validações e associações
  - Admin: Gerencia autenticação e perfil
    - Autenticação via Devise
    - Associação com convites
  - Company: Representa empresas e suas validações
    - Validações de campos obrigatórios
    - Associação com convites
  - Invitation: Gerencia convites e suas regras
    - Associações com admin e company
    - Lógica de desativação
    - Validações de campos

- **Helpers**: Auxiliam na apresentação e formatação
  - CompanyHelper: Padroniza campos de formulário
    - number_only_field: Campo numérico com validação
    - Outros helpers de formatação
  - InvitationsHelper: Padroniza campos de formulário
    - available_statuses_for: Lista de status disponíveis para convites
    - can_edit_invitation?: Verifica se o convite pode ser editado

- **Controllers**: Gerenciam o fluxo da aplicação
  - AdminsController: Gerencia administradores
  - CompaniesController: Gerencia empresas
  - InvitationsController: Gerencia convites
  - ApplicationController: Configurações base

- **Views**: Interface do usuário
  - Layouts: Estrutura base das páginas
  - Partials: Componentes reutilizáveis
  - Forms: Formulários padronizados
  - Lists: Listagens e tabelas

- **Config**: Configurações da aplicação
  - Database: PostgreSQL
  - Devise: Configuração de autenticação
  - I18n: Internacionalização

## 🔐 Segurança

- Autenticação via Devise

## 🚀 Como rodar a aplicação

### 1. Clone este repositório para o seu ambiente local:

```bash
git clone git@github.com:laurameireles23/invite_manager.git
cd invite_manager
```

### 2. Construa a imagem:
```bash
docker-compose build
```


### 3. Prepare o banco de dados:
```bash
docker-compose run web rails db:create db:migrate
```


### 4. Inicie os serviços:
```bash
docker-compose up
```


### 5. Rode a aplicação:
```bash
docker-compose run --service-ports web
```

### Dica: 
- Caso queira facilitar os testes, foi disponibilizado uma massa de dados no seed. Basta rodar o seguinte comando após ter configurado o projeto.
```bash
docker-compose run web rails db:seed
```

## 🐳 Comandos docker uteis
- Construir os containers: docker-compose build

- Criar o banco de dados: docker-compose run web rails db:create db:migrate

- Iniciar a aplicação: docker-compose up

- Parar a aplicação: docker-compose down

- Verifique os containers rodando: docker-compose ps

- Verifique os logs se necessário: docker-compose logs

- Ver os logs em tempo real: docker-compose logs -f

- Rodar os testes: docker-compose run web rspec

- Acessar o console Rails: docker-compose run web rails console

- Rodar migrações: docker-compose run web rails db:migrate

- Rodar o debug: docker-compose run --service-ports webfddsf



## 📄 Licença

Este projeto está sob a licença MIT - veja o arquivo [LICENSE.md](LICENSE.md) para detalhes.
