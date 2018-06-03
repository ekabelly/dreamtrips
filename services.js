const createSuccessResponse = data => ({data, success: true});
const responseMiddleware = (req, res) => res.json(createSuccessResponse(req.data));

const errorHandler = (err,res,cb) => {
	if (err) return res.json(err);
	if (cb) cb();
}

const successHandler = (req, rows, next) => {
	req.data = rows;
	return next();
}

const moreDataHandler = (req, more, rows, next) => {
	req.data[more] = rows;
	return next();
}

const arrangeData = (req,res,next) =>{
	const temp = {};
	req.data.forEach(entity=>{
		if (temp[entity.id]) {
			return Object.keys(entity).forEach(key=>{
				if (entity[key] !== temp[entity.id][key]) {
					console.log(key);
					temp[entity.id][key] = [temp[entity.id][key], entity[key]];
				}
			});
		}
		temp[entity.id] = entity;
	});
	req.data = temp;
	next();
}

const passCurrentUserId = (req, res, next) =>{
	req.data = {...req.data, userId:req.user.id};
	next();
}

const createUpdateQuery = (req, res, next) =>{
	let query = queryByReq(req)+'where id = ?';
	req.query = {...req.query, str:query};
	next();
}

const queryByReq = req =>{
	let query = '';
	const addQuery = (field, i) =>{
		if (field === 'id') return;
		if (valideField(field)) {  
		//every possible field will be here as a function 
		//that returns true or false if that field is valid
			query+=field+"=?";
		}	
		if (Object.values(req.body)[i+1]) query+=",";
	}
	Object.keys(req.body).forEach(addQuery);
	return query;
}

const createUpdateQueryArr = (req, res, next) =>{
	const createArr = (field, i) => {
		if (valideField(field)) {
			return Object.values(req.body)[i];
		}
	}
	const arr = Object.keys(req.body).map(createArr);
	arr.push(req.params.id);
	req.query = {...req.query, arr};
	next();
}

const valideField = field =>true;

module.exports = {
	responseMiddleware, 
	arrangeData,
	moreDataHandler,
	successHandler,
	errorHandler,
	passCurrentUserId,
	createUpdateQuery,
	createUpdateQueryArr
};