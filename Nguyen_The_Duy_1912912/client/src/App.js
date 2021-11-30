import React from 'react'
import { Container } from 'react-bootstrap'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'

import Header from './components/Header'
import Home from './components/Home'
import Cart from './components/Cart'
import Footer from './components/Footer'

const App = () => {
  return (
    <Router>

      <Header />
      <main className="py-3">
        <Container>
          <Routes>
            <Route path="/cart" component={Cart} />
            <Route path="/" element={<Home />} exact />
          </Routes>
        </Container>
      </main>
    </Router>
  )
}

export default App
