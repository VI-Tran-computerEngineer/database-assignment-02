import {
    MANAGER_LIST_REQUEST,
    MANAGER_LIST_SUCCESS,
    MANAGER_LIST_FAIL,
    DETAIL_MANAGER_REQUEST,
    DETAIL_MANAGER_SUCCESS,
    DETAIL_MANAGER_FAIL,
    DELETE_MANAGER_REQUEST,
    DELETE_MANAGER_SUCCESS,
    DELETE_MANAGER_FAIL,
    CREATE_MANAGER_REQUEST,
    CREATE_MANAGER_SUCCESS,
    CREATE_MANAGER_FAIL,
    UPDATE_MANAGER_REQUEST,
    UPDATE_MANAGER_SUCCESS,
    UPDATE_MANAGER_FAIL,
    SEARCH_MANAGER_REQUEST,
    SEARCH_MANAGER_SUCCESS,
    SEARCH_MANAGER_FAIL
} from '../constants'

export const managerListReducer = (state = {}, action) => {
    switch (action.type) {
        case MANAGER_LIST_REQUEST:
            return { loading: true }
        case MANAGER_LIST_SUCCESS:
            return {
                loading: false,
                managers: action.payload
            }
        case MANAGER_LIST_FAIL:
            return {
                loading: false,
                error: action.payload
            }
        default:
            return state
    }
}

export const managerDetailReducer = (state = {}, action) => {
    switch (action.type) {
        case DETAIL_MANAGER_REQUEST:
            return { loading: true }
        case DETAIL_MANAGER_SUCCESS:
            return {
                loading: false,
                managerD: action.payload
            }
        case DETAIL_MANAGER_FAIL:
            return {
                loading: false,
                error: action.payload
            }
        default:
            return state
    }
}

export const managerDeleteReducer = (state = {}, action) => {
    switch (action.type) {
        case DELETE_MANAGER_REQUEST:
            return { loading: true }
        case DELETE_MANAGER_SUCCESS:
            return {
                loading: false,
                success: true
            }
        case DELETE_MANAGER_FAIL:
            return {
                loading: false,
                error: action.payload
            }
        default:
            return state
    }
}


export const createManagerReducer = (state = {}, action) => {
    switch (action.type) {
        case CREATE_MANAGER_REQUEST:
            return { loading: true }
        case CREATE_MANAGER_SUCCESS:
            return {
                loading: false,
                success: action.payload
            }
        case CREATE_MANAGER_FAIL:
            return {
                loading: false,
                error: action.payload
            }
        default:
            return state
    }
}

export const updateManagerReducer = (state = {}, action) => {
    switch (action.type) {
        case UPDATE_MANAGER_REQUEST:
            return { loading: true }
        case UPDATE_MANAGER_SUCCESS:
            return {
                loading: false,
                success: action.payload
            }
        case UPDATE_MANAGER_FAIL:
            return {
                loading: false,
                error: action.payload
            }
        default:
            return state
    }
}

export const searchManagerReducer = (state = {}, action) => {
    switch (action.type) {
        case SEARCH_MANAGER_REQUEST:
            return { loading: true}
        case SEARCH_MANAGER_SUCCESS:
            return {
                loading: false,
                managerSearch: action.payload
            }
        case SEARCH_MANAGER_FAIL:
            return {
                loading: false,
                error: action.payload
            }
        default:
            return state
            
    }
}