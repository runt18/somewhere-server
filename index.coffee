_ = require 'underscore'
express = require 'express'
app = express()

yelp = require('yelp').createClient(require('./credentials'))
n = 3

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
