FROM node:20.14.0
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run test
EXPOSE 8000
CMD ["npm", "run", "start"]