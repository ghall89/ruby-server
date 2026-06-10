# Server

A simple forum app with a Ruby/Sinatra backend and a SvelteKit frontend.

## Stack

- **Backend** — Ruby, Sinatra, SQLite3 (`apps/server`)
- **Frontend** — SvelteKit, Deno (`apps/client`)

## Running with Docker

```
docker compose up --build
```

- Backend: http://localhost:3000
- Frontend: http://localhost:8000

The SQLite database is stored in a Docker volume (`db_data`) so it persists across container restarts and rebuilds.

## Environment Variables

| Variable | Service | Description |
|---|---|---|
| `RACK_ENV` | backend | Sinatra environment (`development`, `production`) |
| `DATABASE_PATH` | backend | Path to the SQLite database file |
| `API_URL` | frontend | URL of the backend API |

## Development

To rebuild after code changes:

```
docker compose up --build
```

To stop and remove containers (data is preserved in the volume):

```
docker compose down
```

To also remove the database volume:

```
docker compose down -v
```
