const mongoose = require('mongoose');


const Schema = mongoose.Schema;

const User = Schema({
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
        collection: 'user'
    });

module.exports = mongoose.model('user', User);
