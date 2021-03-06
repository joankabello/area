const rp = require('request-promise');
const Base64 = require('js-base64').Base64;
const request = require('request');
const nodemailer = require("nodemailer");
var schedule = require('node-schedule');

function getBitcoinPrice() {
    return new Promise((resolve, reject) => {
        let options = {
            method: 'GET',
            uri: 'https://api.coindesk.com/v1/bpi/currentprice.json',
            json: true
        }
        rp(options)
            .then(message => {
                let bitcoinPrice = message.bpi.USD.rate_float;
                resolve(bitcoinPrice);
            })
            .catch(err => {
                reject(500);
            });
    })
};

function getCloudCover() {
    return new Promise((resolve, reject) => {
        let options = {
            method: 'GET',
            uri: 'http://www.7timer.info/bin/api.pl?lon=41.3275&lat=19.8187&product=astro&output=json',
            json: true
        }
        rp(options)
            .then(message => {
                let cloudCover = message.dataseries[0]['cloudcover'];
                resolve(cloudCover);
            })
            .catch(err => {
                reject(500);
            });
    })
};

function sendGmail(accessToken, bitcoinPrice, req, subject, bodyMsg) {
    return new Promise((resolve, reject) => {
        var checkEmails = req.query.isGoogleLogged == "false" ? req.query.email : req.query.googleEmail;
        var encodedEmail = Base64.encodeURI("to: " + checkEmails + "\nfrom: area.project2020@gmail.com\nsubject: " + subject + "\r\n\r\n" + bodyMsg);

        let options = {
            method: 'POST',
            uri: 'https://content.googleapis.com/gmail/v1/users/me/messages/send',
            headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer " + accessToken
            },
            body: {
                "raw": encodedEmail
            },
            json: true
        }
        rp(options)
            .then(message => {
                resolve(200);
            })
            .catch(err => {
                reject(500);
            });
    })
}

exports.sendCloudCoverGmail = (accessToken, req) => {
    return new Promise((resolve, reject) => {
        if (req.query.state == "true") {
            schedule.scheduleJob('01 19 * * *', function () {
                getCloudCover()
                    .then(cloudCover => {
                        let subject = "Cloud Today"
                        let bodyMsg = "Today there are so much clouds in the sky, don't forget your umbrella";
                        if (cloudCover > 0)
                            return sendGmail(accessToken, cloudCover, req, subject, bodyMsg)
                    })
                    .then(() => {
                        resolve(200)
                    })
                    .catch(err => {
                        console.log(err);
                        reject(500)
                    })
            })
        }
    });

}

exports.sendBitcoinGmail = (accessToken, req) => {
    return new Promise((resolve, reject) => {
        if (req.query.state == "true") {
            schedule.scheduleJob('01 19 * * *', function () {
                getBitcoinPrice()
                    .then(price => {
                        let subject = "Bitcoin Price for today."
                        let bodyMsg = "Bitcoin Price for today is " + price + "$";
                        if (price > 900)
                            return sendGmail(accessToken, price, req, subject, bodyMsg)
                    })
                    .then(() => {
                        resolve(200)
                    })
                    .catch(err => {
                        reject(500)
                    })
            })
        }
    });

}

async function sendMail(req, subject, html) {
    let transporter = nodemailer.createTransport({
        secure: false,
        service: 'gmail',
        auth: {
            user: 'area.project2020@gmail.com',
            pass: 'area2020'
        }
    });
    console.log(req.query.email);
    console.log(req.query.isGoogleLogged);
    console.log(req.query.googleEmail);

    let info = await transporter.sendMail({
        from: 'area.project2020@gmail.com',
        to: req.query.isGoogleLogged == "false" ? req.query.email : req.query.googleEmail,
        subject: subject,
        html: html
    });

    console.log("Message sent: %s", info.messageId);
    console.log("Preview URL: %s", nodemailer.getTestMessageUrl(info));
}


exports.sendNewsMail = (req) => {
    return new Promise((resolve, reject) => {
        if (req.query.state == "true") {
            schedule.scheduleJob('01 19 * * *', function () {
                console.log(req.query.state);
                var newDate = new Date().toJSON().split("T")[0];
                console.log("newdateee" + newDate);
                console.log("+++++1 seconds passed")
                const apiKey = '848f660b15a0406d97218e1d721fdb2c';
                var url = `http://newsapi.org/v2/everything?q=bitcoin&from=${newDate}&to=${newDate}&sortBy=popularity&apiKey=${apiKey}`;

                request(url, async function (err, resonse, body) {
                    var getnews = JSON.parse(body);
                    var objective = Object.values(getnews['articles']);
                    var newsTitle = objective[0]['title'];
                    var datePublished = objective[0]['publishedAt'];
                    var myDate = new Date().toISOString();
                    var parsedDate = datePublished.substr(0, 10);
                    if (parsedDate == newDate) {
                        sendMail(req, "Bitcoin for today", `<p>Bitcoin News for Today:</p><b>${newsTitle}</b>`);
                        resolve(200);
                    }
                });
            })
        }
    })
}

