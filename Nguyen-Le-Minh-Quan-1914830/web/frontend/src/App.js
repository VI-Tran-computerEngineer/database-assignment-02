import React from 'react'
import { Container } from 'react-bootstrap'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'

import Header from './components/Header'
import Home from './components/Home'
import Update from './components/Update'
import CreateManager from './components/CreateManager'
import SearchManager from './components/SearchManager'

const App = () => {
  return (
    <Router>

      <Header />
      <main className="py-3">
        <Container>
          <Routes>
            <Route path="/search" element={<SearchManager />} />
            <Route path="/update/:id" element={<Update />} />
            <Route path="/create" element={<CreateManager />} />
            <Route path="/" element={<Home />} />
          </Routes>
        </Container>
      </main>
    </Router>
  )
}

export default App
