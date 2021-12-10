// db.loadServerScripts()
db.system.js.save({
    "_id" : "InsertDebat",
    "value" : function(data){
            db.debats.insertMany(data, function(err, res) {
            if (err) throw err;
            console.log("Number of documents inserted: " + res.insertedCount);
            });
        }
})

db.system.js.save({
    "_id" : "InsertMember",
    "value" : function(data){
            db.members.insertMany(data, function(err, res) {
            if (err) throw err;
            console.log("Number of documents inserted: " + res.insertedCount);
            });
        }
})