const express = require('express')
const router = express.Router()
const userController = require('../controllers/userController')

/**
 * @swagger
 * tags:
 *   name: Users
 *   description: Endpoints de gerenciamento de usuários
 */

/**
 * @swagger
 * /api/users:
 *   get:
 *     summary: Lista todos os usuários
 *     tags: [Users]
 *     responses:
 *       200:
 *         description: Lista de usuários
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 */
router.get('/', userController.getUsers)

/**
 * @swagger
 * /api/users:
 *   post:
 *     summary: Cria um novo usuário
 *     tags: [Users]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - nomeCompleto
 *               - email
 *             properties:
 *               nomeCompleto:
 *                 type: string
 *               email:
 *                 type: string
 *               dataNascimento:
 *                 type: string
 *                 format: date
 *     responses:
 *       201:
 *         description: Usuário criado com sucesso
 */
router.post('/', userController.createUser)

module.exports = router
