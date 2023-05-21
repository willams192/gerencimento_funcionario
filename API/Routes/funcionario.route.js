const express = require('express');
const funcionario = require('../model/funcionario');
const app = express();
const funcionarioRoutes = express.Router();



let Funcionario = require('../model/funcionario')

funcionarioRoutes.route('/add').post(async function (req, res) {
    let funcionario = new Funcionario(req.body);
    funcionario.save()
        .then(result => {
            console.log(result); // Verificar se o ID está presente no resultado
            const newUserId = result._id.toString(); // Obtém o valor do ID como uma string
            res.status(200).json({ '_id': newUserId });
        })
        .catch(err => {
            res.status(409).json({ 'status': 'failure', 'msg': 'usuário não cadastrado' + err.message })
        });
});






// api puxando os usuários
funcionarioRoutes.route('/').get(function (req, res) {
    Funcionario.find(function (err, funcionarios) {
        if (err) {
            res.status(400).send({ 'status': 'failure', 'msg': 'Algo deu errado' })
        } else {
            res.status(200).json({ 'status': 'sucess', 'funcionarios': funcionarios });
        };
    });
});


// usuario especifico
funcionarioRoutes.route('/funcionario/:id').get(function (req, res) {
    let id = req.params.id;
    Funcionario.findById(id, function (err, funcionario) {
        if (err) {
            res.status(400).send({ 'status': 'failure', 'msg': 'Algo deu errado' })
        }
        else {
            res.status(200).json({ 'status': 'sucess', 'funcionarios': funcionario });
        };
    });

});


funcionarioRoutes.route('/update/:id').put(function (req, res) {
    Funcionario.findById(req.params.id, function (err, funcionario) {
        if (!funcionario) {
            res.status(404).send({ 'status': 'failure', 'msg': 'Usuário não encontrado' })
        } else {
            Object.assign(funcionario, req.body);
            funcionario.save().then(() => {
                res.status(200).json({ 'status': 'success', 'msg': 'Usuário atualizado com sucesso' })
            }).catch(err => {
                res.status(500).json({ 'status': 'failure', 'msg': 'Erro ao atualizar usuário' })
            });
        };
    });
});

funcionarioRoutes.route('/delete/:id').delete(function (req, res) {
    Funcionario.findByIdAndRemove({ _id: req.params.id }, function (err,) {
        if (err) {
            res.status(400).send({ 'status': 'failure', 'msg': 'Algo deu errado' })
        } else {
            res.status(200).json({ 'staus': 'sucess', 'msg': 'Usuário deletado' })
        };
    });
});


module.exports = funcionarioRoutes;