const mongoose = require('mongoose');


const Schema = mongoose.Schema;

let User = Schema({
    name: {
        type: String
    },
    email: {
        type: String
    },
    avatarurl: {
        type: String
    },
},
    {
        collection: 'user'
    });

module.exports = mongoose.model('user', User);