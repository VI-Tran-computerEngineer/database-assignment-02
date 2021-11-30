import React, { useEffect, useState } from 'react'
import { useLocation, useNavigate } from 'react-router-dom'
import { useDispatch, useSelector } from 'react-redux'
import { searchManager } from '../actions/managerActions'
import { ListGroup, Button, Row, Col, Modal } from 'react-bootstrap'
import { deleteManger } from '../actions/managerActions'
import Loader from './Loader'
import Message from './Message'

const SearchManager = () => {
    const location = useLocation()
    const dispatch = useDispatch()

    const { managerSearch, loading, error } = useSelector(state => state.searchManager)
    const managers = managerSearch
    const searchValue = location.search.split('=')[1]
    const navigate = useNavigate()

    const [show, setShow] = useState(false)
    const [id, setId] = useState(0)
    const handleClose = () => setShow(false)
    const handlerShow = (id) => {
        setId(id)
        setShow(true)
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
        dispatch(searchManager(searchValue))
    }, [dispatch])

    return (
        <>
            {loading ? <Loader /> : (
                <>
                    <Button 
                    className="box-shadow2"
                    onClick={() => navigate('/')}>Back</Button>
                    <h2 style={{marginBottom:'30px', marginTop:'20px'}}>You search: {searchValue}. Here is the result:</h2>

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
                        {loading ? <Loader /> : managers ? managers.length > 0 ? managers.map(item => (
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

                        )) : <Message mess="No manager found!"></Message> : <h2>No manager found!</h2>}
                    </ListGroup>
                </>
            )}
        </>
    )
}

export default SearchManager