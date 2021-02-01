const { spawn } = require('child_process');
const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
app.get('/data', (req, res) => {
  const proces = spawn('python', ['./script/script.py']);

  proces.stdout.on('data', (data) => {
    const sendData = JSON.parse(data); // console.log(JSON.parse(data));

    res.send(sendData);
  });

  proces.stderr.on('data', function (data) {
    console.log(data.toString());
  });
});

app.listen(port, () => console.log(`app listening on port!`));
