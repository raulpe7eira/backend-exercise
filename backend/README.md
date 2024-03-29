# Backend

[![Elixir CI](https://github.com/raulpe7eira/backend-exercise/actions/workflows/elixir-ci.yml/badge.svg)](https://github.com/raulpe7eira/backend-exercise/actions/workflows/elixir-ci.yml)
[![codecov](https://codecov.io/gh/raulpe7eira/backend-exercise/branch/master/graph/badge.svg?token=Z459543PDI)](https://codecov.io/gh/raulpe7eira/backend-exercise)

> A small project to test my skills. It's a simple API can be used by company employees to self-manage their benefits.

![backend-api snapshot](/backend/priv/static/docs/backend-api.png)

## :warning: You need install before to run locally

- [x] [git](https://git-scm.com)
- [x] [asdf](https://asdf-vm.com)
- [x] [docker](https://docker.com)

## :writing_hand: How to use and run locally?

```bash
# Clone this repository
git clone git@github.com:raulpe7eira/backend-exercise.git

# Setup working directory
cd backend

# Install erlang and elixir
asdf install

# Install dependencies
mix deps.get

# Start database
docker-compose up -d

# Setup database
mix ecto.setup

# Run check lint
mix credo --strict

# Run check format
mix format --check-formatted

# Run check security
mix sobelow --config

# Run check quality
mix coveralls.html

# Start server or inside IEx with `iex -S mix phx.server`
mix phx.server
```

After these commands, you can access the following features at [`localhost:4000`](http://localhost:4000) and the API documentation is avaliable at `/docs` path only in `dev` or `test` environment.

> **Note:** I wrote API documentation with [API Blueprint](https://apiblueprint.org), I used [apiary](https://apiary.io) editor and generated the static `HTML` with [aglio](https://github.com/danielgtaylor/aglio).

## :dart: My decisions

1. I planning my deliver with [github project](https://github.com/raulpe7eira/backend-exercise/projects/1), and I lock some minute to doodles some pre-solutions, like the ones listed in [this section](#art-my-doodles).

1. My code structure has folders to put commands by models and models (schemas) in root of domain. By the way, the controller access the domain by facade. I don't kwon if it's a good aprouch... :sweat_smile: ...but this explanation is important to anyone to find your self in this project.

    ```diff
    ...
     ├── lib
     │   ├── backend
    +│   │   ├── orders           # order commands
     │   │   │   └── create.ex
    +│   │   ├── products         # product commands
     │   │   │   ├── list.ex
     │   │   │   └── sum.ex
    +│   │   ├── users            # user commands
     │   │   │   ├── create.ex
     │   │   │   ├── get.ex
     │   │   │   └── update.ex
     │   │   ├── application.ex
    +│   │   ├── order.ex         # order model
    +│   │   ├── product.ex       # product model
     │   │   ├── repo.ex
    +│   │   ├── user.ex          # user model
    +│   ├── backend.ex           # facade
     │   └── backend_web.ex
    ...
    ```

1. Finally, the project was a very good exercise for me, thanks for the opportunite :pray:.

## :art: My Doodles

- [x] Entity relationship diagram:

```mermaid
erDiagram
  USER }o..o{ PRODUCT : ""
  USER ||--o{ ORDER : ""
  ORDER }o..|{ PRODUCT : ""
```

- [x] Sequence diagram to `GET /api/users/:user_id`:

```mermaid
sequenceDiagram
    actor FRONTEND
    participant BACKEND

    participant U_COMMAND as USER <br/> <<command>>
    participant U_MODEL as USER <br/> <<model>>

    participant BASE

    FRONTEND->>+BACKEND: GET /api/users/:user_id
    BACKEND->>+U_COMMAND: Get or Create user <br/> by :username

    U_COMMAND->>+U_MODEL: Get user <br/> by :username
    U_MODEL->>+BASE: Select user <br/> by :username
    BASE-->>-U_MODEL: :not_found
    U_MODEL-->>-U_COMMAND: :not_found

    U_COMMAND->>+U_MODEL: Create user <br/> for :username
    U_MODEL->>+BASE: Create user <br/> for :username
    BASE-->>-U_MODEL: :user
    U_MODEL-->>-U_COMMAND: :user

    U_COMMAND-->>-BACKEND: :200 ++ :user
    BACKEND-->>-FRONTEND: :200 ++ :user
```

- [x] Sequence diagram to `GET /api/products`:

```mermaid
sequenceDiagram
    actor FRONTEND
    participant BACKEND

    participant P_COMMAND as PRODUCT <br/> <<command>>
    participant P_MODEL as PRODUCT <br/> <<model>>

    participant BASE

    FRONTEND->>+BACKEND: GET /api/products
    BACKEND->>+P_COMMAND: List all products

    P_COMMAND->>+P_MODEL: List all products
    P_MODEL->>+BASE: Select products
    BASE-->>-P_MODEL: :[products]
    P_MODEL-->>-P_COMMAND: :[products]
    
    P_COMMAND-->>-BACKEND: :200 ++ :[products]
    BACKEND-->>-FRONTEND: :200 ++ :[products]
```

- [x] Sequence diagram to `GET /api/products`:

```mermaid
sequenceDiagram
    actor FRONTEND
    participant BACKEND

    participant O_COMMAND as ORDER <br/> <<command>>
    participant O_MODEL as OERDER <br/> <<model>>

    participant P_COMMAND as PRODUCT <br/> <<command>>
    participant P_MODEL as PRODUCT <br/> <<model>>

    participant U_COMMAND as USER <br/> <<command>>
    participant U_MODEL as USER <br/> <<model>>

    participant BASE

    FRONTEND->>+BACKEND: POST /api/orders
    BACKEND->>+O_COMMAND: Create order <br/> by :username

    O_COMMAND->>+P_COMMAND: List all products <br/> in :product_ids
    P_COMMAND->>+P_MODEL: List all products <br/> in :product_ids
    P_MODEL->>+BASE: Select products <br/> in :product_ids
    BASE-->>-P_MODEL: :[products]
    P_MODEL-->>-P_COMMAND: :[products]
    P_COMMAND-->>-O_COMMAND: :[products]

    O_COMMAND->>O_COMMAND: Verify products not found [!]

    O_COMMAND->>+U_COMMAND: Get user <br/> by :username
    U_COMMAND->>+U_MODEL: Get user <br/> by :username
    U_MODEL->>+BASE: Select user <br/> by :username
    BASE-->>-U_MODEL: :user
    U_MODEL-->>-U_COMMAND: :user
    U_COMMAND-->>-O_COMMAND: :user

    O_COMMAND->>O_COMMAND: Verify products already purchased [!]

    O_COMMAND->>+P_COMMAND: Sum prices <br/> by :[produts]
    P_COMMAND-->>-O_COMMAND: :total

    O_COMMAND->>O_COMMAND: Verify insufficient balance [!]

    O_COMMAND->>+O_MODEL: Create order <br/> by :username
    O_MODEL->>+BASE: Create order
    BASE-->>-O_MODEL: :order
    O_MODEL-->>-O_COMMAND: :order

    O_COMMAND->>+U_COMMAND: Update benefits <br/> by :username
    U_COMMAND->>+U_MODEL: Update benefits <br/> by :username
    U_MODEL->>+BASE: Update user <br/> by :username
    BASE-->>-U_MODEL: :user
    U_MODEL-->>-U_COMMAND: :user
    U_COMMAND-->>-O_COMMAND: :user

    O_COMMAND-->>-BACKEND: :200 ++ :order
    BACKEND-->>-FRONTEND: :200 ++ :order
```

## :bellhop_bell: CI / CD

- [x] Flow chart:

```mermaid
graph LR
    A([Code]) -->|"push (master)<br/>or pull_request"| B{is Backend ?}

    subgraph "CI (github action)"
    B -->|yes| C[[Check Format]]
    C --> D[[Check Lint]]
    D --> E[[Check Security]]
    E --> F[[Check Quality]]
    F --> G{Passed?}
    end

    G --> |no| H(["Locked<br/>Merge"])

    G --> |yes| I(["Released<br/>Merge"])
    B -->|no| I
    I --> |"merge (master)"| K

    subgraph "CD (heroku)"
    K[[Deploy]]
    end

    K --> L(["Code<br/>in Poduction"])
```

## :rocket: Test the integration in a simulated production environment

- [x] Frontend: https://coverflex-frontend-app.herokuapp.com
- [x] Backend: https://coverflex-backend-app.herokuapp.com

## :crystal_ball: Future improvements

- [ ] Create an strong relationship between `user` and `product` https://github.com/raulpe7eira/backend-exercise/issues/36
- [ ] Create an strong relationship between `order` and `product` https://github.com/raulpe7eira/backend-exercise/issues/37
- [ ] Review returned status code https://github.com/raulpe7eira/backend-exercise/issues/28
- [ ] Improve observability in general (logging and metrics) https://github.com/raulpe7eira/backend-exercise/issues/29
- [ ] Access security to resources https://github.com/raulpe7eira/backend-exercise/issues/30
- [ ] Product catalog with cache https://github.com/raulpe7eira/backend-exercise/issues/31
