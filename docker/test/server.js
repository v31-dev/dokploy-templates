const http = require('http');

const PORT = process.env.PORT || 3000;
const HOSTNAME_TAG = process.env.HOSTNAME_TAG || 'unknown';

const server = http.createServer((req, res) => {
  // Get client IP from X-Forwarded-For (set by proxy) or RemoteAddr
  const clientIp = req.headers['x-forwarded-for']?.split(',')[0].trim() || 
                   req.socket.remoteAddress || 
                   'unknown';

  // Log on server side
  const timestamp = new Date().toISOString();
  console.log(`[${timestamp}] Client IP: ${clientIp} | Method: ${req.method} | Path: ${req.url}`);

  // Safe headers to display
  const safeHeaders = {
    'user-agent': req.headers['user-agent'],
    'host': req.headers['host'],
    'cf-ipcountry': req.headers['cf-ipcountry']
  };

  const response = {
    server: HOSTNAME_TAG,
    clientIp: clientIp,
    timestamp: timestamp,
    headers: safeHeaders
  };

  res.writeHead(200, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify(response, null, 2));
});

server.listen(PORT, () => {
  console.log(`Health check server running on port ${PORT}`);
  console.log(`Server tag: ${HOSTNAME_TAG}`);
});
