// ===== backend/routes/login.js =====
const express = require('express');
const axios = require('axios');
const router = express.Router();

const SAP_URL = process.env.SAP_EMPLOGIN_URL;
const SAP_USERNAME = process.env.SAP_USERNAME;
const SAP_PASSWORD = process.env.SAP_PASSWORD;

const SAP_AUTH = 'Basic ' + Buffer.from(`${SAP_USERNAME}:${SAP_PASSWORD}`).toString('base64');

router.post('/', async (req, res) => {
  const { empId, password } = req.body;

  try {
    const response = await axios.post(
      SAP_URL,
      { EmpId: empId, Password: password },
      {
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Accept': 'application/json',
          'Authorization': SAP_AUTH,
          'Cookie': 'sap-usercontext=sap-client=100'
        }
      }
    );

    const status = response.data?.d?.Status || 'N';

    if (status === 'Y') {
      return res.json({ status: 'Y' });
    } else {
      return res.json({ status: 'N' });
    }

  } catch (error) {
    console.error('Error from SAP OData:', error.message);
    res.json({ status: 'N' });
  }
});

module.exports = router;
