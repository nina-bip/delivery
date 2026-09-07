/**
 * Secure order intake for Tasty Crusty.
 *
 * Deploy as a Firebase HTTPS function named `submitOrder`.
 * Branch emails stay here — never in the Flutter app.
 *
 * Required env:
 *   SMTP_HOST, SMTP_PORT, SMTP_USER, SMTP_PASS, SMTP_FROM
 */
const BRANCHES = {
  'alg-01': {
    wilayaId: 'algiers',
    name: 'Algiers — Hydra',
    wilayaName: 'Algiers',
    email: 'algiers.hydra@tastycrusty.dz',
  },
  'alg-02': {
    wilayaId: 'algiers',
    name: 'Algiers — Bab Ezzouar',
    wilayaName: 'Algiers',
    email: 'algiers.babezzouar@tastycrusty.dz',
  },
  'cst-01': {
    wilayaId: 'constantine',
    name: 'Constantine Branch',
    wilayaName: 'Constantine',
    email: 'constantine@tastycrusty.dz',
  },
  'orn-01': {
    wilayaId: 'oran',
    name: 'Oran Branch',
    wilayaName: 'Oran',
    email: 'oran@tastycrusty.dz',
  },
  'anb-01': {
    wilayaId: 'annaba',
    name: 'Annaba Branch',
    wilayaName: 'Annaba',
    email: 'annaba@tastycrusty.dz',
  },
};

function resolveBranch(wilayaId, branchId) {
  const matches = Object.entries(BRANCHES).filter(
    ([, b]) => b.wilayaId === wilayaId,
  );
  if (matches.length === 0) return null;
  if (matches.length === 1) {
    const [id, branch] = matches[0];
    return {id, ...branch};
  }
  if (!branchId || !BRANCHES[branchId] || BRANCHES[branchId].wilayaId !== wilayaId) {
    return null;
  }
  return {id: branchId, ...BRANCHES[branchId]};
}

function formatLines(lines) {
  if (!Array.isArray(lines) || lines.length === 0) return '—';
  return lines
    .map(
      (l) =>
        `${l.quantity} × ${l.name}  (${l.unitPriceDa} DA)  = ${l.lineTotalDa} DA`,
    )
    .join('\n');
}

function buildEmail(orderId, body, branch) {
  const c = body.customer || {};
  return [
    `Tasty Crusty order ${orderId}`,
    '',
    `Branch: ${branch.name}`,
    `Wilaya: ${branch.wilayaName}`,
    `Date: ${new Date().toISOString()}`,
    '',
    'Customer',
    `Name: ${c.fullName || ''}`,
    `Phone: ${c.phone || ''}`,
    `Address: ${c.address || ''}`,
    `Notes: ${c.notes || '—'}`,
    '',
    'Items',
    formatLines(body.items),
    '',
    'Extras',
    formatLines(body.extras),
    '',
    `TOTAL: ${body.totalDa} DA`,
  ].join('\n');
}

async function sendMail({to, subject, text}) {
  const nodemailer = require('nodemailer');
  const transporter = nodemailer.createTransport({
    host: process.env.SMTP_HOST,
    port: Number(process.env.SMTP_PORT || 587),
    secure: false,
    auth: {
      user: process.env.SMTP_USER,
      pass: process.env.SMTP_PASS,
    },
  });
  await transporter.sendMail({
    from: process.env.SMTP_FROM,
    to,
    subject,
    text,
  });
}

exports.submitOrder = async (req, res) => {
  if (req.method === 'OPTIONS') {
    res.set('Access-Control-Allow-Origin', '*');
    res.set('Access-Control-Allow-Headers', 'Content-Type');
    return res.status(204).send('');
  }
  res.set('Access-Control-Allow-Origin', '*');
  if (req.method !== 'POST') {
    return res.status(405).json({error: 'Method not allowed'});
  }

  const body = req.body || {};
  const branch = resolveBranch(body.wilayaId, body.branchId);
  if (!branch) {
    return res.status(400).json({error: 'Unknown Wilaya or branch'});
  }

  const orderId = `TC-${1000 + Math.floor(Math.random() * 9000)}`;
  const text = buildEmail(orderId, body, branch);

  try {
    await sendMail({
      to: branch.email,
      subject: `Tasty Crusty ${orderId} — ${branch.name}`,
      text,
    });
  } catch (err) {
    console.error(err);
    return res.status(500).json({error: 'Email failed'});
  }

  return res.status(200).json({
    orderId,
    branchName: branch.name,
    wilayaName: branch.wilayaName,
  });
};
