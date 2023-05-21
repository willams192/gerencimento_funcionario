const mongoose = require('mongoose');


const Schema = mongoose.Schema;

const Funcionario = Schema({
    id: {
        type: String,
        primary: true,
    },
    name: {
        type: String
    },
    email: {
        type: String
    },
    avatarUrl: {
        type: String
    },
},
    {
        collection: 'User'
    });

module.exports = mongoose.model('Funcionario', Funcionario);
