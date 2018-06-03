module.exports = {
	userResponse:(req, res)=>res.json({success:true, data:{id:req.user.id, email:req.user.email, picture:req.user.picture}}),
	validateUser:(req, res, next) => {
		if (req.isAuthenticated()) {
			console.log(req.user);
			return next();
		}
		return res.sendStatus(401);
	},
	validateAdmin:(req, res, next)=>{
		if (req.user.role === 'admin') {
			return next();
		}
		return res.sendStatus(401);
	}
}