const express = require('express')
const prisma = require('./prismaClient')
const app = express()
app.use(express.json())

app.get('/health', (req, res) => res.send('ok'))

// rota de teste para listar users
app.get('/users', async (req, res) => {
  try {
    const users = await prisma.user.findMany()
    res.json(users)
  } catch (err) {
    res.status(500).json({ error: err.message })
  }
})

app.listen(process.env.PORT || 3000, () => {
  console.log('Servidor rodando na porta', process.env.PORT || 3000)
})