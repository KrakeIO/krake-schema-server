http    = require 'http'
KSON    = require 'kson'

class SchemaClient
  constructor: (@settings)->

  post: (query_schema, end_point, callback)->
    query_schema_string = encodeURIComponent(JSON.stringify(query_schema))
    post_options =
      host: @settings.host
      port: @settings.port
      path: end_point
      method: 'POST'
      headers: 
        'Content-Length': query_schema_string.length    

    post_req = http.request post_options, (res)=>
      console.log "response retrieved"
      res.setEncoding('utf8')
      
      consolidatedData = ""
      res.on 'data', (raw_data)=>
        consolidatedData += raw_data
      
      res.on 'end', ()=>
        response_obj = KSON.parse consolidatedData
        response_obj.message = response_obj.message || {}
        callback? response_obj.status, response_obj.message

    # write parameters to post body
    post_req.write(query_schema_string)
    post_req.end()


module.exports = SchemaClient