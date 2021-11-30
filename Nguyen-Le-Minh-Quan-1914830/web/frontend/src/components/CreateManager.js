import React, { useState, useEffect } from 'react'
import { Row, Col, Form, Button, Toast } from 'react-bootstrap'
import { useNavigate } from 'react-router-dom'
import { createManager } from '../actions/managerActions'
import { useDispatch, useSelector } from 'react-redux'
import Message from '../components/Message'


const CreateManager = () => {
    const navigate = useNavigate()
    const [username, setUsername] = useState('')
    const [fname, setFname] = useState('')
    const [minit, setMinit] = useState('')
    const [lname, setLname] = useState('')
    const [age, setAge] = useState(0)
    const [toeic, setToeic] = useState(0)
    const [college, setCollege] = useState('')
    const [showA, setShowA] = useState(false);
    const toggleShowA = () => setShowA(!showA);
    const dispatch = useDispatch()

    const { loading, error, success } = useSelector(state => state.createManager)


    const submitHandler = (e) => {
        e.preventDefault()

        if (error) setShowA(!showA)

        dispatch(createManager({
            username, fname, minit,
            lname, age, toeic, college
        }))
    }

    useEffect(() => {

    }, [dispatch])
    return (
        <>
            <Button className="box-shadow" onClick={() => navigate('/')}>Back</Button>
            <Row className="justify-content-center">
                <Col lg={5}>
                    {success && 
                    success.success && 
                    <Message mess="Create manager succesfully!" variant="success"></Message>}
                    <Toast bg="danger" show={showA} onClose={toggleShowA} style={{ width: '440px' }}>
                        <Toast.Header>
                            <strong className="me-auto">HAVE ERROR!</strong>
                        </Toast.Header>
                        <Toast.Body>{"Can't create manager! Maybe the username has been duplicated"}</Toast.Body>
                    </Toast>
                    <Form onSubmit={submitHandler}>
                        <Form.Group
                            className="mb-3" controlId="formBasicPassword">
                            <Form.Label>Username</Form.Label>
                            <Form.Control
                            className="box-shadow2"
                                style={{ borderRadius: '6px' }}
                                type="text" placeholder="Enter username"
                                onChange={(e) => setUsername(e.target.value)}
                                onFocus={() => setShowA(false)}/>
                        </Form.Group>

                        <Form.Group
                            className="mb-3" controlId="formBasicPassword">
                            <Form.Label>Age</Form.Label>
                            <Form.Control
                            className="box-shadow2"
                                style={{ borderRadius: '6px' }}
                                type="text" placeholder="Enter publisher"
                                onChange={(e) => setAge(Number(e.target.value))}
                                onFocus={() => setShowA(false)} />
                        </Form.Group>

                        <Form.Group
                            className="mb-3" controlId="formBasicPassword">
                            <Form.Label>First Name</Form.Label>
                            <Form.Control
                            className="box-shadow2"
                                style={{ borderRadius: '6px' }}
                                type="text" placeholder="Enter first name"
                                onChange={e => setFname(e.target.value)}
                                onFocus={() => setShowA(false)} />
                        </Form.Group>

                        <Form.Group
                            className="mb-3" controlId="formBasicPassword">
                            <Form.Label>Middle Name</Form.Label>
                            <Form.Control
                            className="box-shadow2"
                                style={{ borderRadius: '6px' }}
                                type="text" placeholder="Enter middle name"
                                onChange={e => setMinit(e.target.value)}
                                onFocus={() => setShowA(false)} />
                        </Form.Group>


                        <Form.Group
                            className="mb-3" controlId="formBasicPassword">
                            <Form.Label>Last Name</Form.Label>
                            <Form.Control
                            className="box-shadow2"
                                style={{ borderRadius: '6px' }}
                                type="text" placeholder="Enter last name"
                                onChange={e => setLname(e.target.value)}
                                onFocus={() => setShowA(false)} />
                        </Form.Group>

                        <Form.Group
                            className="mb-3" controlId="formBasicPassword">
                            <Form.Label>Toeic Cetification</Form.Label>
                            <Form.Control
                            className="box-shadow2"
                                style={{ borderRadius: '6px' }}
                                type="text" placeholder="Enter toeic certification"
                                onChange={e => setToeic(Number(e.target.value))}
                                onFocus={() => setShowA(false)} />
                        </Form.Group>

                        <Form.Group
                            className="mb-3" controlId="formBasicPassword">
                            <Form.Label>College Certification</Form.Label>
                            <Form.Control
                            className="box-shadow2"
                                style={{ borderRadius: '6px' }}
                                type="text"
                                placeholder="Enter college certification"
                                onChange={e => setCollege(e.target.value)}
                                onFocus={() => setShowA(false)} />
                        </Form.Group>

                        <Button
                            variant="primary"
                            type="submit"
                            className="box-shadow"
                        >
                            Submit
                        </Button>
                    </Form>
                </Col>
            </Row>
        </>
    )
}

export default CreateManager