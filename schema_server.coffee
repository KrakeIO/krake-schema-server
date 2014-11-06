bodyParser        = require('body-parser')
express           = require 'express'
fs                = require 'fs'
KrakeQueryHelper  = require("krake-toolkit").query.helper
path              = require 'path'

# Web Server section of system
app = express()

app.use bodyParser.urlencoded({ extended: false })
app.use bodyParser.json()

app.set 'views', __dirname + '/views'
app.set 'view engine', 'ejs'
app.use express.static(__dirname + '/public')

app.get '/', (req, res)->
  res.render 'index'

app.post '/columns', (req, res)->
  query_helper = new KrakeQueryHelper req.body
  res.status(200).send
    status: "success"
    data: query_helper.getColumns()

module.exports = 
  app : app

if !module.parent
  # Start tutorial server
  port = process.argv[2] || 10004
  app.listen port
  console.log "Schema server listening at port : %s", port