exports.sendWeatherMail = (req) => {
    return new Promise((resolve, reject) => {
        if (req.query.state == "true") {
            console.log(req.query.state);
            schedule.scheduleJob('50 16 * * *', function () {
                const apiKeyWeather = '3b4c6d7b3b9bf7a1e756ffc69c9a7b1a';
                let urlWeather = `http://api.openweathermap.org/data/2.5/weather?q=Tirana&units=metric&APPID=${apiKeyWeather}`

                request(urlWeather, function (err, response, body) {
                    if (err) {
                        response.json({ weather: null, error: 'Error, please try again1' });
                    } else {
                        var weather = JSON.parse(body);

                        if (weather.main.temp < 18) {
                            var weatherText = `It's ${weather.main.temp} °C degrees in ${weather.name}!`;
                            sendMail(req, "Weather today", `<p>Weather Forecast for Today:</p><b>${weatherText}</b>`);
                            resolve(200)
                        }
                    }

                });
            });
        }
    })
}

exports.sendWeatheNewsMail = (req) => {
    return new Promise((resolve, reject) => {
        if (req.query.state == "true") {
            console.log(req.query.state);
            schedule.scheduleJob('23 18 * * *', function () {
                console.log("+++++1 seconds passed")
                const apiKey = '848f660b15a0406d97218e1d721fdb2c';
                var url = `http://newsapi.org/v2/everything?q=bitcoin&from=2020-02-25&to=2020-02-25&sortBy=popularity&apiKey=${apiKey}`;
                const apiKeyWeather = '3b4c6d7b3b9bf7a1e756ffc69c9a7b1a';
                let urlWeather = `http://api.openweathermap.org/data/2.5/weather?q=Tirana&units=metric&APPID=${apiKeyWeather}`

                request(urlWeather, function (err, response, body) {
                    if (err) {
                        response.json({ weather: null, error: 'Error, please try again1' });
                    } else {
                        var weather = JSON.parse(body);

                        if (weather.main.temp > 0) {
                            var weatherText = `It's ${weather.main.temp} °C degrees in ${weather.name}!`;
                            request(url, async function (err, resonse, body) {
                                var getnews = JSON.parse(body);
                                var objective = Object.values(getnews['articles']);
                                var newsTitle = objective[0]['title'];
                                sendMail(req, "Weather and Bitcoin for today", `<p>Bitcoin News for Today:</p><b>${newsTitle}</b><br><p>Weather Forecast for Today:</p><b>${weatherText}</b>`);
                                resolve(200)

                            });
                        }
                    }

                });
            });
        }

    });
}

function uploadToDrive(accessToken, recipe) {
    return new Promise((resolve, reject) => {
        var message = "--foo_bar_baz\nContent-Type: application/json; charset=UTF-8\n\n{\n  \"name\": \"Recipe of the day\"\n}\n\n--foo_bar_baz\nContent-Type: text/plain\n\n" + recipe + "\n--foo_bar_baz--\n\n"

        var options = {
            method: "POST",
            uri: "https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart",
            headers: {
                "Content-Type": "multipart/related; boundary=foo_bar_baz",
                "Authorization": "Bearer " + accessToken
            },
            body: message,
            json: false
        }

        rp(options)
            .then(message => {
                resolve(200)
            })
            .catch(err => {
                reject(500)
            })
    })
}
function parseRecipe(addr) {
    return new Promise((resolve, reject) => {
        var opt = {
            method: "GET",
            uri: addr
        }
        rp(opt)
            .then(recipe => {
                resolve(recipe)
            })
            .catch(err => {
                reject(err)
            })
    })
}

function getRecipe() {
    return new Promise((resolve, reject) => {
        var options = {
            method: "GET",
            uri: "http://taco-randomizer.herokuapp.com/random"
        }
        rp(options)
            .then(obj => {
                var re = JSON.parse(obj);
                var addr = re.mixin.url;
                return parseRecipe(addr);
            })
            .then(recipe => {
                resolve(recipe);
            })
            .catch(er => {
                reject(err);
            })
    })
}

exports.saveRecipeDrive = (accessToken, req) => {
    return new Promise((resolve, reject) => {
        if (req.query.state == "true") {
            schedule.scheduleJob('23 18 * * *', function () {
                getRecipe()
                    .then(recipe => {
                        return uploadToDrive(accessToken, recipe)
                    })
                    .then(() => {
                        resolve(200)
                    })
                    .catch(err => {
                        reject(500)
                    })
            })
        }
    })
}

exports.saveRecipeDriveGmail = (accessToken, req) => {
    return new Promise((resolve, reject) => {
        let rec;
        if (req.query.state == 'true') {
            schedule.scheduleJob('23 18 * * *', function () {
                getRecipe()
                    .then(recipe => {
                        rec = recipe;
                        return uploadToDrive(accessToken, recipe)
                    })
                    .then(recipe => {
                        let subject = "Vegan Recipe for Today"
                        return sendGmail(accessToken, 0, req, subject, rec)
                    })
                    .then(() => {
                        resolve(200);
                    })
                    .catch(err => {
                        reject(500)
                    })
            })
        }
    })
}

