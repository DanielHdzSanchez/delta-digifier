const express = require('express')
const router = express.Router()

const db = require('../database')

router.get('/', function (req, res) {
    res.render('services')
})

module.exports = router