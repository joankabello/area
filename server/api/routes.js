module.exports = function (app, passport) {
	const functionsApi = require("./api");
	const about = require('./about.json')

	app.get('/api/bitcoinGmail', function (req, res) {
		functionsApi.sendBitcoinGmail(req.query.accessToken, req)
			.then(message => {
				res.sendStatus(200);
			})
			.catch(err => {
				res.sendStatus(500);
			})
	});

	app.get('/api/cloudCoverGmail', function (req, res) {
		functionsApi.sendCloudCoverGmail(req.query.accessToken, req)
			.then(message => {
				res.sendStatus(200);
			})
			.catch(err => {
				console.log(err);
				res.sendStatus(500);
			})
	});

	app.get('/api/weatherNewsMail', function (req, res, next) {
		functionsApi.sendWeatheNewsMail(req)
			.then(message => {
				res.sendStatus(200);
			})
			.catch(err => {
				console.log(err)
				res.sendStatus(500);
			})
	});

	app.get('/api/newsMail', function (req, res) {
		functionsApi.sendNewsMail(req)
			.then(message => {
				res.sendStatus(200);
			})
			.catch(err => {
				console.log(err)
				res.sendStatus(500);
			})
	});

	app.get('/api/weatherMail', function (req, res) {
		console.log('pendinggggg');
		functionsApi.sendWeatherMail(req)
			.then(message => {
				console.log('senttttttt');
				res.sendStatus(200);
			})
			.catch(err => {
				console.log(err)
				res.sendStatus(500);
			})
	});

	app.get('/', function (req, res) {
		console.log("==========================")
		console.log(req.headers.authorization);
		res.send(200);
	});

	app.get('/api/cookDrive', function (req, res) {
		functionsApi.saveRecipeDrive(req.query.accessToken, req)
		.then(() => {
			res.sendStatus(200)
		})
		.catch(err => {
			res.sendStatus(500);
		})
	});

	app.get('/api/cookDriveGmail', function (req, res) {
		functionsApi.saveRecipeDriveGmail(req.query.accessToken, req)
		.then(() => {
			res.sendStatus(200)
		})
		.catch(err => {
			res.sendStatus(500);
		})
	});

	app.get('/api/weatherGmail', function (req, res) {
		functionsApi.weatherGmail(req.query.accessToken, req)
		.then(() => {
			res.sendStatus(200)
		})
		.catch(err => {
			res.sendStatus(500);
		})
	});

	app.get('/api/newsGmail', function (req, res) {
		functionsApi.newsGmail(req.query.accessToken, req)
		.then(() => {
			res.sendStatus(200)
		})
		.catch(err => {
			res.sendStatus(500);
		})
	});
	app.get('/api/issMail', function (req, res) {
		functionsApi.getIISMail(req)
		.then(() => {
			res.sendStatus(200)
		})
		.catch(err => {
			res.sendStatus(500);
		})
	});

	app.get('/about.json', function(req, res) {
		res.json(about)
	})

	app.post('/login', function (req, res, next) {
		passport.authenticate('local-login', function (err, user, info) {
			console.log(user);

			if (err) { return next(err); }
			if (!user) { return res.send(505); }
			req.logIn(user, function (err) {
				if (err) { return next(err); }
				return res.send(200);
			});
		})(req, res, next);
	});

	app.post('/signup', passport.authenticate('local-signup', {
		successRedirect: '/profile',
		failureRedirect: '/',
		failureFlash: true
	}));
	app.get('*', function(req, res){
		console.log("===========404==========")
		res.status(404).send('not found');
	  });	
};
