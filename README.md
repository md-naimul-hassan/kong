# Kong API Gateway

Kong-only Docker gateway. Route traffic to other services by URL via `kong/kong.yml`.

## Quick start

```bash
docker compose up -d
```

| URL | Role |
|-----|------|
| http://localhost:8000 | Proxy |
| http://localhost:8001 | Admin API |
| http://localhost:8002 | Kong Manager (GUI) |

DB-less mode: lasting route changes go in `kong/kong.yml`, then `docker compose restart kong`.

## Add a service

Edit `kong/kong.yml`, then restart:

```bash
docker compose restart kong
```

Example — local app on host port `3000`:

```yaml
services:
  - name: my-api
    url: http://host.docker.internal:3000
    routes:
      - name: my-api-route
        paths:
          - /my-api
        strip_path: true
```

Then call: `curl http://localhost:8000/my-api`

Example — remote URL:

```yaml
services:
  - name: users-api
    url: https://api.example.com
    routes:
      - name: users-api-route
        paths:
          - /users
        strip_path: true
```

`strip_path: true` removes the Kong path prefix before forwarding (e.g. `/users/1` → upstream `/1`).

## Try the bundled example

```bash
curl http://localhost:8000/httpbin/get
```

## Commands

```bash
docker compose up -d
docker compose logs -f kong
docker compose restart kong   # after editing kong.yml
docker compose down
```

## Layout

```
.
├── docker-compose.yml
├── kong/kong.yml      # routes & upstream URLs
└── README.md
```