exports.weatherGmail = (accessToken, req) => {
    return new Promise((resolve, reject) => {
        if (req.query.state == "true") {
            console.log(req.query.state);
            schedule.scheduleJob('50 16 * * *', function () {
                console.log("+++++1 seconds passed")

                const apiKeyWeather = '3b4c6d7b3b9bf7a1e756ffc69c9a7b1a';
                let urlWeather = `http://api.openweathermap.org/data/2.5/weather?q=Tirana&units=metric&APPID=${apiKeyWeather}`

                request(urlWeather, function (err, response, body) {
                    if (err) {
                        response.json({ weather: null, error: 'Error, please try again1' });
                    } else {
                        var weather = JSON.parse(body);

                        if (weather.main.temp < 18) {
                            var weatherText = `It's ${weather.main.temp} °C degrees in ${weather.name}!`;
                            sendGmail(accessToken, "", req, "Weather today", weatherText)
                            //                            sendMail(req, "Weather today", `<p>Weather Forecast for Today:</p><b>${weatherText}</b>`);
                            resolve(200)
                        }
                    }

                });
            });
        }
    })
}

exports.newsGmail = (accessToken, req) => {
    return new Promise((resolve, reject) => {
        if (req.query.state == "true") {
            console.log(req.query.state);
            schedule.scheduleJob('50 16 * * *', function () {
                var newDate = new Date().toJSON().split("T")[0];
                console.log("newdateee" + newDate);
                console.log("+++++1 seconds passed")
                const apiKey = '848f660b15a0406d97218e1d721fdb2c';
                var url = `http://newsapi.org/v2/everything?q=bitcoin&from=${newDate}&to=${newDate}&sortBy=popularity&apiKey=${apiKey}`;

                request(url, async function (err, resonse, body) {
                    var getnews = JSON.parse(body);
                    var objective = Object.values(getnews['articles']);
                    var newsTitle = objective[0]['title'];
                    var datePublished = objective[0]['publishedAt'];
                    var myDate = new Date().toISOString();
                    var parsedDate = datePublished.substr(0, 10);
                    if (parsedDate == newDate) {
                        sendGmail(accessToken, "", req, "Bitcoin for today", "Bitcoin News for Today: " + newsTitle)
                        //                    sendMail(req, "Bitcoin for today", `<p>Bitcoin News for Today:</p><b>${newsTitle}</b>`);
                        resolve(200);
                    }
                });
            })
        }
    })
}
function getNextTime() {
    return new Promise((resolve, reject) => {
        var options = {
            method: "GET",
            uri: "http://api.open-notify.org/iss-pass.json?lat=41.1533&lon=54.5259&alt=20.1683&n=1"
        }
        rp(options)
            .then(res => {
                var obj = JSON.parse(res)
                var risetime = obj.response[0].risetime
                var date = new Date(risetime * 1000).toString()
                resolve(date)
            })
            .then(err => {
                reject(500)
            })
    })
}

function getCurrentCoordinates() {
    return new Promise((resolve, reject) => {
        var options = {
            method: "GET",
            uri: "http://api.open-notify.org/iss-now.json?"
        }
        rp(options)
            .then(message => {
                var obj = JSON.parse(message);
                var longitude = obj.iss_position.longitude
                var latitude = obj.iss_position.latitude
                //            if(longitude == 20.1683 && latitude == 41.1533)                                            
                resolve(200)

            })
            .catch(err => {
                reject(500)
            })
    })
}

function getNames() {
    return new Promise((resolve, reject) => {
        var options = {
            method: "GET",
            uri: "http://api.open-notify.org/astros.json?"
        }
        rp(options)
            .then(message => {
                var obj = JSON.parse(message)
                var number = obj.number
                let names = []

                for (i = 0; i < number; i++)
                    names.push(obj.people[i].name)
                resolve(names)
            })
            .catch(err => {
                reject(500)
            })
    })
}
exports.getIISMail = (req) => {
    return new Promise((resolve, reject) => {
        if (req.query.state == "true") {
            console.log(req.query.state);
            // schedule.scheduleJob('50 16 * * *', function () {
                let t = null;
                getCurrentCoordinates()
                    .then(() => {
                        return getNextTime()
                    })
                    .then((time) => {
                        t = time
                        return getNames()
                    })
                    .then(names => {
                        let body = "The International Space Station is now on its pass for Albania. There are currently " + names.length + " humans in space. They are:"
                        names.forEach(name => {
                            body = body + "\t" + name + "\n"
                        });
                        body = body + "The upcoming pass for Albania will be: " + t + ".";
                        console.log(body)
                        sendMail(req, "ISS", body)
                        resolve(200)
                    })
                    .catch(err => {
                        reject(500)
                    })
            // })
        }
    })
}


