// ===== backend/routes/workorders.js =====
const express = require('express');
const axios = require('axios');
const router = express.Router();

const SAP_URL = process.env.SAP_WORKO_URL;
const SAP_AUTH = 'Basic ' + Buffer.from(`${process.env.SAP_USERNAME}:${process.env.SAP_PASSWORD}`).toString('base64');

// Convert SAP /Date(milliseconds)/ to YYYY-MM-DD
const convertSapDate = (sapDateStr) => {
  const match = sapDateStr?.match(/\/Date\((\d+)\)\//);
  return match ? new Date(parseInt(match[1], 10)).toISOString().split('T')[0] : '';
};

router.get('/:empId', async (req, res) => {
  const empId = req.params.empId;

  try {
    const response = await axios.get(`${SAP_URL}?$filter=EmpId eq '${empId}'`, {
      headers: {
        'Accept': 'application/json',
        'Authorization': SAP_AUTH,
        'Cookie': 'sap-usercontext=sap-client=100'
      }
    });

    const entries = response.data?.d?.results || [];

    const formatted = entries.map(item => ({
      Aufnr: item.Aufnr,
      Auart: item.Auart,
      Ktext: item.Ktext,
     Ernam: item.Ernam,
      Erdat: convertSapDate(item.Erdat),
      Bukrs: item.Bukrs,
      Kostl: item.Kostl,
      Kostv: item.Kostv,
      Gsber: item.Gsber,
      Stort: item.Stort,
      Sowrk: item.Sowrk,
      Scope: item.Scope,
      Gstrp: convertSapDate(item.Gstrp),
     // Equnr: item.Equnr,
     // Eqktx: item.Eqktx,
      EmpId: item.EmpId
    }));

    res.json({ success: true, data: formatted });
  } catch (error) {
    console.error('Error fetching SAP work orders:', error.message);
    res.status(500).json({ success: false, message: 'Failed to fetch work orders' });
  }
});

module.exports = router;
