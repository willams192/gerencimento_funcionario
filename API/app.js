const express = require('express')
const app = express()

app.get('/', (req, res) => {
  res.send('API funcionando!')
})

app.listen(3000, () => {
  console.log('API rodando na porta 3000')
})