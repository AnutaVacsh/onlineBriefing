import React, { useEffect, useRef, useState } from 'react';
import { Bar } from "react-chartjs-2";

function Anomalies(){
    const [x, setX] = useState([]);
    const chartRef = useRef(null);
    const [subject, setSubject] = useState([]);
    const [selectedSubject, setSelectedSubject] = useState(1);
    const [mark, setMark] = useState([]);
    const [profile, setProfile] = useState();

    useEffect(() => {
        fetch("http://localhost:8080/briefing/allBriefing", {
            mode: 'cors',
            method: 'GET',
        })
        .then(res => res.json())
        .then(data => setX(data))
        .catch((e)=> console.log(e.message))
    }, [])

    if(subject){
          fetch("http://localhost:8080/briefing/getSubjectsByTeacher/"+sessionStorage.getItem('idUser'), {
              mode: 'cors',
              method: 'GET',
          })
          .then(res => res.json())
          .then(data => setSubject(data))
          .catch((e)=> console.log(e.message))
    }

    useEffect(() => {
      fetch("http://localhost:8080/briefing/allProfile", {
          mode: 'cors',
          method: 'GET',
      })
      .then(res => res.json())
      .then(data => setProfile(data))
      .catch((e)=> console.log(e.message))
  }, [])

    const data = ['<20', 'от 20 до 40', 'от 40 до 60', 'от 60 до 80', '>80'].map(item => {
      console.log((mark.filter(m => m.id_profile == item.id && m.answer_mark >= 20).length))
      return(
        {
          data: [
            (mark.filter(m => m.id_profile == item.id && m.answer_mark <= 20).length),
            (mark.filter(m => m.id_profile == item.id && m.answer_mark >= 20 && m.answer_mark < 40).length),
            (mark.filter(m => m.id_profile == item.id && m.answer_mark >= 40 && m.answer_mark < 60).length),
            (mark.filter(m => m.id_profile == item.id && m.answer_mark >= 60 && m.answer_mark < 80).length),
            (mark.filter(m => m.id_profile == item.id && m.answer_mark >= 80 ).length)
          ],
          label: item,
          backgroundColor: "rgba(0, 0, 255, 0.5)",
          fill: true
        }
      )
    })
    

    const barChartData = {
      labels: x.map((item) => "Тема "+ item.number + ": "  + item.title),
      datasets: data
    };
  
    const barChart = (
      <Bar
        type="bar"
        width={130}
        height={50}
        options={{
          title: {
            display: true,
            text: "COVID-19 Cases of Last 3 Months",
            fontSize: 15
          },
          legend: {
            display: true, //Is the legend shown?
            position: "top" //Position of the legend.
          }
        }}
        data={barChartData}
      />
    );

    return(
        <div className='studentGroup'>
            <div className="line">
                <h2>Анализ распределения оценок по летучкам </h2>
                <div></div>
            </div>
            <div className="form">
                <div className="subject">
                    <p>Предмет</p>
                    <select className='short' name="subject" onChange = {e => setSelectedSubject(e.target.value)} >
                    <option value=""></option>
                    {subject.map((item, index) => 
                        <option value = {item.id} key = {index} >{item.title}</option>
                    )}
                </select>
                </div>
            </div>
            {barChart}
        </div>
    )

}
export default Anomalies;