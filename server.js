const express = require('express');
const conn = require('./db/conn');
const app = express();
const BP = require('body-parser');
const {serverPort, secret, publicFolder} = require('./config/config');
const {userResponse, validateUser, validateAdmin} = require('./config/user.config');
app.use(BP.json());
app.use(BP.urlencoded({extended:true}));

const dreamtrips = require('./route/route.dreamtrips');
const data = require('./route/route.data');

app.get('/api/hello', (req, res)=>res.json({world:"hello"}));

app.use('/dreamtrips', dreamtrips);

app.use('/data', data)

app.use('/', express.static(publicFolder)); //this is available for all users

//app.all('*', validateUser); //this is a gateway for online users only

//app.all('*', validateAdmin); //this is a gateway for admins only

const startServer = () =>app.listen(serverPort, ()=>console.log(`server up on port ${serverPort}`));

startServer();