const express = require("express");
const app = express();
const cors = require("cors");

//khoi dong body-parser middleware
app.use(express.urlencoded({ extended: false }));

//khoi dong express middleware
app.use(express.json());
app.use(cors());

//load route
const foodRouter = require("./routes/food");

//route
app.use("/api/food", foodRouter);

app.listen(5000, () => {
  console.log("app running on port 5000");
});
