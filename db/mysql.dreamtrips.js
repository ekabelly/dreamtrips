const mysql = require('mysql');
const queries = require('./queries/queries.dreamtrips');
const conn = require('../db/conn');

const {
	successHandler,
	errorHandler
} = require('../services');

const fetchDreamtrips = (req, res, next) =>conn.query(queries.dreamtrips, (err, rows)=>errorHandler(err, res, ()=>successHandler(req, rows[0], next)));

const fetchDreamtrip = (req, res, next) =>conn.query(queries.dreamtrip, req.params.id, (err, rows)=>errorHandler(err, res, ()=>successHandler(req, rows[0], next)));

module.exports = {
	fetchDreamtrips,
	fetchDreamtrip
}