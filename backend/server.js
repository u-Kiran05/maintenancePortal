// ===== backend/server.js =====
require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const loginRoute = require('./routes/login')

const app = express();
const PORT = 5000;

app.use(cors());
app.use(bodyParser.json());
app.use('/', loginRoute);

app.listen(PORT, () => {
  console.log(` Server running at http://localhost:${PORT}`);
});
