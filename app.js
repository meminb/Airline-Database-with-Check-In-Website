
var http = require('http');

var mysql = require('mysql');
var async = require("async");
var express = require('express')
var app = express()
const bodyParser = require('body-parser')


var con = require('./controller')

app.use(bodyParser.json())

app.use(
  bodyParser.urlencoded({
    extended: true,
  })
)



var s = (req, res) => {
  //console.log("body ",req.body)
  con((err, conn) => {
    conn.query("insert into seats values(?,?,?,?,?,?)",
      [req.body.fnumber, req.body.fleg, req.body.date, req.body.seatno, req.body.cupass, req.body.fare], function (err, result1, fields) {

        if (err) {
          console.log(err); res.redirect('/')
        } else {
          res.redirect('/')
        }

      });
  });
}
var s2 = (req, res) => {
  ///console.log("body ",req.body)
  con((err, conn) => {
    conn.query("insert into ticket_info values(?,?,?,?,?)",
      [req.body.cupass2, req.body.fnumber2, req.body.fleg2, req.body.date2, req.body.seatno2], function (err, result1, fields) {


          conn.query("SELECT millage_info FROM ffc where passport_number=? and airline_code =? ",[req.body.cupass2, req.body.aircode],  function (err, result, fields) {
            if (err) throw err;
            
            var resultArray = Object.values(JSON.parse(JSON.stringify(result)))
              var mill= parseInt(resultArray[0].millage_info);
              
            var segment="";
              if(mill<250){console.log("Bronze");
                segment="Bronze";
              }else if(mill<500){console.log("Silver");
                segment="Silver";
              }else if(mill<750){console.log("Gold");
                segment="Gold";
              }else {console.log("Platin");
                segment="Platin";
              }
              conn.query("update ffc set segmentation =? where passport_number=? and airline_code =? ",[segment,req.body.cupass2, req.body.aircode],
                function (err, result, fields) {
                if (err) throw err;

              });

             // console.log(result.millage_info)
           //   
              //console.log("mill:  ",resultArray[1].millage_info)
      
  
          });



        if (err) {
          console.log(err); res.redirect('/')
        } else {
          res.redirect('/')
        }

      });
  });


}



app.post('/add2', s2)
app.post('/add', s)


//app.post("/add",clickme2());

app.set('view engine', 'pug')


app.get('/', function (req, res) {

  var flight_number;

  con((err, conn) => {
    conn.query("SELECT * FROM instances_with_prices order by instance_date desc", function (err, result1, fields) {
      if (err) throw err;

      conn.query("SELECT * FROM all_customers", function (err, result2, fields) {
        if (err) throw err;
        conn.query("SELECT * FROM notCheckIn", function (err, result3, fields) {
          if (err) throw err;


          res.render('index', { legView: result1, instances: result2, notChecked: result3 })
        });
      });
    });
  });
})
app.listen(8080, () => {
  console.log(`Server started at port 8080`);
});

/**
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello Worfddd!');
}).listen(8080);*/



/**
      for (let index = 0; index < result.length; index++) {
        leg_instance.push([
                 result[index].flight_number,
                      result[index].leg_no,
                      result[index].instance_date,
                      result[index].airplane_id,
                      result[index].number_of_available_seats,
                      result[index].distance,
                      result[index].departure_time,
                      result[index].arrival_time,
                      result[index].departure_Airport,
                      result[index].arrival_Airport,
                    ]);
      }*/