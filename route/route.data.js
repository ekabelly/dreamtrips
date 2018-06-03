const express = require('express');
const Router = express.Router();

const {responseMiddleware} = require('../services');

const {
	addCountry,
	fetchCountries,
	addRegion,
	fetchRegionsByCountry,
	addCity,
} = require('../db/mysql.data');

Router.post('/addCountry', addCountry, responseMiddleware);

Router.get('/countries', fetchCountries, responseMiddleware);

Router.post('/addRegion', addRegion, responseMiddleware);

Router.get('/:countryId/regions', fetchRegionsByCountry, responseMiddleware);

Router.post('/addCity', addCity, responseMiddleware);

module.exports = Router;