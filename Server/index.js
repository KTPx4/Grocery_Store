// library
const express = require('express')

// routes
const HomeRouter = require('./routes/homerouter')

// const
const _APP = express()
const PORT = 3000

//config
_APP.use(express.json())
require('dotenv').config()
_APP.use((req, res, next) =>{
    req.vars = {root: __dirname}
    next()
})

////

_APP.get("/api", HomeRouter)

_APP.listen(PORT, () => console.log("ok"))