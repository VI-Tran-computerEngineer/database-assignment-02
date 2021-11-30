import Button from "@restart/ui/esm/Button";
import axios from "axios";
import React, { useEffect, useState } from "react";
import { ListGroup, Row, Col, Form, Dropdown } from "react-bootstrap";

const Home = () => {
  const [food, setFood] = useState([]);
  const [listFood, setListFood] = useState([]);
  const [searchKey, setSearchKey] = useState({
    key: "",
    category_id: "all",
  });
  const [updateDish, setUpdateDish] = useState({});
  const [showUpdate, setShowUpdate] = useState(false);
  const [newDish, setNewDish] = useState({});
  const [listCate, setListCate] = useState([]);
  const [showAdd, setShowAdd] = useState(false);

  const onChangeForm = (e) => {
    setUpdateDish({
      ...updateDish,
      [e.target.name]: e.target.value,
    });
  };

  const onChangeNewForm = (e) => {
    setNewDish({
      ...newDish,
      [e.target.name]: e.target.value,
    });
  };

  const onChangeSearch = (e) => {
    setSearchKey({ ...searchKey, [e.target.name]: e.target.value });
  };

  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await axios.get("http://localhost:5000/api/food");
        console.log(res.data);
        if (res.data.success) {
          await setListFood(res.data.products);
          setFood(listFood);
        }
      } catch (error) {
        console.log(error);
      }
    };
    fetchData();
  }, []);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await axios.get("http://localhost:5000/api/food/category");
        console.log(res.data);
        if (res.data.success) {
          setListCate(res.data.products);
        }
      } catch (error) {
        console.log(error);
      }
    };
    fetchData();
  }, []);

  useEffect(() => {
    const setData = async () => {
      if (searchKey.category_id !== "all") {
        setFood(
          listFood.filter((item) => item.category_id === searchKey.category_id)
        );
      } else {
        setFood(listFood);
      }
      if (searchKey.key !== "") {
        const newFood = food.filter(
          (item) =>
            item.dish_name
              .toLowerCase()
              .indexOf(searchKey.key.toLowerCase()) !== -1
        );
        setFood(newFood);
      }
    };
    setData();
  }, [searchKey]);

  const SubmitForm = async () => {
    try {
      const res = await axios.post("http://localhost:5000/api/food/dish/", {
        dish_id: updateDish.dish_id,
        dish_name: updateDish.dish_name,
        dish_image: updateDish.dish_image,
        dish_description: updateDish.dish_description,
        price: parseInt(updateDish.price),
        category_id: updateDish.category_id,
      });
      if (res.data.succes) {
        console.log(res);
      }
    } catch (error) {
      console.log(error);
    }
  };

  const SubmitNewForm = async () => {
    try {
      const res = await axios.post("http://localhost:5000/api/food/new/", {
        dish_id: newDish.dish_id,
        dish_name: newDish.dish_name,
        dish_image: newDish.dish_image,
        dish_description: newDish.dish_description,
        price: parseInt(newDish.price),
        category_id: newDish.category_id,
      });
      if (res.data.succes) {
        console.log(res);
      }
    } catch (error) {
      console.log(error);
    }
  };

  const deleteDish = async (dish_id) => {
    try {
      const res = await axios.post("http://localhost:5000/api/food/delete", {
        dish_id: dish_id,
      });
      if (res.data.success) {
        console.log(res);
        const newArray = food.filter((item) => item.dish_id !== dish_id);
        setFood(newArray);
      }
    } catch (error) {
      console.log(error);
    }
  };
  return (
    <>
      {showUpdate === false && (
        <Form>
          <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea">
            <Form.Label>Search dish</Form.Label>
            <Form.Control
              value={searchKey.key}
              type="text"
              placeholder="search name of the dish"
              onChange={onChangeSearch}
              name="key"
              required
            />
          </Form.Group>
        </Form>
      )}

      {showUpdate && (
        <Form onSubmit={SubmitForm}>
          <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea">
            <Form.Label>Name of dish</Form.Label>
            <Form.Control
              value={updateDish.dish_name}
              type="text"
              placeholder="name"
              onChange={onChangeForm}
              name="dish_name"
              required
            />
          </Form.Group>
          <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea1">
            <Form.Label>Description of dish</Form.Label>
            <Form.Control
              value={updateDish.dish_description}
              as="textarea"
              rows={3}
              name="dish_description"
              onChange={onChangeForm}
              required
            />
          </Form.Group>
          <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea1">
            <Form.Label>Image</Form.Label>
            <Form.Control
              value={updateDish.dish_image}
              type="text"
              rows={3}
              name="dish_image"
              onChange={onChangeForm}
              required
            />
          </Form.Group>
          <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea1">
            <Form.Label>Price</Form.Label>
            <Form.Control
              value={updateDish.price}
              type="number"
              rows={3}
              name="price"
              onChange={onChangeForm}
              required
            />
          </Form.Group>
          <Button
            style={{ background: "blue", border: "none", color: "yellow" }}
            variant="primary"
            type="submit"
          >
            Update dish
          </Button>
        </Form>
      )}
      <Row className="justify-content-center" style={{ marginTop: "20px" }}>
        <Col md={10}>
          <h3>All product</h3>
          <Dropdown style={{ marginBottom: "30px" }}>
            <Dropdown.Toggle variant="primary" id="dropdown-basic">
              Filter category
            </Dropdown.Toggle>

            <Dropdown.Menu>
              <Dropdown.Item
                onClick={() =>
                  setSearchKey({ ...searchKey, category_id: "all" })
                }
              >
                All
              </Dropdown.Item>
              {listCate.map((item) => (
                <Dropdown.Item
                  key={item.category_id}
                  onClick={() =>
                    setSearchKey({
                      ...searchKey,
                      category_id: item.category_id,
                    })
                  }
                >
                  {item.category_name}
                </Dropdown.Item>
              ))}
            </Dropdown.Menu>
          </Dropdown>
          <ListGroup variant="flush">
            <ListGroup.Item
              className="box-shadow2"
              style={{ marginBottom: "10px", borderRadius: "10px" }}
            >
              <Row>
                <Col md={3}>Name</Col>
                <Col md={2}>Image</Col>
                <Col md={2}>Dish Id</Col>
                <Col md={1}>Price</Col>
                <Col md={2}>Amount</Col>
              </Row>
            </ListGroup.Item>
            {food ? (
              food.map((item) => (
                <ListGroup.Item
                  className="box-shadow"
                  style={{ marginBottom: "10px", borderRadius: "10px" }}
                  key={item.dish_id}
                  onClick={() => {
                    setUpdateDish(item);
                    setShowUpdate(!showUpdate);
                  }}
                >
                  <Row className="align-items-center">
                    <Col
                      md={3}
                      style={{
                        height: "100%",
                        alignItems: "center",
                        paddingLeft: "24px",
                      }}
                    >
                      <Row>{item.dish_name}</Row>
                    </Col>
                    <Col
                      md={2}
                      style={{
                        height: "100%",
                        alignItems: "center",
                        paddingLeft: "24px",
                      }}
                    >
                      <Row>{item.dish_image}</Row>
                    </Col>
                    <Col md={2} style={{ height: "100%" }}>
                      {item.dish_id}
                    </Col>
                    <Col md={1}>{item.price}</Col>
                    <Col md={3}>{item.dish_description}</Col>
                    <Col md={1}>
                      <p
                        onClick={() => {
                          deleteDish(item.dish_id);
                        }}
                        style={{ color: "red", fontWeight: "500" }}
                      >
                        Delete
                      </p>
                    </Col>
                  </Row>
                </ListGroup.Item>
              ))
            ) : (
              <h2>No item</h2>
            )}
          </ListGroup>
        </Col>
      </Row>
      <Button
        onClick={() => {
          setShowAdd(!showAdd);
        }}
        style={{
          float: "right",
          marginRight: "150px",
          marginBottom: "100px",
          marginTop: "30px",
        }}
      >
        Add new dish
      </Button>
      {showAdd && (
        <Form onSubmit={SubmitNewForm} style={{ marginTop: "100px" }}>
          <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea">
            <Form.Label>Id of dish</Form.Label>
            <Form.Control
              value={newDish.dish_id}
              type="text"
              onChange={onChangeNewForm}
              name="dish_id"
              required
            />
          </Form.Group>
          <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea">
            <Form.Label>Name of dish</Form.Label>
            <Form.Control
              value={newDish.dish_name}
              type="text"
              onChange={onChangeNewForm}
              name="dish_name"
              required
            />
          </Form.Group>
          <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea1">
            <Form.Label>Description of dish</Form.Label>
            <Form.Control
              value={newDish.dish_description}
              as="textarea"
              rows={3}
              name="dish_description"
              onChange={onChangeNewForm}
              required
            />
          </Form.Group>
          <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea1">
            <Form.Label>Image</Form.Label>
            <Form.Control
              value={newDish.dish_image}
              type="text"
              rows={3}
              name="dish_image"
              onChange={onChangeNewForm}
              required
            />
          </Form.Group>
          <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea1">
            <Form.Label>Price</Form.Label>
            <Form.Control
              value={newDish.price}
              type="number"
              rows={3}
              name="price"
              onChange={onChangeNewForm}
              required
            />
          </Form.Group>
          <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea1">
            <Form.Label>Category</Form.Label>
            <Form.Select
              size="lg"
              name="category_id"
              onChange={onChangeNewForm}
            >
              <option>Category option</option>
              {listCate.map((item) => (
                <option key={item.category_id} value={item.category_id}>
                  {item.category_name}
                </option>
              ))}
            </Form.Select>
          </Form.Group>
          <Button
            style={{ background: "blue", border: "none", color: "yellow" }}
            variant="primary"
            type="submit"
          >
            Add new dish
          </Button>
        </Form>
      )}
    </>
  );
};

export default Home;
