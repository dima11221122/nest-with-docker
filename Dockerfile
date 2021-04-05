FROM node:lts as build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . /app
RUN npm run build

# Final image
FROM node:lts as deploy
EXPOSE 3000
WORKDIR /app
COPY --from=build /app/dist /app
CMD node ./main.js

