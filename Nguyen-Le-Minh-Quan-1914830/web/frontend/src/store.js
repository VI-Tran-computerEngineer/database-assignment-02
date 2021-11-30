import { combineReducers, createStore, applyMiddleware } from "redux"
import thunk from 'redux-thunk'
import { composeWithDevTools } from 'redux-devtools-extension'

import { managerListReducer, 
    managerDetailReducer, 
    managerDeleteReducer,
    createManagerReducer,
    updateManagerReducer,
    searchManagerReducer 
} from "./reducers/managerReducers"

const reducer = combineReducers({
    managerList: managerListReducer,
    managerDetail: managerDetailReducer,
    managerDeleted: managerDeleteReducer,
    createManager: createManagerReducer,
    updateManager: updateManagerReducer,
    searchManager: searchManagerReducer
})

const initialState = {}

const middleware = [thunk]

const store = createStore(reducer, initialState, 
    composeWithDevTools(applyMiddleware(...middleware)))

export default store