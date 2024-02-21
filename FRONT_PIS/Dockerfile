FROM node:20.5.0
WORKDIR /workfront
COPY package*.json ./
RUN npm install 
RUN npm install -g npm@10.4.0
RUN npm install react-ace ace-builds
COPY . .
CMD ["npm","start"]
