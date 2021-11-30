import mysql from 'mysql'
var connection = mysql.createConnection({
    host: 'localhost',
    user: 'mq',
    password: 'minhquan',
    database: 'BTL2'
});
    
export default connection