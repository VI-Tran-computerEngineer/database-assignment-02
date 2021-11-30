import { combineReducers, createStore, applyMiddleware } from "redux"
import thunk from 'redux-thunk'
import { composeWithDevTools } from 'redux-devtools-extension'

import { foodListReducer } from "./reducers/gameReducers"

const reducer = combineReducers({
    foodList: foodListReducer,
})

const initialState = {}

const middleware = [thunk]

const store = createStore(reducer, initialState, 
    composeWithDevTools(applyMiddleware(...middleware)))

export default store