import React from 'react'
import { Container, Row, Col } from 'react-bootstrap'
import { Link } from 'react-router-dom'

const Footer = () => {
    return (
        <footer className='p-4 bg-dark' >
        <Container fluid className='text-center' >
          <Row style={{justifyContent:'center'}}>
            <Col md={3}>
              <Link to='/' style={{fontSize:'20px'}} className='text-white text-decoration-none'>GROUP: TVDQ</Link>
              <p className='small text-white-50 font-weight-light mt-3'>
                @2001-2021, HCMUT, VietNam
              </p>
            </Col>
            <Col md={6} className='small'>
                <Row className='mb-3'>
                  <Col  md={3} >
                    <Link to='/aboutus' className='text-white text-decoration-none'>
                      About Us
                    </Link>
                  </Col>
                  <Col md={3}>
                    <Link to='/helpcenter' className='text-white text-decoration-none'>
                      Help Center
                    </Link>
                  </Col>
                  <Col md={3}>
                    <Link to='/submityourgames' className='text-white text-decoration-none'>
                      Submit Your Games
                    </Link>
                  </Col>
                  <Col md={3}>
                    <Link to='/contactus' className='text-white text-decoration-none'>
                      Contact Us
                    </Link>
                  </Col>
                </Row>
                <Row >
                <Col md={3} >
                    <Link to='/privacypolicy' className='text-white-50 text-decoration-none'>
                      Privacy Policy
                    </Link>
                  </Col>
                  <Col md={3}>
                    <Link to='/cookies' className='text-white-50 text-decoration-none'>
                      Cookies
                    </Link>
                  </Col>
                  <Col md={3}>
                    <Link to='/terms' className='text-white-50 text-decoration-none'>
                      Terms
                    </Link>
                  </Col>
                  <Col md={3}>
                    <Link to='/legal' className='text-white-50 text-decoration-none'>
                      Legal
                    </Link>
                  </Col>
                </Row>
            </Col>
          </Row>
        </Container>
      </footer>
    )
}
export default Footer
