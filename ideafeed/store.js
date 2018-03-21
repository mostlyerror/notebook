const store = require('nedb')
const db = new store({ filename: './ideas', autoload: true })
      
module.exports = db;
