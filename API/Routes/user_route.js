const express = require('express');
const user = require('../model/user');
const app = express();
const userRoutes = express.Router();



let  User = require('../model/user')

// adiciona o usuário
userRoutes.route('/add').post(async function(req, res){

    let user = new User(req.body);

    user.save()
    .then(res => {
        res.status(200).json({'status': 'sucess', 'msg': 'usuário cadastrado com sucesso'});
    })
    .catch(err => {
        res.status(409).json({'status': 'failure', 'msg':'usuário não cadastrado'})
    });

   
})

// api puxando os usuários
userRoutes.route('/').get(function(req,res){
    User.find(function(err, users){
        if(err){
            res.status(400).send({'status':'failure', 'msg':'Algo deu errado'})
        }else{
            res.status(200).json({'status': 'sucess', 'users': users});
        };
    });
});


// usuario especifico
userRoutes.route('/user/:id').get(function(req, res){
    let id = req.params.id;
    User.findById(id, function(err, user){
        if(err){
            res.status(400).send({'status': 'failure', 'msg': 'Algo deu errado'})
        }
        else{
            res.status(200).json({'status': 'sucess', 'users': user});
        };
    });

});


userRoutes.route('/update/:id').put(function(req, res){
    let id = req.params.id;        
    User.findById(id, function(err, user){
        if(!user){
            res.status(400).send({'status': 'failure', 'msg':'Não foi possivel Atualizar esse campo'})
        }else{
            user.save().then(business =>{
                res.status(200).json({'staus': 'sucess', 'msg': 'Atualização concluída'})
            })
        };
    });
});

userRoutes.route('/delete/:id').delete(function(req,res){
    User.findByIdAndRemove({_id: req.params.id}, function(err,){
        if(err){
            res.status(400).send({'status': 'failure', 'msg':'Algo deu errado'})
        }else{
            res.status(200).json({'staus': 'sucess', 'msg': 'Usuário deletado'})
        };
    });
});


module.exports  = userRoutes;