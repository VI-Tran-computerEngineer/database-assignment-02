import React, { useEffect, useState } from 'react'
import { useDispatch, useSelector } from 'react-redux'
import { useParams, useNavigate } from 'react-router-dom'
import { getManagerById } from '../actions/managerActions'
import { Row, Col, Form, Button } from 'react-bootstrap'
import { updateManager } from '../actions/managerActions'

const Update = ({ match }) => {
    const dispatch = useDispatch()
    const navigate = useNavigate()

    const [fname, setFname] = useState('')
    const [minit, setMinit] = useState('')
    const [lname, setLname] = useState('')
    const [age, setAge] = useState(0)
    const [toeic, setToeic] = useState(0)
    const [college, setCollege] = useState('')

    const params = useParams()
    const { managerD } = useSelector(state => state.managerDetail)

    const submitHandler = (e) => {
        e.preventDefault()

        dispatch(updateManager({
            fname, minit,
            lname, age, toeic, college, id: params.id
        }))

        window.location.reload()
    }

    useEffect(() => {
        dispatch(getManagerById(params.id))
    }, [])
    return (
        <>
            <Button className="box-shadow2" onClick={() => navigate('/')}>Back</Button>
            <Row className="justify-content-center">
                {managerD && managerD.map(item => (

                    <Col lg={5}>
                        <Form onSubmit={submitHandler}>
                            <Form.Group
                                className="mb-3" controlId="formBasicPassword">
                                <Form.Label>Age</Form.Label>
                                <Form.Control
                                    className="box-shadow2"
                                    style={{ borderRadius: '6px' }}
                                    type="text" placeholder={item.age}
                                    onChange={(e) => setAge(Number(e.target.value))}
                                />
                            </Form.Group>

                            <Form.Group
                                className="mb-3" controlId="formBasicPassword">
                                <Form.Label>First Name</Form.Label>
                                <Form.Control
                                    className="box-shadow2"
                                    style={{ borderRadius: '6px' }}
                                    type="text" placeholder={item.Fname}
                                    onChange={(e) => setFname(e.target.value)}
                                />
                            </Form.Group>

                            <Form.Group
                                className="mb-3" controlId="formBasicPassword">
                                <Form.Label>Middle Name</Form.Label>
                                <Form.Control
                                    className="box-shadow2"
                                    style={{ borderRadius: '6px' }}
                                    type="text" placeholder={item.Minit}
                                    onChange={(e) => setMinit(e.target.value)}
                                />
                            </Form.Group>


                            <Form.Group
                                className="mb-3" controlId="formBasicPassword">
                                <Form.Label>Last Name</Form.Label>
                                <Form.Control
                                    className="box-shadow2"
                                    style={{ borderRadius: '6px' }}
                                    type="text" placeholder={item.Lname}
                                    onChange={(e) => setLname(e.target.value)}
                                />
                            </Form.Group>

                            <Form.Group
                                className="mb-3" controlId="formBasicPassword">
                                <Form.Label>Toeic Cetification</Form.Label>
                                <Form.Control
                                    className="box-shadow2"
                                    style={{ borderRadius: '6px' }}
                                    type="text" placeholder={item.toeic_certification}
                                    onChange={(e) => setToeic(Number(e.target.value))}
                                />
                            </Form.Group>

                            <Form.Group
                                className="mb-3" controlId="formBasicPassword">
                                <Form.Label>College Certification</Form.Label>
                                <Form.Control
                                    className="box-shadow2"
                                    style={{ borderRadius: '6px' }}
                                    type="text"
                                    placeholder={item.college_certification}
                                    onChange={(e) => setCollege(e.target.value)}
                                />
                            </Form.Group>

                            <Button
                                variant="primary"
                                type="submit"
                                className="box-shadow"
                            >
                                Update
                            </Button>
                        </Form>
                    </Col>
                ))}
            </Row>
        </>
    )
}

export default Update