console.log('ProtoSYNC V2.0');

const Express = require('express');
const Tunnel = require('localtunnel');
var App = Express();
App.use(Express.json());

var ToServe = 'print("You must sync a script first!")';
var URL = null;

var Configuration = {
    port: 4400,
    password: 'soup',
    whitelist: []
}
var LoggedUsers = {};

var ProtoTunnel = () => {
    Tunnel({
        port: 4400
    }).then((tunnel) => {
        console.log('ProtoTUNNEL ready');
        URL = tunnel.url;
        tunnel.on('close', () => {
            console.log('The ProtoTUNNEL closed unexpectedly.');
            URL = null;
            setTimeout(() => {
                ProtoTunnel();
            }, 2500);
        })
    })
}

App.get('/ingame', async(req, res) => {
    res.header('Content-Type', 'text/plain');
    res.send(`local p=pcall;local l=loadstring;local h=game:GetService("HttpService");local s,c=p(function()return h:PostAsync("${URL}/ingame",h:JSONEncode({u=owner.Name}))end);if s then l(c)() else print('Unable to fetch :(') end`)
});
App.post('/ingame', async(req, res) => {
    if (!req.body.u) {
        return
    }
    LoggedUsers[req.body.u] = true;
    if (!!Configuration.whitelist[req.body.u]) {
        res.send(ToServe);
    } else {
        res.send('print("You\'re not on the whitelist.")');
    }
});

App.post('/plugin/sync', async(req, res) => {
    if (req.body.pwd == Configuration.password) {
        ToServe = req.body.source
        res.send({
            ok: true
        })
    } else {
        res.send({
            error: 'bad password'
        }, 401)
    }
});
App.post('/plugin/configuration', async(req, res) => {
    if (req.body.pwd == Configuration.password) {
        Configuration.port = req.body.config.port || Configuration.port;
        Configuration.whitelist = req.body.config.whitelist || Configuration.whitelist;
        res.send({
            ok: true
        })
    }
});
App.post('/plugin/uses', async(req, res) => {
    if (req.body.pwd == Configuration.password) {
        res.send(LoggedUsers)
    }
});
App.get('/plugin/tunnel', async(req, res) => {
    res.send(URL + '/ingame');
});

App.listen(4400, () => {
    console.log('ProtoSYNC ready at 4400');
    ProtoTunnel();
});