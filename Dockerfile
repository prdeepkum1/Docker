# Container banane ke liye Node.js version 20 ka lightweight Alpine Linux image use karo
# FROM node:20-alpine

# COPY ./backend .

# RUN npm install

# CMD ["node", "server.js"]

FROM node:20-alpine as frontend-builder

COPY ./frontend /app
WORKDIR /app

RUN npm install

# make dist folder
RUN npm run build

# backend

FROM node:20-alpine

COPY ./backend /app
WORKDIR /app

RUN npm install

COPY --from=frontend-builder /app/dist /app/public

EXPOSE 8080

CMD ["node", "server.js"]