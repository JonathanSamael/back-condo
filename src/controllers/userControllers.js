const prisma = require('./prismaClient')

// Criar usuário
exports.createUser = async (req, res) => {
  try {
    //editar cadastro de user para modelo novo com todos os dados
    const { name, email, password } = req.body
    const user = await prisma.user.create({
      data: { name, email, password }
    })
    res.json(user)
  } catch (error) {
    res.status(400).json({ error: error.message })
  }
}

// Listar usuários
exports.getUsers = async (req, res) => {
  const users = await prisma.user.findMany()
  res.json(users)
}