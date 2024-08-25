import axios from "axios";

// APIのベースURL
const API_BASE_URL = "http://127.0.0.1:8000/api";

export const getHello = async () => {
  try {
    const response = await axios.get(`${API_BASE_URL}/hello/`);
    return response.data;
  } catch (error) {
    console.error("Error fetching articles:", error);
    throw error;
  }
};
