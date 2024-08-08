FROM ubuntu
RUN apt-get update && apt-get install npm nodejs -yq
RUN apt-get install git -yq
RUN git clone https://github.com/vrdipu/contactlistAPP.git
WORKDIR /contactlistAPP/contactlistapp
RUN npm install express mongojs body-parser
EXPOSE 3000
CMD ["nodejs", "server.js"]
