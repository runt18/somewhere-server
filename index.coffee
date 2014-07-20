_ = require 'underscore'
express = require 'express'
app = express()

yelp = require('yelp').createClient(require('./credentials'))
n = 3

allowCrossDomain = (req, res, next) ->
    res.header('Access-Control-Allow-Origin', '*')
    res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS')
    res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization, Content-Length, X-Requested-With')

    if req.method is 'OPTIONS'
        res.send(200)
    else
        next()

app.use(allowCrossDomain)

app.get '/:place', (req, res) ->
    params =
        location: req.params.place
        sort: 2
        category_filter: 'landmarks'

    yelp.search params, (error, data) ->
        if error
            res.send(JSON.stringify({ error: 'Failed to load' }))

        res.header("Content-Type", "application/json")

        b  = data.businesses[...n]
        console.log(b[0])

        ret = b.map (i) ->
            {
                name: i.name
                url: i.url
            }

        res.send(JSON.stringify(ret))

app.listen(3001)
