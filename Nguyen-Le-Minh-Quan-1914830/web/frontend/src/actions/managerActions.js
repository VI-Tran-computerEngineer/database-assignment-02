import axios from 'axios'
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

export const listAllManagers = () => async (dispatch) => {
    try {
        dispatch({ type: MANAGER_LIST_REQUEST })

        const { data } = await axios.get('/manager')

        dispatch({
            type: MANAGER_LIST_SUCCESS,
            payload: data
        })

    } catch (error) {
        dispatch({
            type: MANAGER_LIST_FAIL,
            payload: error.response && error.response.data.message ?
                error.response.data.message : error.message
        })
    }
}

export const getManagerById = (id) => async (dispatch) => {
    try {
        dispatch({ type: DETAIL_MANAGER_REQUEST })

        const { data } = await axios.get(`/manager/${id}`)

        dispatch({
            type: DETAIL_MANAGER_SUCCESS,
            payload: data
        })
    } catch (error) {
        dispatch({
            type: DETAIL_MANAGER_FAIL,
            payload: error.response && error.response.data.message ?
                error.response.data.message : error.message
        })
    }
}

export const deleteManger = (id) => async (dispatch) => {
    try {
        dispatch({ type: DELETE_MANAGER_REQUEST })

        const { data } = await axios.delete(`/manager/${id}`)

        dispatch({
            type: DELETE_MANAGER_SUCCESS,
            payload: data
        })
    } catch (error) {
        dispatch({
            type: DELETE_MANAGER_FAIL,
            payload: error.response && error.response.data.message ?
                error.response.data.message : error.message
        })
    }
}

export const createManager = ({
    username, fname, minit,
    lname, age, toeic, college }) => async (dispatch) => {
        try {
            dispatch({ type: CREATE_MANAGER_REQUEST })

            const { data } = await axios.post('/manager', {
                username, fname, minit,
                lname, age, toeic, college
            })

            dispatch({
                type: CREATE_MANAGER_SUCCESS,
                payload: data
            })
        } catch (error) {
            dispatch({
                type: CREATE_MANAGER_FAIL,
                payload: error.response && error.response.data.message ?
                    error.response.data.message : error.message
            })
        }
    }

export const updateManager = ({
    fname, minit,
    lname, age, toeic, college, id }) => async (dispatch) => {
        try {
            dispatch({ type: UPDATE_MANAGER_REQUEST })

            const { data } = await axios.patch(`/manager/${id}`, {
                fname, minit,
                lname, age, toeic, college
            })

            dispatch({
                type: UPDATE_MANAGER_SUCCESS,
                payload: data
            })
        } catch (error) {
            dispatch({
                type: UPDATE_MANAGER_FAIL,
                payload: error.response && error.response.data.message ?
                    error.response.data.message : error.message
            })
        }
}

export const searchManager = (search) => async (dispatch) => {
    try {
        dispatch({ type: SEARCH_MANAGER_REQUEST })
        
        const { data } = await axios.post('/manager/search', { search })

        dispatch({
            type: SEARCH_MANAGER_SUCCESS,
            payload: data
        })
    } catch (error) {
        dispatch({
            type: SEARCH_MANAGER_FAIL,
            payload: error.response && error.response.data.message ?
                error.response.data.message : error.message
        })
}
}
