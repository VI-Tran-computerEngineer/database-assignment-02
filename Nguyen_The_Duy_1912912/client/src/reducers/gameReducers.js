import {
    FOOD_LIST_REQUEST,
    FOOD_LIST_SUCCESS,
    FOOD_LIST_FAIL
} from '../constants'

export const foodListReducer = (state = {}, action) => {    
    switch (action.type) {
        case FOOD_LIST_REQUEST:
            return { loading: true }
        case FOOD_LIST_SUCCESS:
            return {
                loading: false,
                food: action.payload
            }
        case FOOD_LIST_FAIL: 
            return {
                loading: false,
                error: action.payload
            }
        default:
            return state
    }
}