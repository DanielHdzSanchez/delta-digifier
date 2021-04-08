const express = require('express')
const router = express.Router()

const db = require('../database')

router.get('/new', function (req, res) {
    res.render('clients/new')
})

router.post('/new', async (req, res) => {
    const {title} = req.body
    const newAppointment = {
        clients_id: 1,
        services_id: 1,
        appointment: `1617910197`,
        done: 0,
        feedback: title
    }
    try {
        await db.query('INSERT INTO appointment set ?',[newAppointment])
    } catch (error) {
        console.log(`Could not insert appointment: ${error}`)
    }
    res.send('Appointment added')
})

module.exports = router