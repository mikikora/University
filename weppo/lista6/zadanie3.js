var http = require("http");
var express = require("express");
var cookieParser = require("cookie-parser");
var app = express();
var session = require("express-session");
var FileStore = require("session-file-store")(session);

app.use(
  session({
    store: new FileStore(),
    secret: "my secret weppo code",
    resave: true,
    saveUninitialized: true,
  })
);

app.set("view engine", "ejs");
app.set("views", "./views3");
app.disable("etag");

app.use(cookieParser());

app.use(
  express.urlencoded({
    extended: true,
  })
);

app.get("/", (req, res) => {
  var cookieValue;
  if (!req.cookies.cookie) {
    cookieValue = new Date().toString();
    res.cookie("cookie", cookieValue);
  } else {
    cookieValue = req.cookies.cookie;
  }
  console.log(cookieValue);
  if (req.session.views) {
    req.session.views++;
  } else {
    req.session.views = 1;
  }
  res.render("index", { cookieValue: cookieValue, views: req.session.views });
});

app.get("/delete-cookie", (req, res) => {
  res.cookie("cookie", "", { expires: new Date(0) });
  console.log("cookie deleted");
  res.redirect("/");
});

app.get("/delete-views", (req, res) => {
  delete req.session.views;
  res.render("delete-views");
});

http.createServer(app).listen(3000);
