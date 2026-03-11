# Vue 3 + TypeScript + Vite

This template should help get you started developing with Vue 3 and TypeScript in Vite. The template uses Vue 3 `<script setup>` SFCs, check out the [script setup docs](https://v3.vuejs.org/api/sfc-script-setup.html#sfc-script-setup) to learn more.

Learn more about the recommended Project Setup and IDE Support in the [Vue Docs TypeScript Guide](https://vuejs.org/guide/typescript/overview.html#project-setup).


The template has some mock patterns along with [shadcn](https://www.shadcn-vue.com) components set up.

Run it in `docker-compose.yml` -
```yml
services:
  ui:
    build:
      context: .
      dockerfile: Dockerfile
    develop:
      watch:
        - path: ./src
          target: /app/src
          action: sync
```

Run with watch for hot reload -
```bash
docker compose up --build --watch
```