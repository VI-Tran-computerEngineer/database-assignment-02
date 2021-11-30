import axios from "axios";
import {
  FOOD_LIST_REQUEST,
  FOOD_LIST_SUCCESS,
  FOOD_LIST_FAIL,
} from "../constants";

export const listAllFood = () => async (dispatch) => {
  try {
    dispatch({ type: FOOD_LIST_REQUEST });

    const { data } = await axios.get("http://localhost:5000/api/food");

    dispatch({
      type: FOOD_LIST_SUCCESS,
      payload: data,
    });
  } catch (error) {
    dispatch({
      type: FOOD_LIST_FAIL,
      error:
        error.response && error.response.data.message
          ? error.response.data.message
          : error.message,
    });
  }
};
