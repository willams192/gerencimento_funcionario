var express = require('express'),
  path = require('path'),
  bodyParser = require('body-parser'),
  cors = require('cors'),
  mongoose = require('mongoose');

mongoose.Promise = global.Promise;
mongoose.connect('mongodb://127.0.0.1:27017/Funcionarios', { useNewUrlParser: true, useUnifiedTopology: true, useFindAndModify: false }).then(
  () => { console.log('Database is connected') },
  err => { console.log('Can not connect to the database' + err) });

const funcionarioRoute = require('./Routes/funcionario.route');

var app = express();
app.use(bodyParser.json());
app.use(cors());

app.use('/funcionario', funcionarioRoute);
app.get('/', function (req, res) {
  res.send("Hello World!");
});

app.listen(3000, function () {
  console.log('Listening on port 3000!');
});