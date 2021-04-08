const express = require('express')
const router = express.Router()
const timestampToDate = require('../lib/dates')

const db = require('../database')

router.get('/', async (req, res) => {
    try {
        const appointments = await db.query('SELECT * FROM appointment')
        res.render('collabs/list', {appointments})
    } catch (error) {
        console.log('Could not find appointments', error)
        res.send('There was an error')
    }
})

module.exports = router