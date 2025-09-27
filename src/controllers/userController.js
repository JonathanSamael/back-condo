const prisma = require('../prismaClient')

// Criar usuário
exports.createUser = async (req, res) => {
  try {
    const {
      nomeCompleto,
      dataNascimento,
      tipoPessoa,
      estadoCivil,
      sexo,
      tipoCondomino,
      email,
      foto,
      condomino,
      fornecedor,
      sindico,
      funcionario,
      contatos,
      documentos,
      enderecos
    } = req.body;

    const user = await prisma.user.create({
      data: {
        nomeCompleto,
        dataNascimento: dataNascimento ? new Date(dataNascimento) : null,
        tipoPessoa,
        estadoCivil,
        sexo,
        tipoCondomino,
        email,
        foto,
        condomino,
        fornecedor,
        sindico,
        funcionario,

        contatos: contatos
          ? { create: contatos.map(c => ({ tipo: c.tipo, valor: c.valor })) }
          : undefined,

        documentos: documentos
          ? { create: documentos.map(d => ({ tipo: d.tipo, numero: d.numero })) }
          : undefined,

        enderecos: enderecos
          ? { create: enderecos.map(e => ({
              logradouro: e.logradouro,
              numero: e.numero,
              cidade: e.cidade,
              estado: e.estado,
              cep: e.cep,
            })) }
          : undefined,
      },
      include: {
        contatos: true,
        documentos: true,
        enderecos: true,
      },
    });

    res.status(201).json(user);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Erro ao criar usuário', details: error.message });
  }
};

// Listar usuários
exports.getUsers = async (req, res) => {
  try {
    const users = await prisma.user.findMany({
      include: {
        contatos: true,
        documentos: true,
        enderecos: true,
      },
    });
    res.json(users);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Erro ao buscar usuários', details: error.message });
  }
};
