const express = require('express');
const Router = express.Router();

const {responseMiddleware} = require('../services');

const {
	fetchDreamtrips,
	fetchDreamtrip
} = require('../db/mysql.dreamtrips');

Router.get('/dreamtrips', fetchDreamtrips, responseMiddleware);

Router.get('/:id/dreamtrip', fetchDreamtrip, responseMiddleware);

module.exports = Router;