import express from 'express'
const route = express.Router()
import connection from '../config/mysql.js'
import asyncHandler from 'express-async-handler'

route.post('/search', asyncHandler(async (req, res) => {
    const { search } = req.body

    let sql = "SELECT * FROM MANAGERS WHERE " +
                `Fname LIKE "%${search}%" OR ` +
                `Minit LIKE "%${search}%" OR ` +
                `Lname LIKE "%${search}%";`;
    
    connection.query(sql, function (err, results) {
        if (err) throw err;
        res.json(results)
    })
}))

route.get('/:id', asyncHandler(async (req, res) => {
    const id = req.params.id
    let sql = `SELECT * FROM MANAGERS WHERE account_id=${id} LIMIT 1;`
    connection.query(sql, function (err, results) {
        if (err) {
            throw err
        };
        res.json(results);
    })
}))

route.patch('/:id', asyncHandler(async (req, res) => {
    const id = req.params.id
    const {
        fname, minit,
        lname, age, toeic, college
    } = req.body

    let sql = "UPDATE MANAGERS SET " +
                `Fname='${fname}',Minit='${minit}',Lname='${lname}',age=${age},` +
                `toeic_certification=${toeic},college_certification='${college}' ` +
                `WHERE account_id=${id};`;
    connection.query(sql, function (err, results) {
        if (err) throw err
        res.json({ success: true })
    })

}))

route.delete('/:id', asyncHandler(async (req, res) => {
    const id = req.params.id
    let sql = `DELETE FROM MANAGERS WHERE account_id=${id};`
    connection.query(sql, function (err, results) {
        if (err) {
            console.log(sql)
            throw err
        };
        res.json(true);
    })
}))

route.post('/', asyncHandler(async (req, res) => {
    const { username, fname, minit,
        lname, age, toeic, college } = req.body
    let sql = `CALL addManager('${username}', ${age}, '${college}', ${toeic}, '${fname}', '${minit}', '${lname}')`
    connection.query(sql, function (err, result) {
        if (err) throw err;
        res.json({ success: true })
    })
}))

route.get('/', asyncHandler(async (req, res) => {
    let sql = "SELECT * FROM MANAGERS;";

    connection.query(sql, function (err, results) {
        if (err) throw err;
        res.json(results);
    });
}))

export default route