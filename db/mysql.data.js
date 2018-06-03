const mysql = require('mysql');
const queries = require('./queries/queries.data');
const conn = require('../db/conn');

const {
	successHandler,
	errorHandler
} = require('../services');

const addCountry = (req, res, next) =>
	conn.query(queries.addCountry, [req.body.countryName], (err, row)=>
		errorHandler(err, res, ()=>successHandler(req, row, next)));

const fetchCountries = (req, res, next) =>conn.query(queries.countries, (err, rows)=>errorHandler(err, res, ()=>successHandler(req, rows[0], next)));


const addRegion = (req, res, next) =>
	conn.query(queries.addRegion, [req.body.regionName, req.body.countryId], (err, row)=>
		errorHandler(err, res, ()=>successHandler(req, row, next)));

const fetchRegionsByCountry = (req, res, next) =>conn.query(queries.regions, [req.params.countryId], (err, rows)=>errorHandler(err, res, ()=>successHandler(req, rows[0], next)));	

const addCity = (req, res, next) =>
	conn.query(queries.addCity, [req.body.cityName, req.body.regionId], (err, row)=>
		errorHandler(err, res, ()=>successHandler(req, row, next)));

module.exports = {
	addCountry,
	fetchCountries,
	addRegion,
	fetchRegionsByCountry,
	addCity
}