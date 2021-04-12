const express = require('express')
const morgan = require('morgan')
const exphbs = require('express-handlebars')
const path = require('path')
//server init
const app = express()

//settings
app.set('port', process.env.PORT || 3000)
app.set('views', path.join(__dirname, 'views',))
app.engine('.hbs', exphbs({
    defaultLayout: 'main',
    layoutsDir: path.join(app.get('views'), 'layouts'),
    partialsDir: path.join(app.get('views'), 'partials'),
    extname: '.hbs',
    helpers: require('./lib/handlebars'),
}))
app.set('view engine', '.hbs')

//middlewares
app.use(morgan('dev'))
app.use(express.urlencoded({extended: false}))
app.use(express.json())

//global variables
app.use((req, res, next) => {
    next()
})

//routes
app.use(require('./routes'))
app.use(require('./routes/auth'))
app.use('/' , require('./routes/index'))
app.use('/services' , require('./routes/services'))
app.use('/links', require('./routes/links'))
app.use('/clients', require('./routes/clients'))
app.use('/collabs', require('./routes/collabs'))

//public
//app.use(express.static(path.join(__dirname, 'public')))

//starting the server
app.listen(app.get('port'), () => {
    console.log('Server listening on port ' + app.get('port'));
})