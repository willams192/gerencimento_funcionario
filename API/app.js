const express = require('express')
const app = express()
const routes = require('./Routes/user_route')


app.use(routes)

app.listen(3000, () => {
  console.log('API rodando na porta 3000')
})