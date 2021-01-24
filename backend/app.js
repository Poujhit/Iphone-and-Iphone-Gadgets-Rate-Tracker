const { spawn } = require('child_process');

const process = spawn('python', ['./script/script.py']);

process.stdout.on('data', (data) => {
  console.log(JSON.parse(data));
});

process.stderr.on('data', function (data){
console.log(data.toString())
});