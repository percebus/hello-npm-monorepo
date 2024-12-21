const express = require("express");
const app = express();
const port = 3000;

const package = require("../package.json");
const _ = require("lodash");

const version = `${package.version}.${_.now()}`;

app.get("/", (req, res) => {
  res.send(`Hello World! v${version}`);
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
