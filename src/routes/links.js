const express = require('express')
const router = express.Router()

const db = require('../database')

router.get('/add', function (req, res) {
    res.send('Form')
})

module.exports = router