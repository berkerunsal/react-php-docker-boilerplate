import { useState, useEffect } from "react";
import axios from "axios";
const apiUrl = import.meta.env.VITE_API_URL;

const TestEndpoint = () => {
  const [data, setData] = useState();

  useEffect(() => {
    axios
      .get(`${apiUrl}api/test-endpoint.php`)
      .then((response) => {
        if (response.data.status === "success") {
          setData(response.data);
        }
      })
      .catch((error) => {
        console.error("Error fetching data:", error);
      });
  }, []);
  return (
    <>
      {data ? (
        <>
          <h2>{data.message} 🚀 </h2>
          <p>Meaning that your PHP + React App is running succesfully.</p>
          <p>Happy coding! 🎉</p>

        </>
      ) : (
        <div>PHP API conection failed.</div>
      )
      }
    </>
  )

};

export default TestEndpoint;
