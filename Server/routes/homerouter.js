const express = require('express')
const app = express.Router()

app.get('/', () => console.log("home page"))



module.exports = app