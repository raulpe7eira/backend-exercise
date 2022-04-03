# Backend

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## ER Diagram

```mermaid
erDiagram
  USER }o..o{ PRODUCT : ""
  USER ||--o{ ORDER : ""
  ORDER }o..|{ PRODUCT : ""
```

## Feature `GET /api/users/:user_id`

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

## Feature `GET /api/products`

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

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
