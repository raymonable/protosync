console.log('ProtoSYNC V1.0.0');

const Express = require('express');
const Tunnel = require('localtunnel');
var App = Express();
App.use(Express.json());

var ToServe = "";
var URL = null;

App.get('/ingame', async(req, res) => {
    res.send(ToServe || 'print("You must sync a script first!")');
});

App.get('/tunnel', async(req, res) => {
    res.send(`${URL + '/ingame' || 'Unavailable. Please try again in a moment.'}`);
})

App.post('/plugin', async(req, res) => {
    if (req.body.pwd == "super roblox") {
        ToServe = req.body.script
        res.send({
            ok: true
        })
    } else {
        res.send({
            error: 'bad password lol'
        }, 401)
    }
});

App.listen(4400, () => {
    console.log('ProtoSYNC ready at 4400');
});

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
ProtoTunnel();
