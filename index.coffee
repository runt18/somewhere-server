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
            throw error

        res.header("Content-Type", "application/json")

        ret = data.businesses[...n].map (i) ->
            {
                name: i.name
            }

        res.send(JSON.stringify(ret))

app.listen(3001)
