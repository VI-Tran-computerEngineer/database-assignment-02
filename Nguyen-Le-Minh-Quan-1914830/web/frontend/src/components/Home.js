import React, { useEffect, useState } from 'react'
import { ListGroup, Navbar, Nav, Button, Form, Row, Col, Modal, Accordion } from 'react-bootstrap'
import { useDispatch, useSelector } from 'react-redux'
import { useNavigate } from 'react-router-dom'
import { listAllManagers, deleteManger } from '../actions/managerActions'
import Loader from './Loader'

const Home = () => {
    const navigate = useNavigate()
    const dispatch = useDispatch()

    const managerList = useSelector(state => state.managerList)
    const { loading, managers, error } = managerList

    const [show, setShow] = useState(false)
    const [id, setId] = useState(0)
    const [asc, setAsc] = useState(false)
    const [search, setSearch] = useState('')
    const handleClose = () => setShow(false)
    const handlerShow = (id) => {
        setId(id)
        setShow(true)
    }

    const createManagerHandler = () => {
        navigate('/create')
    }

    const updateHandler = (id) => {
        navigate(`/update/${id}`)
    }

    const deleteHandler = () => {
        setShow(false)
        dispatch(deleteManger(id))
        window.location.reload()
    }

    useEffect(() => {
        dispatch(listAllManagers())
    }, [dispatch])

    const searchHandler = (e) => {
        e.preventDefault()
        navigate(`/search?q=${search}`)
    }


    return (
        <Row className="justify-content-center">
            <Col lg={12}>
                <Form onSubmit={searchHandler}>
                    <Row>
                        <Form.Group as={Col} lg={4}
                            className="mb-3" controlId="formBasicPassword">
                            <Form.Control
                                className="box-shadow2"
                                style={{ borderRadius: '6px' }}
                                type="text" placeholder="Type to search"
                                onChange={(e) => setSearch(e.target.value)}
                            />
                        </Form.Group>
                        <Col>
                            <Button type="submit" className="box-shadow2">Search</Button>
                        </Col>
                    </Row>
                </Form>
                <Accordion defaultActiveKey="0" flush className="box-shadow">
                    <Accordion.Item eventKey="0" style={{ marginTop: '40px' }}>
                        <Accordion.Header>Click here to see all managers</Accordion.Header>
                        <Accordion.Body>
                            <ListGroup variant="flush">
                                <ListGroup.Item
                                    className="box-shadow2"
                                    style={{ marginBottom: '30px', borderRadius: '10px' }}>
                                    <Row >
                                        <Col lg={1}>account_id</Col>
                                        <Col lg={1}>username</Col>
                                        <Col lg={1}>Fname</Col>
                                        <Col lg={1}>Minit</Col>
                                        <Col lg={1}>Lname</Col>
                                        <Col lg={1} onClick={() => console.log(1)}>
                                            <div style={{ display: 'flex' }}>
                                                <div>
                                                    age
                                                </div>
                                                <div className="align-items-center" style={{ paddingLeft: '10px' }}>
                                                    <i stlye={{ paddingLeft: '0px' }} class="fas fa-sort-down"></i>
                                                </div>
                                            </div>
                                        </Col>
                                        <Col lg={1}>Nemployee</Col>
                                        <Col >college_certification</Col>
                                        <Col >toeic_certification</Col>
                                        <Col ></Col>
                                        <Col ></Col>
                                    </Row>
                                </ListGroup.Item>
                                {loading ? <Loader /> : managers ? managers.map(item => (
                                    <ListGroup.Item
                                        className="box-shadow"
                                        style={{ marginBottom: '20px', borderRadius: '10px' }}>
                                        <Row className="align-items-center">
                                            <Col lg={1}>{item.account_id}</Col>
                                            <Col lg={1}>{item.username}</Col>
                                            <Col lg={1}>{item.Fname}</Col>
                                            <Col lg={1}>{item.Minit}</Col>
                                            <Col lg={1}>{item.Lname}</Col>
                                            <Col lg={1}>{item.age}</Col>
                                            <Col lg={1}>{item.Nemployee}</Col>
                                            <Col>{item.college_certification}</Col>
                                            <Col>{item.toeic_certification}</Col>
                                            <Col lg={1}>
                                                <Button
                                                    variant="primary"
                                                    onClick={() => updateHandler(item.account_id)}>Update</Button>
                                            </Col>
                                            <Col lg={1}>
                                                <Button
                                                    variant="danger"
                                                    onClick={() => handlerShow(item.account_id)}>Delete</Button>
                                                <Modal show={show} onHide={handleClose}>
                                                    <Modal.Header closeButton>
                                                        <Modal.Title>WARNING</Modal.Title>
                                                    </Modal.Header>
                                                    <Modal.Body>Are you sure you want to delete this manager?</Modal.Body>
                                                    <Modal.Footer>
                                                        <Button variant="secondary" onClick={handleClose}>
                                                            Close
                                                        </Button>
                                                        <Button variant="danger" onClick={deleteHandler}>
                                                            Delete
                                                        </Button>
                                                    </Modal.Footer>
                                                </Modal>
                                            </Col>
                                        </Row>
                                    </ListGroup.Item>

                                )) : <h2>No Manager</h2>}
                                <Row className="justify-content-center my-2">
                                    <Button
                                        style={{ width: '200px' }}
                                        onClick={createManagerHandler}
                                        className="box-shadow">Add new manager</Button>
                                </Row>
                            </ListGroup>
                        </Accordion.Body>
                    </Accordion.Item>

                </Accordion>
            </Col>
        </Row>
    )
}

export default Home