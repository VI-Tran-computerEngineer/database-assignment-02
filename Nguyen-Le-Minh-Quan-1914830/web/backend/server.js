import express from 'express'
import connection from './config/mysql.js'
import managerRoute from './routes/managerRoute.js'
const app = express()

app.use(express.json())

connection.connect(function (err) {
    if (err) {
        console.error('error connecting: ' + err.stack);
        return;
    }
    console.log('connected as id ' + connection.threadId);
});

// connectDB()

const notFound = (req, res, next) => {
    const error = new Error(`Not Found - ${req.originalUrl}`)
    res.status(404)
    next(error)
}

const errorHandler = (err, req, res, next) => {
    const statusCode = res.statusCode === 200 ? 500 : res.statusCode
    res.status(statusCode)
    res.json({
        message: err.message,
        stack: process.env.NODE_ENV === 'production' ? null : err.stack,
    })
}

app.use('/manager', managerRoute)

app.use(notFound)
app.use(errorHandler)


app.listen(5000, () => {
    console.log('Server is running at http://localhost:5000')
})