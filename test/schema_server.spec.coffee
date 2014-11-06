schema_server = require '../schema_server'
SchemaClient = require './helpers/schema_client'
request       = require 'request'

describe "schema_server", ->
  beforeEach (done)->
    @schema_server = schema_server.app.listen 10004
    @schema_client = new SchemaClient
      host: "localhost"
      port: 10004
    done()

  afterEach (done)->
    @schema_server.close()
    done()

  it "should return all the root columns of a krake definition", (done)->
    schema = require "./fixtures/basic_schema.coffee"
    request.post 
      url: "http://localhost:10004/columns",
      json: schema,
      (error, response, body)=>
        expect(response.statusCode).toEqual 200
        expect(body.status).toEqual "success"
        expect(body.data).toEqual [ 'some column 1', 'some column 2', 'origin_url', 'origin_pattern' ]
        done()

  it "should return all the columns including those that are nested of a krake definition", (done)->
    done()