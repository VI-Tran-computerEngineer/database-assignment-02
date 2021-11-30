const router = require("express").Router();

//CREATE
var config = require("../config/dbconfig");
const sql = require("mssql/msnodesqlv8");

//get all food
router.get("/", async (req, res) => {
  try {
    const pool = new sql.ConnectionPool(config);
    pool.connect().then(() => {
      //simple query
      var queryString = "select * from DISHES";
      pool.request().query(queryString, (err, result) => {
        if (err) console.log(err);
        else {
          res.json({
            success: true,
            products: result.recordset,
          });
        }
      });
    });
  } catch (error) {
    console.log(" mathus-error :" + error);
  }
});

//get all category
router.get("/category", async (req, res) => {
  try {
    const pool = new sql.ConnectionPool(config);
    pool.connect().then(() => {
      //simple query
      var queryString = "select * from DISHES_CATEGORIES";
      pool.request().query(queryString, (err, result) => {
        if (err) console.log(err);
        else {
          res.json({
            success: true,
            products: result.recordset,
          });
        }
      });
    });

    console.log("sql server connected...");
  } catch (error) {
    console.log(" mathus-error :" + error);
  }
});

//update dish
router.post("/dish/", async (req, res) => {
  try {
    const pool = new sql.ConnectionPool(config);
    pool.connect().then(() => {
      //simple query
      console.log(req.body);
      var queryString =
        `UPDATE DISHES SET dish_name=` +
        `'${req.body.dish_name}'` +
        `, dish_id=` +
        `'${req.body.dish_id}'` +
        `, dish_image=` +
        `'${req.body.dish_image}'` +
        `, dish_description=` +
        `'${req.body.dish_description}'` +
        `, price=` +
        `${req.body.price}` +
        `, category_id=` +
        `'${req.body.category_id}'` +
        ` WHERE dish_id=` +
        `'${req.body.dish_id}'`;
      console.log(queryString);
      pool.request().query(queryString, (err, result) => {
        if (err) console.log(err);
        else {
          res.json({
            success: true,
            message: "data updated",
          });
        }
      });
    });

    console.log("sql server connected...");
  } catch (error) {
    console.log(" mathus-error :" + error);
  }
});

//update category
router.post("/category/:id", async (req, res) => {
  try {
    const pool = new sql.ConnectionPool(config);
    pool.connect().then(() => {
      //simple query
      console.log(req.body);
      var queryString =
        `UPDATE DISHES_CATEGORIES SET category_id=` +
        `'${req.body.category_id}'` +
        `, category_name=` +
        `'${req.body.category_name}'` +
        `, category_description=` +
        `'${req.body.category_description}'` +
        ` WHERE category_id=` +
        `'${req.body.category_id}'`;
      console.log(queryString);
      pool.request().query(queryString, (err, result) => {
        if (err) console.log(err);
        else {
          res.json({
            success: true,
            message: "category data updated",
          });
        }
      });
    });

    console.log("sql server connected...");
  } catch (error) {
    console.log(" mathus-error :" + error);
  }
});

router.post("/new", async (req, res) => {
  try {
    const pool = new sql.ConnectionPool(config);
    pool.connect().then(() => {
      //simple query
      console.log(req.body);
      var queryString =
        `EXEC insert_dishes @dish_id =` +
        `'${req.body.dish_id}'` +
        `,@dish_name = ` +
        `'${req.body.dish_name}'` +
        `,@dish_image = ` +
        `'${req.body.dish_image}'` +
        `,@dish_description = ` +
        `'${req.body.dish_description}'` +
        `,@price= ` +
        `${req.body.price}` +
        `,@category_id= ` +
        `'${req.body.category_id}'`;

      console.log(queryString);
      pool.request().query(queryString, (err, result) => {
        if (err) console.log(err);
        else {
          res.json({
            success: true,
            message: "add new product successfully",
          });
        }
      });
    });

    console.log("sql server connected...");
  } catch (error) {
    console.log(" mathus-error :" + error);
  }
});

router.post("/delete", async (req, res) => {
  try {
    const pool = new sql.ConnectionPool(config);
    pool.connect().then(() => {
      //simple query
      console.log(req.body);
      var queryString =
        `DELETE FROM DISHES WHERE dish_id=` + `'${req.body.dish_id}'`;

      console.log(queryString);
      pool.request().query(queryString, (err, result) => {
        if (err) console.log(err);
        else {
          res.json({
            success: true,
            message: "delete successfully",
          });
        }
      });
    });

    console.log("sql server connected...");
  } catch (error) {
    console.log(" mathus-error :" + error);
  }
});
module.exports = router;
