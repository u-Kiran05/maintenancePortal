// ===== backend/server.js =====
require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const loginRoute = require('./routes/login');
const notificationsRoute = require('./routes/notifications');

const app = express();
const PORT = 5000;

app.use(cors());
app.use(bodyParser.json());

app.use('/api/login', loginRoute);
app.use('/api/notifications', notificationsRoute);

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
