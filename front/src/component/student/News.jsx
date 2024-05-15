import {useState, useEffect } from "react";

function News(){
 const [listBr, setListBr] = useState([]);
const profile = sessionStorage.getItem("profile")
console.log(profile)

useEffect(() => {
  // fetch("http://localhost:8080/briefing/getNews/"+{profile}, {
    fetch("http://localhost:8080/briefing/getNews/1", {
      mode: 'cors',
      method: 'GET',
  })
  .then(res => res.json())
  .then(data => setListBr(data))
  .catch((e)=> console.log(e.message))
}, [])

const elBr = listBr.map((item)=> {

  return <div className="elBriefing" >
      <p className="title">{item.title}<span>{item.date}</span></p>
      <p>{item.text}</p>
      
  </div>
  }
)

return(
  <div className="news">
      <div className="listBriefing">
          {elBr}
      </div>
  </div>
)
}
export default News;
