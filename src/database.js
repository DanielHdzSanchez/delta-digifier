const mysql = require('mysql');
const { promisify } = require('util');
const { database } = require('./keys')

const pool = mysql.createPool(database)
pool.getConnection((err, connection) => {
    if (err) {
        if(err.code === 'PROTOCOL_CONNECTION_LOST') {
            console.error('DATABASE CONNECTION LOST')
        }
        if(err.code === 'ER_CON_COUNT_ERROR') {
            console.error('DATABASE HAS TOO MANY CONNECTIONS')
        }
        if(err.code === 'ECONNREFUSED') {
            console.error('DATABASE CONNECTION REFUSED')
        }
    }
    if(connection) connection.release()
    console.log('Connected to database')
    return
})
//Promisify pool queries, promises, async awaint enabled
pool.query = promisify(pool.query)

module.exports = pool