const mongoose = require("mongoose");
const dbconfig = require("./dbconfig");

const connectingDb = async () => {
    try {
        const connection = await mongoose.connect(dbconfig.url, {
            useNewUrlParser: true,
            useUnifiedTopology: true
        });
        console.log(`Database connected \n id : ${connection.connection.id}  Host : ${connection.connection.host}:${connection.connection.port} Database : ${connection.connection.db.databaseName}`);
    } catch (err) {
        console.log(err);
        process.exit(1);
    }
};

module.exports = connectingDb;