const express = require("express");

const mongoose = require("mongoose");

const adminRouter = require("./route/admin");

const authRouter = require('./route/auth');
const productRouter = require("./route/product");
const userRouter = require("./route/user");

const PORT = process.env.PORT || 3000;
const app = express();
const DB = 
"mongodb+srv://nishaan:nishaans1@cluster0.bomk7hn.mongodb.net/?retryWrites=true&w=majority";

//middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);


//connections
mongoose
.connect(DB)
.then(() => {
    console.log('Connection Successful');
})
.catch(e => {
    console.log(e);
});

app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected at port ${PORT}`);
});
