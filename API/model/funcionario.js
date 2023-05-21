const mongoose = require('mongoose');


const Schema = mongoose.Schema;

const Funcionario = Schema({
    name: {
        type: String
    },
    email: {
        type: String
    },
    avatarUrl: {
        type: String
    },
    cargo: {
        type: String
    },
},
    {
        collection: 'User'
    });

module.exports = mongoose.model('Funcionario', Funcionario);
