var express = require('express')
var multer = require('multer');
var http = require('http')
 
const app = express();
 
app.get('/', function(req, res) {
    res.sendFile(__dirname + '/index.html');
});
 
var storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads')
  },
  filename: function (req, file, cb) {
    cb(null, file.fieldname + '-' + Date.now())
  }
})
 
var upload = multer({ storage: storage })


app.post('/uploadfile', upload.single('myFile'), (req, res, next) => {
  const file = req.file
  if (!file) {
    const error = new Error('Please upload a file')
    error.httpStatusCode = 400
    return next(error)
  }
    res.send("Upload successful")
  
})

http.createServer(app).listen(3000);
