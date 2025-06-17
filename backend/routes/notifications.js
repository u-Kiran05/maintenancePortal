// ===== backend/routes/notifications.js =====
const express = require('express');
const axios = require('axios');
const router = express.Router();

const SAP_URL = process.env.SAP_NOTIF_URL;
const SAP_AUTH = 'Basic ' + Buffer.from(`${process.env.SAP_USERNAME}:${process.env.SAP_PASSWORD}`).toString('base64');

const convertSapDate = (sapDateStr) => {
  const match = sapDateStr.match(/\/Date\((\d+)\)\//);
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
      Qmnum: item.Qmnum,
      Qmart: item.Qmart,
      Qmtxt: item.Qmtxt,
      Priok: item.Priok || '-',
      Qmdat: convertSapDate(item.Qmdat),
      Strmn: convertSapDate(item.Strmn),
      Equnr: item.Equnr,
      Arbpl: item.Arbpl,
      Ingrp: item.Ingrp,
      Ernam: item.Ernam,
      EmpId: item.EmpId
    }));

    res.json({ success: true, data: formatted });

  } catch (error) {
    console.error('Error fetching SAP notifications:', error.message);
    res.status(500).json({ success: false, message: 'Failed to fetch notifications' });
  }
});

module.exports = router;
