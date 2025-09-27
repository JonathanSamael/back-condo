const express = require('express')
const userRoutes = require("./routes/userRoutes")
const swaggerUi = require('swagger-ui-express')
const swaggerSpec = require("./config/swagger.config")

const app = express();
const port = process.env.PORT || 3000;


app.use(express.json())

app.use("/api/users", userRoutes);
app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerSpec));
app.get("/hello", (req, res) => res.send('ok'));


app.listen(port, () => {
  console.log('🚀 Server running on http://localhost:3000')
  console.log('📖 Swagger docs on http://localhost:3000/api-docs')
});