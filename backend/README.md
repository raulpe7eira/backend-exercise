# Backend

[![Elixir CI](https://github.com/raulpe7eira/backend-exercise/actions/workflows/elixir-ci.yml/badge.svg)](https://github.com/raulpe7eira/backend-exercise/actions/workflows/elixir-ci.yml)

> A small project to test my skills.

![backend-api snapshot](/backend/priv/static/docs/backend-api.png)

## :warning: You need install before to run locally

~> [git](https://git-scm.com) ++
[asdf](https://asdf-vm.com) ++
[Docker](https://docker.com)

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

After these commands, you can access the following features at [`localhost:4000`](http://localhost:4000). The API documentation is avaliable at home path `/docs`. I wrote with [API Blueprint](https://apiblueprint.org), I used [apiary](https://apiary.io) editor and generated the static `html` with [aglio](https://github.com/danielgtaylor/aglio).

## :dart: My decisions

1. I planning my deliver with [Github Project](https://github.com/raulpe7eira/backend-exercise/projects/1), and I lock some minute to doodles some pre-solutions, like the ones listed in [doodles section](#doodles).

1. My code structure has folders to put commands by entities, I don't kwon, if it's a good aprouch... :sweat_smile:.

1. Finally, the project was a very good exercise for me, thanks for the opportunite :pray:.

### :art: Doodles

> Entity relationship diagram

```mermaid
erDiagram
  USER }o..o{ PRODUCT : ""
  USER ||--o{ ORDER : ""
  ORDER }o..|{ PRODUCT : ""
```

> Sequence diagram to `GET /api/users/:user_id`

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

> Sequence diagram to `GET /api/products`

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

> Sequence diagram to `GET /api/products`

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
