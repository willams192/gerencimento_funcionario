const mongoose = require('mongoose');
require('../db/config');
const client = require( '../db/config')

const db = client.db("test").collection("user");
  
const Schema  = mongoose.Schema;

let User = new Schema ({
        name:{
            type: String
        },
        email:{
            type: String
        },
        avatarurl:{
            type: String
        },
    }, 
    {
        collection: 'user'
});

module.exports = mongoose.model('user', User);