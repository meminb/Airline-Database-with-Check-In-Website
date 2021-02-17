
var mysql = require('mysql');


const pool = mysql.createPool({
    host: "localhost",
    user: "root",
    password: "123456",
    database: "dbDemo1",
    dateStrings: true
  });

  
  var getConnection = function (cb) {
    pool.getConnection(function (err, connection) {
        if(err) {
          return cb(err);
        }
        cb(null, connection);
    });
};
module.exports = getConnection;













