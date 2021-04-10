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
        //req.flash('success', 'Cita programada correctamente')
    } catch (error) {
        console.log(`Could not insert appointment: ${error}`)
    }
    res.redirect('/clients/new')
})


router.get('/feedback/:id', async (req, res) => {
    const id = req.params;
    const appointment = await db.query('SELECT * FROM appointment WHERE id = ?', [id])
    res.render('clients/edit', {appointment: appointment[0]})
})

router.post('/feedback/:id', async (req, res) => {
    const { id } = req.params;
    const {parametros} = req.body
    const feedback = {
        feedback
    }
    await db.query('UPDATE appointment set ? WHERE id = ?', [feedback], [id])
    res.redirect('clients/new')
})

module.exports = router