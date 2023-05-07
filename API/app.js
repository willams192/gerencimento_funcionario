var express = require('express'),

  mongoose = require('mongoose')
  ;


mongoose.Promise = global.Promise;
mongoose.connect('mongodb://127.0.0.1:27017/Funcionarios', {
  useNewUrlParser: true,
  useUnifiedTopology: true
}).then(
  () => { console.log('Database is connected') },
  err => { console.log('Can not connect to the database' + err) });



const userRoute = require('./Routes/user_route');
var app = express();


app.use('/user', userRoute);

app.listen(3000, () => {
  console.log('API rodando na porta 3000')
})