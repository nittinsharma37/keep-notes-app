const notesDb = require("../model/notesmodel");


//creating note
exports.createNote = (req, res) => {
    //validating request 
    if (!req.body.content) {
        return res.status(404).send({
            message: "Note Cannot be empty"
        });
    }

    //creating a note
    const note = new notesDb({
        title: req.body.title || "Untitled Note!",
        content: req.body.content
    });

    //saving note in the database
    try {
        note.save().then((data) => {
            res.send(data)
        }).catch((err) => {
            res.status(500).send({
                message: err.message || "There is a problem while creating Notes!"
            });
        });
    } catch (error) {
        console.log(error)
    }


};

// showing all notes
exports.showAllNotes = (req, res) => {
    notesDb.find().then((data) => {
        if (!data) {
            res.status(404).send({
                message: "Item not found"
            });
        } else {
            res.send(data);
        }

    }).catch((err) => {
        res.status(500).send({
            message: err.message || "There is a problem while getting notes!"
        });
    });
};

//show one note
exports.showOneNote = (req, res) => {
    const id = req.params.noteId;
    notesDb.findById(id)
        .then((data) => {
            if (!data) {
                res.status(404).send({
                    message: "Item not found"
                });
            }
            res.send(data);
        }).catch((err) => {
            res.status(500).send({
                message: err.message || "There is a problem while gettting data"
            });
        });
};


//update note
exports.updateNote = (req, res) => {
    //validating request 
    if (!req.body.content) {
        return res.status(400).send({
            message: "Note content cannot be empty"
        });
    }
    //finding note and updating note with id
    const id = req.params.noteId;
    notesDb.findByIdAndUpdate(id, req.body, {
        new: true,
        useFindAndModify: false
    }).then((data) => {
        res.send(data);
    }).catch((err) => {
        res.status(500).send({
            message: err.message || "There is a problem while updating data"
        });
    });
};


//delete note
exports.deleteNote = (req, res) => {
    //getting id 
    const id = req.params.noteId;
    notesDb.findByIdAndDelete(id).then((data) => {
        if (!data) {
            return res.status(404).send({
                message: "Note not found"
            });
        }
        res.send({message: "Note deleted successfully!"});

    }).catch((err) => {
        res.status(500).send({
            message: err.message || "There is a problem while deleting data"
        });
    });
};